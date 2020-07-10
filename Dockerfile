FROM rancher/k3s:v1.18.4-k3s1

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static /tini
RUN chmod +x /tini

ADD https://github.com/mikefarah/yq/releases/download/3.3.2/yq_linux_amd64 /bin/yq
RUN chmod +x /bin/yq

# This does not work because the helm timeout is to tight.
#COPY gitpod-helm.yaml /var/lib/rancher/k3s/server/manifests/gitpod-helm-installer.yaml
COPY gitpod-helm-installer.yaml /var/lib/rancher/k3s/server/manifests/
COPY values.yaml /default_values.yaml

COPY entrypoint.sh /entrypoint

ENTRYPOINT [ "/tini", "--", "/entrypoint" ]
