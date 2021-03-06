#!/bin/bash

_grafana_plugins=$1
#_grafana_tag=$2
#_grafana_version=$3



if [ -z "$2" ]; then
	_grafana_tag="master"
else
	_grafana_tag=$2
fi

if [ -z "$3" ]; then
	_grafana_version="latest"
else
	_grafana_version=$3
fi


echo "Building Docker image for Grafana of ${_grafana_version} version with a tag ${_grafana_tag}"
echo "Download url: https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${_grafana_version}_amd64.deb"	

if [ -z "$1" ]; then
	echo "No plugins will be installed"
	docker build \
		--build-arg GRAFANA_VERSION=${_grafana_version} \
		--tag "grafana/grafana:${_grafana_tag}" \
		--no-cache=true .
else
	echo "List of plugins: ${_grafana_plugins}"
	docker build \
		--build-arg GRAFANA_VERSION=${_grafana_version} \
		--build-arg GF_RUN_PLUGINS="grafana-cli --pluginsDir "/data/grafana/plugins" plugins install ${_grafana_plugins}" \
		--tag "grafana/grafana:${_grafana_tag}" \
		--no-cache=true .
#	docker tag grafana/grafana:${_grafana_version} grafana/grafana:latest
fi
