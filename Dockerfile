FROM registry.access.redhat.com/ubi8
MAINTAINER Dmitry Kartsev <dkartsev@redhat.com>
LABEL io.k8s.description="Custom OperatorSDK Ansible Image Builder" \
      io.k8s.display-name="OperatorSDK Ansible Builder" \
      io.openshift.tags="ansible,operator-sdk,builder,custom"

RUN echo "Installing Build Tools" && \
    yum install -y git wget && \
    yum clean all -y

RUN wget -O /usr/bin/operator-sdk https://github.com/operator-framework/operator-sdk/releases/download/v0.13.0/operator-sdk-v0.13.0-x86_64-linux-gnu
RUN chmod +x /usr/bin/operator-sdk

RUN wget -O /usr/bin/oc https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz
RUN chmod +x /usr/bin/oc

ADD build.sh /tmp/build.sh

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD [ "/tmp/build.sh" ]