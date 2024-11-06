FROM public.ecr.aws/spacelift/runner-terraform:v1.4.1_20230911
WORKDIR /tmp
USER root

RUN apk add --no-cache util-linux bash python3 py3-pip python3-dev \
    && apk add --no-cache --virtual .build_deps build-base libffi-dev \
    && apk update \
    && apk upgrade \
    && pip install --no-cache-dir -U checkov \
    && apk del .build_deps \
    && apk cache clean

RUN curl -L "https://github.com/terraform-linters/tflint/releases/download/v0.48.0/tflint_linux_amd64.zip" > tflint.zip \
    && unzip tflint.zip \
    && rm tflint.zip && mv /tmp/tflint /usr/local/bin/

RUN curl -L "https://github.com/aquasecurity/tfsec/releases/download/v1.28.4/tfsec-linux-amd64" > tfsec \
    && chmod +x tfsec && mv /tmp/tfsec /usr/local/bin/
