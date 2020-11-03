ARG GRAFANA_VERSION
FROM grafana/grafana:$GRAFANA_VERSION as plugins_fetcher

RUN grafana-cli plugins install agenty-flowcharting-panel
RUN grafana-cli plugins install alexandra-trackmap-panel
RUN grafana-cli plugins install grafana-kubernetes-app
RUN grafana-cli plugins install grafana-piechart-panel
RUN grafana-cli plugins install grafana-simple-json-datasource
RUN grafana-cli plugins install grafana-worldmap-panel
RUN grafana-cli plugins install innius-video-panel
RUN grafana-cli plugins install jdbranham-diagram-panel
RUN grafana-cli plugins install magnesium-wordcloud-panel
RUN grafana-cli plugins install marcusolsson-dynamictext-panel
RUN grafana-cli plugins install marcusolsson-hourly-heatmap-panel
RUN grafana-cli plugins install michaeldmoore-multistat-panel
RUN grafana-cli plugins install mtanda-histogram-panel
RUN grafana-cli plugins install natel-discrete-panel
RUN grafana-cli plugins install natel-plotly-panel
RUN grafana-cli plugins install ryantxu-ajax-panel
RUN grafana-cli plugins install snuids-radar-panel
RUN grafana-cli plugins install vonage-status-panel
RUN grafana-cli plugins install williamvenner-timepickerbuttons-panel
RUN grafana-cli plugins install yesoreyeram-boomtable-panel

FROM grafana/grafana:$GRAFANA_VERSION
COPY --from=plugins_fetcher /var/lib/grafana/plugins /opt/plugins
