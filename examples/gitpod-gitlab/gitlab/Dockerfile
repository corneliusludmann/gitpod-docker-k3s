FROM rancher/k3s:v1.18.4-k3s1

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static /tini
RUN chmod +x /tini

COPY gitlab-helm.yaml /var/lib/rancher/k3s/server/manifests/

COPY entrypoint.sh /entrypoint

ENTRYPOINT [ "/tini", "--", "/entrypoint" ]
