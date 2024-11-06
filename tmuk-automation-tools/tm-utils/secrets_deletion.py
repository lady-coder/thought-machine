import boto3
import time
import argparse


# secrets_prefix: 'tm-prefix/sandbox-tm/' or 'AmazonMSK_tm-prefix/sandbox-tm'


cli = argparse.ArgumentParser()
cli.add_argument('--secrets_prefix', type=str, required=True, help="prefix of secrets need to be deleted")
cli.add_argument('--region', type=str, required=True, help="region where storing secrets need to be deleted")
cli.add_argument('--delay', type=int, required=False, default=1, help="time delay (seconds) for next secret deletion, default 1 second")


args = cli.parse_args()
secrets_prefix = args.secrets_prefix
region = args.region
delay = args.delay


client = boto3.client('secretsmanager', region_name=region)


def delete_secrets(prefix, delay):
    paginator = client.get_paginator('list_secrets')
    response_iterator = paginator.paginate()

    for page in response_iterator:
        for secret in page['SecretList']:
            secret_name = secret['Name']

            if secret_name.startswith(prefix):
                print(f"Deleting secret: {secret_name}")
                client.delete_secret(SecretId=secret_name, ForceDeleteWithoutRecovery=True)

                if delay > 0:
                    print(f"Waiting for {delay} seconds...")
                    time.sleep(delay)

    print("Deletion complete.")


delete_secrets(secrets_prefix, delay)
