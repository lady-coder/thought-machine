import logging, re, requests, base64
from time import sleep
from datetime import datetime
from subprocess import check_output, CalledProcessError, PIPE


logger = logging.getLogger(__name__)


def throttle_handler(start_time, throttle_limit):
    dt = datetime.now() - start_time
    dt_ms = round(dt.total_seconds()*1000)
    if throttle_limit > dt_ms: 
        t = (throttle_limit - dt_ms)/1000
        logger.info(f"Sleep in {t}s")
        sleep(t)


def sync_image(src_image_params, attestions_address, attestions_password, dst_image, dst_image_tag, dst_client, gpg):
    if not __image_exist(dst_client, dst_image, src_image_params['tag'], src_image_params['digest']) \
        and __attestion(attestions_address, src_image_params['fqin'], attestions_password, gpg):
        try:
            cmd = ['crane', 'copy', src_image_params['fqin'], dst_image_tag]
            check_output(cmd, universal_newlines=True, stderr=PIPE).splitlines()
            logger.info(f"SUCCEEDED: source image {src_image_params['fqin']} migrated to dest image: {dst_image}")
            return True
        except CalledProcessError as e:
            logger.error(f"An error occurred with source image: {src_image_params['fqin']}\ndest image: {dst_image}\n{e.stderr}")
    return False


def get_image_params(image, release_info):
    if image in release_info:
        fqin = release_info.get(image)
        digest = fqin.split('@')[-1]
        repo, tag = image.split(':')
        return {'fqin': fqin, 'digest': digest, 'repo': repo, 'tag': tag}
    return {}


def __attestion(attestions_address, fqin, password, gpg):
    fqin = re.sub(r':[^@]+(?=@)', '', fqin)
    headers = {
        'Authorization': 'Bearer {}'.format(password),
    }
    params = {
        'filter': 'resourceUrl="https://{}"'.format(fqin)
    }
    response = (requests.get(attestions_address, headers=headers, params=params)).json()
    if response:
        if "pgpSignedAttestation" in response:
            attestation = response.get('occurrences')[0].get('attestation').get('pgpSignedAttestation').get('signature')
        else:
            attestation = response.get('occurrences')[0].get('attestation').get('attestation').get('genericSignedAttestation').get('signatures')[0].get('signature')
            attestation = base64.b64decode(attestation)
        if gpg.verify(attestation):
            logger.info(f"attestion test successful")
            return True
    logger.error(f"Verify image against attestation failed, fully qualify image name: {fqin}")
    return False


def __image_exist(ecr_client, repo, tag, digest):
    rs = ecr_client.describe_images(repositoryName=repo, filter={'tagStatus': 'TAGGED'})
    for i in rs['imageDetails']:
        if tag in i['imageTags'] and digest in i['imageDigest']:
            logger.info(f"image {repo} with {tag} and {digest} already exist")
            return True
    return False
