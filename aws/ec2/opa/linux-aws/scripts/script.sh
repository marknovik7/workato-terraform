#!/bin/bash
RELEASE_INFO=`curl --silent https://workato-public.s3.amazonaws.com/agent/release.json`
VERSION=`echo $RELEASE_INFO | grep -Eo '^\{(\s*,*\s*\"[^"]+\"\s*:\s*\"[^"]+\")+' | grep -Eo '\"version\"\s*:\s*\"[^"]+\"' | grep -Eo '\"[^"]+\"$' | cut -d '"' -f 2` 
RELEASE_ARTIFACT_URL=`echo $RELEASE_INFO | grep -Eo '\"artifacts\"\s*:\s*\{(\s*,*\s*\"[^"]+\"\s*:\s*\"[^"]+\")+' | grep -Eo '\"linux\"\s*:\s*\"[^"]+\"'| grep -Eo '\"[^"]+\"$' | cut -d '"' -f 2`
curl -o /tmp/agent.tar.gz $RELEASE_ARTIFACT_URL
sudo tar xvzf /tmp/agent.tar.gz -C /opt
rm -rf /tmp/agent.tar.g
z
