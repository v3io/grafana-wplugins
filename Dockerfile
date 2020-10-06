ARG GRAFANA_VERSION
FROM grafana/grafana:$GRAFANA_VERSION as plugins_fetcher
RUN grafana-cli plugins install grafana-simple-json-datasource
RUN grafana-cli plugins install grafana-worldmap-panel
RUN grafana-cli plugins install ryantxu-ajax-panel

FROM grafana/grafana:$GRAFANA_VERSION
COPY --from=plugins_fetcher /var/lib/grafana/plugins /opt/plugins
