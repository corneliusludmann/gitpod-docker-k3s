FROM rancher/k3s:v1.18.4-k3s1

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static /tini
RUN chmod +x /tini

# This does not work because the helm timeout is to tight.
#COPY gitpod-helm.yaml /var/lib/rancher/k3s/server/manifests/gitpod-helm-installer.yaml
COPY gitpod-helm-installer.yaml /var/lib/rancher/k3s/server/manifests/

COPY entrypoint.sh /entrypoint

ENTRYPOINT [ "/tini", "--", "/entrypoint" ]
