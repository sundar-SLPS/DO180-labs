#!/bin/bash
if curl --progress-bar -O https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/oss/nexus-2.14.3-02-bundle.tar.gz
then
  echo "Nexus bundle download successful"
else
  echo "Download failed"
fi
