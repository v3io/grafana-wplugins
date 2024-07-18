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

GRAFANA_VERSION ?= 9.2.20
IGUAZIO_REPOSITORY ?= gcr.io/iguazio/

# if GRAFANA_VERSION has "-" then take the first part
# we use the `-` for github releases to add the build number
GRAFANA_VERSION := $(firstword $(subst -, ,$(GRAFANA_VERSION)))


.PHONY: all
all: build
	@echo Done.

.PHONY: build
build: grafana-wplugins
	@echo Done.

.PHONY: push
push: 
	docker push $(IGUAZIO_REPOSITORY)grafana-wplugins:$(GRAFANA_VERSION)

.PHONY: release
release: build push
	@echo Done.

.PHONY: grafana-wplugins
grafana-wplugins:
	docker \
	build \
	--platform linux/amd64 \
	--file ./Dockerfile \
	--tag $(IGUAZIO_REPOSITORY)grafana-wplugins:$(GRAFANA_VERSION) \
	--build-arg GRAFANA_VERSION=$(GRAFANA_VERSION) \
	.
