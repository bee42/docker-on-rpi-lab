#!/bin/bash
TAG=docker-meetup-bochum-introduction-2016-10
CID=$1
LOCATION="Docker Meetup Bochum 2016"
TITLE="Docker on ARM - Introduction"
docker exec -ti ${CID} /bin/bash -c "cd print ; ./print.sh /build/docker-on-arm-${TAG}-PeterRossbach.pdf '${LOCATION}'"
docker exec -ti ${CID} /bin/bash -c "cd print ; ./exif.sh /build/docker-arm-${TAG}-PeterRossbach.pdf '${TITLE}'"
