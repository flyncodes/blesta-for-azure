#!/bin/bash

# Copy the contents from shared storage to a folder on local disk
cp -R /home/site/wwwroot/inside/* /usr/local/cachedapp/wwwroot
echo "Copied contents from shared storage to local disk"