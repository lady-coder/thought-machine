#!/bin/bash
set -e

# Uncomment one of these lines
CERT_DURATION=3650   # sandbox
# CERT_DURATION=5475 # preprod
# CERT_DURATION=7300 # prod

if [[ -z "${CERT_DURATION:-}" ]]; then
    echo "CERT_DURATION not set. Uncomment one line for selected environment."
    exit 1
fi

# https://aws.amazon.com/blogs/containers/securing-kubernetes-applications-with-aws-app-mesh-and-cert-manager/
openssl genrsa -out cakey.pem 4096
openssl req -x509 -new -key cakey.pem -subj "/CN=apps-manual-ca" -days $CERT_DURATION -out cacert.pem -config openssl.cnf
cat cacert.pem cacert.pem cakey.pem > cachain.pem
# openssl x509 -in cacert.pem -text # Uncomment this if you may want to see certificate's parameters


# To upload the certificates:

# 1. convert the newlines to the \n by running:
# awk '{printf "%s\\n", $0}' cakey.pem
# awk '{printf "%s\\n", $0}' cacert.pem

# 2. Create json plaintext object in a form {"key":"cakey.pem string with replaced newlines","crt":"cacert.pem string with replaced newlines"}
# 2.1 Upload it manually to the secret appmesh/ca

# 3. Create json plaintext object in a form {"ca.crt":"cakey.pem string with replaced newlines"}
# 3.1 Upload it manually to the secret appmesh/root-ca-bundle
# 3.2 In case of adding additional root CAs to this bundle, please just concat the value of new CA (after replacing newlines) to the value of ca.crt from point 3
