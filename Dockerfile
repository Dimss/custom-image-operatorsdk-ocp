FROM quay.io/buildah/stable
MAINTAINER Dmitry Kartsev <dkartsev@redhat.com>
LABEL io.k8s.description="Custom OperatorSDK Ansible Image Builder" \
      io.k8s.display-name="OperatorSDK Ansible Builder" \
      io.openshift.tags="ansible,operator-sdk,builder,custom"

ARG operator-sdk=https://github.com/operator-framework/operator-sdk/releases/download/v0.13.0/operator-sdk-v0.13.0-x86_64-linux-gnu
ARG oc=https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz

# install get and wget
RUN echo "Installing Build Tools" && \
    dnf install -y git wget && \
    dnf clean all -y
# install operator-sdk and oc
RUN wget -O /usr/bin/operator-sdk ${operator-sdk} && \
    chmod +x /usr/bin/operator-sdk && \
    wget -O /usr/bin/oc ${oc} && \
    chmod +x /usr/bin/oc
# add build script
ADD build.sh /tmp/build.sh

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "/tmp/build.sh" ]