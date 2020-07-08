# Gitpod in a Docker container with k3s

## Prerequisites

- `docker`
- TLS certificates for your domains

## Quick Start

### Docker run:

```shell
$ docker run \
    --name gitpod \
    -v /tmp/workspaces:/var/gitpod/workspaces \
    -v $(pwd)/values.yaml:/values.yaml \
    -v $(pwd)/certs:/certs \
    -e DOMAIN=your.domain.com \
    -e DNSSERVER=10.0.0.1 \
    --privileged true \
    ludmann/gitpod-k3s
```

### Gitpod + GitLab example

There is a [docker-compose.yaml](examples/gitpod-gitlab/docker-compose.yaml) that creates a pre-configured combination of GitLab and Gitpod. Add you HTTPS certs (`chain.pem`, `dhparams.pem`, `fullchain.pem`, `privkey.pem`) in the [examples/certs](examples/certs) folder, create a `.env` file in [examples/gitpod-gitlab/](examples/gitpod-gitlab/) like this:
```
DOMAIN=your.domain.com
DNSSERVER=10.0.0.1
```
and run `docker-compose up`.
