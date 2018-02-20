ARG GRAFANA_VERSION=latest
FROM grafana/grafana:${GRAFANA_VERSION}

#ARG GRAFANA_VERSION="latest"
#ARG GF_INSTALL_PLUGINS="foursquare-clouderamanager-datasource"


#ARG DOWNLOAD_URL="https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana_latest_amd64.deb"
#RUN  curl https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb 

RUN mkdir -p /data/grafana/plugins && chown -R grafana:grafana /data/grafana/plugins
RUN grafana-cli --pluginsDir "/data/grafana/plugins" plugins install ${GF_INSTALL_PLUGINS}
