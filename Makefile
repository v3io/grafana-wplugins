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

GRAFANA_VERSION ?= 11.5.6
IGUAZIO_REPOSITORY ?= gcr.io/iguazio/
CACHE_FROM ?=

# if GRAFANA_VERSION has "-" then take the first part
# we use the `-` for github releases to add the build number
GRAFANA_VERSION_CLEAN := $(firstword $(subst -, ,$(GRAFANA_VERSION)))

# Build cache options
CACHE_OPTS :=
ifneq ($(CACHE_FROM),)
	CACHE_OPTS := --cache-from $(IGUAZIO_REPOSITORY)grafana-wplugins:$(GRAFANA_VERSION_CLEAN)
endif


.PHONY: all
all: build
	@echo Done.

.PHONY: build
build: grafana-wplugins
	@echo Done.

.PHONY: push
push: 
	docker push $(IGUAZIO_REPOSITORY)grafana-wplugins:$(GRAFANA_VERSION_CLEAN)

.PHONY: release
release: build push
	@echo Done.

.PHONY: grafana-wplugins
grafana-wplugins:
	docker build \
	--file ./Dockerfile \
	--tag $(IGUAZIO_REPOSITORY)grafana-wplugins:$(GRAFANA_VERSION_CLEAN) \
	--build-arg GRAFANA_VERSION=$(GRAFANA_VERSION_CLEAN) \
	--build-arg BUILD_DATE=$(shell date -u +%Y-%m-%dT%H:%M:%SZ) \
	$(CACHE_OPTS) \
	.
