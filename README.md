# grafana-wplugins
Dockerized Grafana with built-in plugins. Public pull access from: https://console.cloud.google.com/gcr/images/iguazio/GLOBAL/grafana-wplugins

## Building The Image
```sh
docker build -t gcr.io/iguazio/grafana-wplugins:<grafana-version> --build-arg GRAFANA_VERSION=<grafana-version> .
```
