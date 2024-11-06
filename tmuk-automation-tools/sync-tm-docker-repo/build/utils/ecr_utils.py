import logging, json

logger = logging.getLogger(__name__)


def create_repository(client, resource_name, read_awsaccounts, lifecycle_days, kms_key, tags, scan=False):
    try:
        rs = client.describe_repositories(repositoryNames=[resource_name])
        resource_arn = rs.get('repositories')[0].get('repositoryArn')
    except client.exceptions.RepositoryNotFoundException:
        try:
            rs = client.create_repository(
                repositoryName=resource_name,
                # tags=tags,
                imageTagMutability='IMMUTABLE',
                imageScanningConfiguration={
                    'scanOnPush': scan
                },
                encryptionConfiguration={
                    'encryptionType': 'KMS',
                    'kmsKey': kms_key
                }
            )
            resource_arn = rs['repository']['repositoryArn']
        except Exception as e:
            logger.error(f"error during create repo {repo_name}, message: {e}")
            return False
    __resource_tags(client, resource_arn, tags)
    __repo_policies(client, resource_name, read_awsaccounts)
    __repo_lifecycle_policy(client, resource_name, lifecycle_days)
    return True


def __resource_tags(client, resource_arn, tags):
    existing_tags = client.list_tags_for_resource(resourceArn=resource_arn)['tags']
    tags_to_add = [tag for tag in tags if tag not in existing_tags]
    tags_to_delete = [tag for tag in existing_tags if tag not in tags]
    if tags_to_add:
        client.tag_resource(resourceArn=resource_arn, tags=tags_to_add)
    if tags_to_delete:
        client.untag_resource(resourceArn=resource_arn, tagKeys=[tag['Key'] for tag in tags_to_delete])


def __generate_ecr_readonly_policy(principal_arn):
    """
    Generates a read-only policy for an AWS ECR repository
    """
    policy = {
        "Version": "2012-10-17",
        "Statement": [
        {
            "Sid": "EcrReadOnlyAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": principal_arn
            },
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:BatchGetImage",
                "ecr:GetAuthorizationToken",
                "ecr:GetDownloadUrlForLayer"
            ]
        }]
    }
    return policy


def __repo_policies(client, resource_name, read_awsaccounts):
    request_principals = [f"arn:aws:iam::{read_awsaccount}:root" for read_awsaccount in read_awsaccounts]
    try:
        policy = json.loads(client.get_repository_policy(repositoryName=resource_name)['policyText'])
        for statement in policy['Statement']:
            if statement['Sid'] == "EcrReadOnlyAccess" and 'Principal' in statement and 'AWS' in statement['Principal']:
                existing_principals = statement['Principal']['AWS']
                if not isinstance(existing_principals, list): existing_principals = [existing_principals]
                new_principals = [p for p in request_principals if p not in existing_principals] 
                updated_principals = [p for p in existing_principals if p in request_principals]
                if new_principals != [] or updated_principals != existing_principals:
                    updated_principals += new_principals
                    repo_policy = __generate_ecr_readonly_policy(updated_principals)
                    client.set_repository_policy(repositoryName=resource_name, policyText=json.dumps(repo_policy))
    except client.exceptions.RepositoryPolicyNotFoundException as e:
        repo_policy = __generate_ecr_readonly_policy(request_principals)
        client.set_repository_policy(repositoryName=resource_name, policyText=json.dumps(repo_policy))
    except Exception as e:
        logger.error(f"error during create repo policy {resource_name}, message: {e}")


def __generate_lifecycle_policy(count_number):
    """
    Generates a ecr lifecycle policy for an AWS ECR repository
    """
    policy = {
        "rules": [
            {
                "rulePriority": 1,
                "description": f"Expire untagged images older than {count_number} days",
                "selection": {
                    "tagStatus": "untagged",
                    "countType": "sinceImagePushed",
                    "countUnit": "days",
                    "countNumber": count_number
                },
                "action": {
                    "type": "expire"
                }
            }
        ]
    }
    return policy


def __repo_lifecycle_policy(client, resource_name, lifecycle_days):
    try:
        rs = client.get_lifecycle_policy(repositoryName=resource_name).get('lifecyclePolicyText')
        for rule in json.loads(rs)['rules']:
            selection = rule.get('selection')
            if selection['tagStatus'] == "untagged" and selection['countType'] == "sinceImagePushed":
                if lifecycle_days != selection['countNumber']:
                    policy = __generate_lifecycle_policy(lifecycle_days)
                    client.put_lifecycle_policy(repositoryName=resource_name, lifecyclePolicyText=json.dumps(policy))
    except client.exceptions.LifecyclePolicyNotFoundException as e:
        policy = __generate_lifecycle_policy(lifecycle_days)
        client.put_lifecycle_policy(repositoryName=resource_name, lifecyclePolicyText=json.dumps(policy))
    except Exception as e:
        logger.error(f"error during create repo lifecycle policy {resource_name}, message: {e}")
