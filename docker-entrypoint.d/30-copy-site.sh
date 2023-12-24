#!/bin/bash

# Copy the contents from shared storage to a folder on local disk
cp -R /home/site/wwwroot/inside/* ${NGINX_ROOT}
echo "Copied contents from shared storage to local disk"
