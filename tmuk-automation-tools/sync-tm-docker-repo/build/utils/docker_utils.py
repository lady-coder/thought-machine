import base64, logging
from subprocess import check_output, PIPE


logger = logging.getLogger(__name__)


def ecr_login(ecr_client):
    try:
        token = ecr_client.get_authorization_token()
        username, password = base64.b64decode(token['authorizationData'][0]['authorizationToken']).decode().split(':')
        registry = token['authorizationData'][0]['proxyEndpoint']
        cmd = [ 'crane', 'auth', 'login', registry.replace('https://', ''), '-u', username, '-p', password]
        check_output(cmd, universal_newlines=True, stderr=PIPE).splitlines()
    except Exception as e:
        logger.error(f"ECR Login failed message: {e}")
        return False
    return True


def tm_login(tm_registry, username, password):
    try:
        cmd = ['crane', 'auth', 'login', tm_registry, '-u', username, '-p', password]
        check_output(cmd, universal_newlines=True, stderr=PIPE).splitlines()
    except Exception as e:
        logger.error(f"TM Login failed message: {e}")
        return False
    return True
