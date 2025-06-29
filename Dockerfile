# Copyright 2024 Iguazio
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ARG GRAFANA_VERSION=11.5.6
FROM grafana/grafana:${GRAFANA_VERSION} AS plugins_fetcher

RUN grafana cli plugins install agenty-flowcharting-panel \
    && grafana cli plugins install alexandra-trackmap-panel \
    && grafana cli plugins install grafana-kubernetes-app \
    && grafana cli plugins install grafana-piechart-panel \
    && grafana cli plugins install grafana-simple-json-datasource \
    && grafana cli plugins install grafana-worldmap-panel \
    && grafana cli plugins install innius-video-panel \
    && grafana cli plugins install jdbranham-diagram-panel \
    && grafana cli plugins install magnesium-wordcloud-panel \
    && grafana cli plugins install marcusolsson-dynamictext-panel \
    && grafana cli plugins install marcusolsson-hourly-heatmap-panel \
    && grafana cli plugins install michaeldmoore-multistat-panel \
    && grafana cli plugins install mtanda-histogram-panel \
    && grafana cli plugins install natel-discrete-panel \
    && grafana cli plugins install natel-plotly-panel \
    && grafana cli plugins install ryantxu-ajax-panel \
    && grafana cli plugins install snuids-radar-panel \
    && grafana cli plugins install vonage-status-panel \
    && grafana cli plugins install williamvenner-timepickerbuttons-panel \
    && grafana cli plugins install yesoreyeram-boomtable-panel \
    && grafana cli plugins install tdengine-datasource

ARG GRAFANA_VERSION=11.5.6
FROM grafana/grafana:${GRAFANA_VERSION}

# update OS packages for security patches
USER root
# This build arg ensures the following RUN command always executes (cache invalidation)
ARG BUILD_DATE
RUN apk upgrade --no-cache \
    && apk add --no-cache --upgrade busybox \
    && rm -rf /var/cache/apk/*

USER grafana
COPY --from=plugins_fetcher /var/lib/grafana/plugins /opt/plugins
