import boto3
import json
import argparse

secret_client = boto3.client('secretsmanager')
kms_client = boto3.client('kms')
msk_client = boto3.client('kafka')
parser = argparse.ArgumentParser()

parser.add_argument('--kms_id', help="Provide KMS ID for creating AWS secrets ")
parser.add_argument('--arn', help="arn of MSK")
parser.add_argument('--sync', action='store_true', help="Get secret posfix 'kafka' and create a similar secret with prefix 'AmazonMSK_'")
parser.add_argument('--list_msk_secrets', action='store_true', help="Get all AWS secrets associated with MSK (SSL-SCRAM)")
parser.add_argument('--associate', action='store_true', help="Get all secrets posfix 'kafka' and prefix 'AmazonMSK_', then associate them to MSK cluster")

args = parser.parse_args()


def check_secrets_exist(secret_name, username, password):
    provided_secret = {
        "username": username,
        "password": password
    }
    provided_secret = json.dumps(provided_secret)
    try:
        response = secret_client.get_secret_value(SecretId=secret_name)
        stored_secret = response['SecretString']
        print(f"{'This secret exists!'.rjust(23)}")
        if provided_secret == stored_secret:
            print(f"{'Match'.rjust(10)} with stored secrets from AWS Secrets Manager")
            return 1
        else:
            print(f"{'Not match'.rjust(10)} with stored secrets from AWS Secrets Manager")
            return 2
    except secret_client.exceptions.ResourceNotFoundException:
        print(f"{'This secret does not exist'.rjust(22)}")
        return 0


def update_secret(secret_name, new_username, new_password): 
    new_secret_name = secret_name
    new_secret_value = {
        "username": new_username,
        "password": new_password
    }
    new_secret_value = json.dumps(new_secret_value)
    secret_client.update_secret(
        SecretId        =   new_secret_name,
        SecretString    =   new_secret_value
    )
    print(f"  Secret-Name: {new_secret_name} updated")


def create_secret_msk_format(secret_name,username,password,kms_key_id):  
    new_secret_name = secret_name
    new_secret_value = {
        "username": username,
        "password": password
    }
    new_secret_value = json.dumps(new_secret_value)
    secret_client.create_secret(
        Name            =   new_secret_name,
        KmsKeyId        =   kms_key_id,
        SecretString    =   new_secret_value
    )
    print(f"  Secret-Name: {new_secret_name} created")


# Get secret ending kafka and create a similar secret but adding prefix "AmazonMSK_"
def sync(kms_key_id):
    counter = 1
    paginator = secret_client.get_paginator('list_secrets')
    iterator = paginator.paginate()

    for response in iterator:
        for secret in response['SecretList']:
            secret_name = secret['Name']
            if secret_name.endswith('kafka') and not secret_name.startswith("AmazonMSK_"):
                secret_value_response = secret_client.get_secret_value(SecretId=secret_name)
                secret_value = secret_value_response['SecretString']

                # Only take sasl_scram_username and sasl_scram_password
                secret_json = json.loads(secret_value)
                username    = secret_json.get('sasl_scram_username')
                password    = secret_json.get('sasl_scram_password')
                # Transform to msk format
                new_secret_name = "AmazonMSK_" + secret_name
                print(f"{counter}/ Secret-Name: {new_secret_name}")
                counter += 1
                check_ = check_secrets_exist(new_secret_name, username, password)

                if check_ == 2:
                    update_secret(new_secret_name, username, password)
                if check_ == 0:
                    create_secret_msk_format(new_secret_name,username,password,kms_key_id)               


def list_associated_secrets(kafka_cluster_arn):
    response = msk_client.list_scram_secrets(ClusterArn=kafka_cluster_arn)
    scram_secrets_arn = response['SecretArnList']
    list_of_scram_secrets_arn = []
    for arn_ in scram_secrets_arn:
        list_of_scram_secrets_arn.append(arn_)
    return list_of_scram_secrets_arn


def get_associated_list(kafka_cluster_arn):
    list = list_associated_secrets(kafka_cluster_arn)
    count = 1
    for arn_ in list:
        print(f"{count}/  {arn_}")
        count += 1


def associate_msk_secrets(kafka_cluster_arn):
    counter = 1
    paginator = secret_client.get_paginator('list_secrets')
    iterator = paginator.paginate()
    list = list_associated_secrets(kafka_cluster_arn)

    for response in iterator:
        for secret in response['SecretList']:
            secret_name = secret['Name']
            if secret_name.endswith('kafka') and secret_name.startswith("AmazonMSK_"):
                secret_arn = secret_client.get_secret_value(SecretId=secret_name)['ARN']
                # Check if secret_arn isn't in associated msk secrets, we associate it
                if secret_arn not in list:
                    # msk_client.batch_associate_scram_secret(
                    #     ClusterArn = kafka_cluster_arn,
                    #     SecretArnList = [secret_arn]
                    # )
                    result= msk_client.batch_associate_scram_secret(
                        ClusterArn = kafka_cluster_arn,
                        SecretArnList = [secret_arn]
                    )
                    print (result)
                    print(f"{counter}/ {secret_arn}\n{'Associate'.rjust(12)} a new secret successsful!\n")
                    counter += 1
    print(f"{'Successfully!'.rjust(15)} All screts are associated!")


if args.kms_id and args.sync:
    sync(args.kms_id)


if args.arn:
    if args.associate:
        associate_msk_secrets(args.arn)
    if args.list_msk_secrets:
        get_associated_list(args.arn)
