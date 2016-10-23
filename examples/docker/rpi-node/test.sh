#!/bin/bash
NAME=bee42

function test-image(){
FROM_IMAGE=$NAME/node:$(cat $(pwd)/$2/VERSION)
cat > DOCKERFILE <<EOF

FROM $FROM_IMAGE
ADD app/app.js /app.js
EOF

cat DOCKERFILE

docker build -t node-test-$1 -f "$(pwd)/DOCKERFILE" .

rm DOCKERFILE

docker run -d -p 808$1:8080 --name node-test-$1 node-test app.js
}

function cleanup-image(){
  docker kill node-test-$1
  docker rmi node-test-$1
}

test-image 1 latest 
test-image 2 lts 

echo "Wait now for 60 seconds"
sleep 60

cleanup-image 1
cleanup-image 2


