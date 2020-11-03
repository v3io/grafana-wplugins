ARG GRAFANA_VERSION
FROM grafana/grafana:$GRAFANA_VERSION as plugins_fetcher

RUN grafana-cli plugins install agenty-flowcharting-panel && \
    grafana-cli plugins install alexandra-trackmap-panel && \
    grafana-cli plugins install grafana-kubernetes-app && \
    grafana-cli plugins install grafana-piechart-panel && \
    grafana-cli plugins install grafana-simple-json-datasource && \
    grafana-cli plugins install grafana-worldmap-panel && \
    grafana-cli plugins install innius-video-panel && \
    grafana-cli plugins install jdbranham-diagram-panel && \
    grafana-cli plugins install magnesium-wordcloud-panel && \
    grafana-cli plugins install marcusolsson-dynamictext-panel && \
    grafana-cli plugins install marcusolsson-hourly-heatmap-panel && \
    grafana-cli plugins install michaeldmoore-multistat-panel && \
    grafana-cli plugins install mtanda-histogram-panel && \
    grafana-cli plugins install natel-discrete-panel && \
    grafana-cli plugins install natel-plotly-panel && \
    grafana-cli plugins install ryantxu-ajax-panel && \
    grafana-cli plugins install snuids-radar-panel && \
    grafana-cli plugins install vonage-status-panel && \
    grafana-cli plugins install williamvenner-timepickerbuttons-panel && \
    grafana-cli plugins install yesoreyeram-boomtable-panel

FROM grafana/grafana:$GRAFANA_VERSION
COPY --from=plugins_fetcher /var/lib/grafana/plugins /opt/plugins
