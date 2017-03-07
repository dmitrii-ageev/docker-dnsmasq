#!/bin/sh
PACKAGE_NAME=bind
PREVIOUS_VERSION=$(docker images dmitriiageev/$PACKAGE_NAME | cut -d " " -f4 | grep [0-9] | sort -rn | head -1 )

if [ ! -z "$1" ]; then
  VERSION="$1"
else
  MAJOR=$(echo $PREVIOUS_VERSION | sed "s/\([0-9]\+\)\.[0-9]\.[0-9]/\1/")
  MINOR=$(echo $PREVIOUS_VERSION | sed "s/[0-9]\.\([0-9]\+\)\.[0-9]/\1/")
  BUILD=$(echo $PREVIOUS_VERSION | sed "s/[0-9]\.[0-9]\.\([0-9]\+\)/\1/")
  if [ $BUILD -eq 9 ]; then
    BUILD=0
    if [ $MINOR -eq 9 ]; then
      MINOR=0
      let MAJOR=$MAJOR+1
    else
      let MINOR=$MINOR+1
    fi
  else
    let BUILD=$BUILD+1
  fi
  VERSION="$MAJOR.$MINOR.$BUILD"
fi

docker rmi -f dmitriiageev/$PACKAGE_NAME:latest 
docker rmi -f dmitriiageev/$PACKAGE_NAME:$PREVIOUS_VERSION 

docker build -t dmitriiageev/$PACKAGE_NAME:$VERSION -t dmitriiageev/$PACKAGE_NAME:latest .
docker volume rm $(docker volume ls -q) 2>/dev/null

if [ "$2" == "--push" ]; then
  docker push dmitriiageev/$PACKAGE_NAME:$VERSION
  docker push dmitriiageev/$PACKAGE_NAME:latest
fi
