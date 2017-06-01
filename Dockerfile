FROM alpine:3.6

ARG CLOUD_SDK_VERSION=157.0.0
ARG SHA256SUM=95b98fc696f38cd8b219b4ee9828737081f2b5b3bd07a3879b7b2a6a5349a73f

ENV PATH /google-cloud-sdk/bin:$PATH

RUN set -x && \
    apk --no-cache add curl python py-crcmod bash libc6-compat git openssh-client && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    echo "${SHA256SUM}  google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" > google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 && \
    sha256sum -c google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    export CLOUDSDK_CORE_DISABLE_PROMPTS=1 && \
    gcloud components install app-engine-python app-engine-python-extras app-engine-go cbt bigtable datalab cloud-datastore-emulator gcd-emulator pubsub-emulator emulator-reverse-proxy docker-credential-gcr alpha beta app-engine-java kubectl

VOLUME ["/root/.config"]

CMD ["/bin/bash"]
