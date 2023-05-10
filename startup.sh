#Make a directory on the local disk to run the code from
mkdir -p /usr/local/cachedapp/

#Copy the contents from shared storage to a folder on local disk
cp -R /home/site/wwwroot/inside /usr/local/cachedapp/wwwroot
