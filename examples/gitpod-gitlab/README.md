```
$ docker-compose exec gitpod kubectl get pods
NAME                                 READY   STATUS      RESTARTS   AGE
svclb-proxy-hvtfm                    2/2     Running     0          31m
registry-548ddd9768-gcdzt            1/1     Running     0          31m
registry-facade-748df7b8c9-lrckq     1/1     Running     0          31m
minio-6845c586dc-l5c5w               1/1     Running     0          31m
ws-sync-6z296                        1/1     Running     0          31m
ws-manager-6484444885-ld6gs          1/1     Running     0          31m
ws-scheduler-68889f6bb-s8bdj         1/1     Running     0          31m
ws-manager-node-9jd4z                1/1     Running     0          31m
dashboard-84778ccb96-wp9ll           1/1     Running     0          31m
proxy-69bf97644b-6zvzl               1/1     Running     0          31m
image-builder-5d7d97844c-kqjz7       2/2     Running     0          31m
messagebus-8f78d6cf4-gv62b           1/1     Running     0          31m
mysql-65c5b9f8f9-c6v48               1/1     Running     0          31m
gitpod-helm-installer                0/1     Completed   1          32m
ws-manager-bridge-588774d996-c2dv2   1/1     Running     0          31m
server-77d754ff89-mxq56              1/1     Running     0          31m
theia-server-79996b799f-8hxql        1/1     Running     0          31m
node-daemon-g27jv                    1/1     Running     0          31m
```

```
$ docker-compose exec gitlab kubectl get pods
NAME                                                    READY   STATUS      RESTARTS   AGE
gitlab-nginx-ingress-default-backend-55754744c6-qgwls   1/1     Running     0          28m
gitlab-nginx-ingress-default-backend-55754744c6-kxm85   1/1     Running     0          28m
gitlab-cainjector-67dbdcc896-hxgn4                      1/1     Running     0          28m
gitlab-cert-manager-564fc9d7f5-fpx25                    1/1     Running     0          28m
svclb-gitlab-nginx-ingress-controller-j5bhg             3/3     Running     0          28m
gitlab-minio-56667f8cb4-t6xkq                           1/1     Running     0          28m
gitlab-minio-create-buckets.1-b5bwk                     0/1     Completed   0          28m
gitlab-registry-6447585d99-csppx                        1/1     Running     0          28m
gitlab-registry-6447585d99-wsfpg                        1/1     Running     0          28m
gitlab-prometheus-server-768cd8f69-4kk62                2/2     Running     0          28m
gitlab-gitlab-exporter-c74d68964-vtt48                  1/1     Running     0          28m
gitlab-redis-master-0                                   2/2     Running     0          28m
gitlab-postgresql-0                                     2/2     Running     0          28m
gitlab-nginx-ingress-controller-947575fb6-7lzq2         1/1     Running     0          28m
gitlab-nginx-ingress-controller-947575fb6-gngjg         1/1     Running     0          28m
gitlab-gitlab-shell-666d5bb566-qtctz                    1/1     Running     0          27m
gitlab-gitlab-shell-666d5bb566-f6xkq                    1/1     Running     0          28m
gitlab-nginx-ingress-controller-947575fb6-vxl6g         1/1     Running     0          28m
gitlab-task-runner-58495cdf44-xpp7x                     1/1     Running     0          28m
gitlab-gitaly-0                                         1/1     Running     0          28m
gitlab-migrations.1-zx6g5                               0/1     Completed   0          28m
gitlab-sidekiq-all-in-1-v1-f7cc75dbb-2m8pl              1/1     Running     0          28m
gitlab-webservice-6cf7f494cf-dvfqx                      2/2     Running     0          28m
gitlab-webservice-6cf7f494cf-dxzm8                      2/2     Running     0          27m
gitlab-gitlab-runner-7f6c7c6d4-mb7jt                    1/1     Running     3          28m
```