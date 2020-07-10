#!/bin/sh

set -eu

mount --make-shared /sys/fs/cgroup
mount --make-shared /var/gitpod/workspaces

# prepare Gitpod helm installer
if [ -f /var/lib/rancher/k3s/server/manifests/gitpod-helm-installer.yaml ]; then

    if [ -z "$DOMAIN" ]; then
        >&2 echo "Error: Environment variable DOMAIN is missing."
        exit 1;
    fi

    if [ -f /values.yaml ]; then
        # merge values and update default_values.yaml
        yq m -ixa /default_values.yaml /values.yaml
    fi
    sed 's/^/    /' /default_values.yaml >> /var/lib/rancher/k3s/server/manifests/gitpod-helm-installer.yaml

    sed -i "s/{{ DOMAIN }}/$DOMAIN/g" /var/lib/rancher/k3s/server/manifests/gitpod-helm-installer.yaml

    # gitpod-helm-installer.yaml needs access to kubernetes by the public host IP.
    kubeconfig_replacip() {
        while [ ! -f /etc/rancher/k3s/k3s.yaml ]; do sleep 1; done
        HOSTIP=$(hostname -i)
        sed "s+127.0.0.1+$HOSTIP+g" /etc/rancher/k3s/k3s.yaml > /etc/rancher/k3s/k3s_.yaml
    }
    kubeconfig_replacip &

    installation_completed_hook() {
        while [ -z "$(kubectl get pods | grep gitpod-helm-installer | grep Completed)" ]; do sleep 10; done

        echo "Removing network policies ..."
        kubectl delete networkpolicies.networking.k8s.io --all

        echo "Removing installer manifest ..."
        rm -f /var/lib/rancher/k3s/server/manifests/gitpod-helm-installer.yaml
    }
    installation_completed_hook &

fi


# add HTTPS certs secret
if [ -f /certs/chain.pem ] && [ -f /certs/dhparams.pem ] && [ -f /certs/fullchain.pem ] && [ -f /certs/privkey.pem ]; then
  CHAIN=$(base64 --wrap=0 < /certs/chain.pem)
  DHPARAMS=$(base64 --wrap=0 < /certs/dhparams.pem)
  FULLCHAIN=$(base64 --wrap=0 < /certs/fullchain.pem)
  PRIVKEY=$(base64 --wrap=0 < /certs/privkey.pem)
  cat << EOF > /var/lib/rancher/k3s/server/manifests/proxy-config-certificates.yaml
apiVersion: v1
kind: Secret
metadata:
  name: proxy-config-certificates
  labels:
    app: gitpod
data:
  chain.pem: $CHAIN
  dhparams.pem: $DHPARAMS
  fullchain.pem: $FULLCHAIN
  privkey.pem: $PRIVKEY
EOF
fi


# patch DNS config
if [ -n "$DOMAIN" ] && [ -n "$DNSSERVER" ]; then
    patchdns() {
        echo "Waiting for CoreDNS to patch config ..."
        while [ -z "$(kubectl get pods -n kube-system | grep coredns | grep Running)" ]; do sleep 10; done

        DOMAIN=$1
        DNSSERVER=$2

        if [ -z "$(kubectl get configmap -n kube-system coredns -o json | grep $DOMAIN)" ]; then
            echo "Patching CoreDNS config ..."

            kubectl get configmap -n kube-system coredns -o json | \
                sed -e "s+.:53+$DOMAIN {\\\\n  forward . $DNSSERVER\\\\n}\\\\n.:53+g" | \
                kubectl apply -f -
            echo "CoreDNS config patched."
        else
            echo "CoreDNS has been patched already."
        fi
    }
    patchdns "$DOMAIN" "$DNSSERVER" &
fi


# start k3s
/bin/k3s server --disable traefik
