import re, os, sys, json, gnupg, boto3, logging, argparse
from datetime import datetime
from utils.file_utils import read_json_file, read_lines, read_multi_files
from utils.docker_utils import ecr_login, tm_login
from utils.ecr_utils import create_repository
from utils.sync_utils import throttle_handler, sync_image
from glob import glob

tm_token = os.environ.get("LOCAL_TM_TOKEN_VAR")


logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')
logger = logging.getLogger()
file_handler = logging.FileHandler('sync-error.log')
file_handler.setLevel(logging.ERROR)
file_handler.setFormatter(logging.Formatter('%(levelname)s: %(message)s'))
logger.addHandler(file_handler)


cli=argparse.ArgumentParser()
cli.add_argument('--srcusr', type=str, default='_tm')
cli.add_argument('--srcpasswd', type=str, default=tm_token)
cli.add_argument('--srcdomain', type=str, default='docker.external.thoughtmachine.io')
cli.add_argument('--trgprefix', type=str, default='/3rdparty/tm/')
cli.add_argument('--trgregion', type=str, default='eu-central-1')
cli.add_argument('--src_packages_postfix', type=str, default='images.txt')
cli.add_argument('--src_release_postfix', type=str, default='release.json')
cli.add_argument('--trg_ecr_policy_file_path', type=str, default='awsaccounts_read_binaries.txt')
cli.add_argument('--trg_ecr_image_untagged_delete_days', type=int, default=2)
cli.add_argument('--trg_resource_tags_file_path', type=str, default='resource_tags.json')
cli.add_argument('--trg_kms_key_alias', type=str)
cli.add_argument('--trg_dst_security_scan_enabled', type=bool, default=False)
cli.add_argument('--throttle_ecr_creation_ms', type=int, default=100)
cli.add_argument('--src_attestions_address', type=str, default='https://attestations.external.thoughtmachine.io/v1beta1/projects/tm-attestations-project/notes/tm-release-attestor-note/occurrences')
cli.add_argument('--gnupgdir', type=str, default='/root/.gnupg')
cli.add_argument('--src_attestor', type=str, default='src_attestor.pgp')


args = cli.parse_args()
src_username = args.srcusr
src_password = args.srcpasswd
src_registry = args.srcdomain
trg_prefix = re.sub('^\/|\/$', '', args.trgprefix)
trg_region = args.trgregion
image_filepaths = args.src_packages_postfix
release_filepaths = args.src_release_postfix
policy_filepath = args.trg_ecr_policy_file_path
dst_lifecycle_days=args.trg_ecr_image_untagged_delete_days
resource_tags_filepath = args.trg_resource_tags_file_path
kms_key = args.trg_kms_key_alias
dst_security_scan = args.trg_dst_security_scan_enabled
throttle_limit = args.throttle_ecr_creation_ms
src_attestions_address = args.src_attestions_address
gnupgdir = args.gnupgdir
src_attestor = args.src_attestor


gpg = gnupg.GPG(gnupghome=gnupgdir)
key_data = open(src_attestor, "rb").read()
gpg.import_keys(key_data).results


dst_client = boto3.client('ecr', region_name=trg_region)
aws_account_id = boto3.client('sts').get_caller_identity().get('Account')
dst_registry = f'{aws_account_id}.dkr.ecr.{trg_region}.amazonaws.com'


dst_resource_tags = read_json_file(resource_tags_filepath)
dst_repo_policy = read_lines(policy_filepath)


def main():
    images_data = {}
    ignored_images_count = 0
    total_release_images_count = 0
    prepared_images_count = 0
    synced_images_count = 0

    for file in glob(f"*{release_filepaths}"):
        logger.info(f"Start data gathering from {file}")
        no_txt_file = True
        src_images = []
        version_prefix = file.split('_')[0]
        txt_src_file = f"{version_prefix}*{image_filepaths}"
        data = read_json_file(file)

        if glob(txt_src_file):
            logger.info(f"*images.txt file is found for {version_prefix}")
            no_txt_file = False
            src_images = read_multi_files(txt_src_file)

        for image_data in data['metadata']['images'].values():
            total_release_images_count += 1
            if no_txt_file or image_data['dest'] in src_images:
                images_data[image_data['dest']] = image_data['source']
                prepared_images_count += 1
            else:
                ignored_images_count += 1
                logger.info(f"{image_data['dest']} is ignored")


    if ecr_login(dst_client) and tm_login(src_registry, src_username, src_password):
        for dest, src in images_data.items():
            logger.info(f"START syncing {src}")
            fqin = src
            digest = fqin.split('@')[-1]
            repo, tag = dest.split(':')

            src_image_params = {'fqin': fqin, 'digest': digest, 'repo': repo, 'tag': tag}
            dst_repo_name = f"{trg_prefix}/{repo}"
            dst_repo_tag = f"{dst_registry}/{dst_repo_name}:{tag}"

            t_start = datetime.now()
            create_repository(dst_client, dst_repo_name, dst_repo_policy,
                dst_lifecycle_days, kms_key, dst_resource_tags, dst_security_scan)
            sync_image(src_image_params, src_attestions_address, src_password,
                dst_repo_name, dst_repo_tag, dst_client, gpg)
            throttle_handler(t_start, throttle_limit)
            synced_images_count += 1
    else:
        sys.exit("Login failed")

    logger.info(f"total_release_images_count: {total_release_images_count}, ignored_images_count: {ignored_images_count}, prepared_images_count: {prepared_images_count}, synced_images_count: {synced_images_count}")


if __name__ == "__main__":
    main()
