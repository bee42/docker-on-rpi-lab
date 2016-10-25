#!/bin/bash
docker run -d -ti -p 8020:8000 \
 -v `pwd`/images:/opt/presentation/images \
 -v `pwd`:/opt/presentation/lib/md \
 -v `pwd`/build:/build \
 rossbachp/presentation
