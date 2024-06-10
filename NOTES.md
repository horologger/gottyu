# After upgrading docker, might have to...
```
docker buildx create --use
```

# Created this branch from v1.5.0 with the following command:
```
git checkout tags/v1.5.0 -b v1.5.0-h
```

# Switch back to main branch
```
git checkout master
```

# Switch back to main v1.5.0-h branch
```
git checkout v1.5.0-h
```
# Let correct go version
```
gvm use go1.19.4
```

# Build for local testing
```
docker buildx build --platform linux/arm64 --tag horologger/gottyu:v1.5.0 --load .

docker buildx build --platform linux/arm64 --tag horologger/gottyu:v1.5.0 --load --build-arg CACHEBUST=$(date +%s) .
```

# Build and push to docker hub
```
docker login -u horologger -p <password>
docker buildx build --platform linux/arm64,linux/amd64 --tag horologger/gottyu:v1.5.0 --output "type=registry" .
```

#First run on Zilla
```
docker run \
--cap-add SYS_ADMIN \
-e GOTTY_PORT=8080 \
-v data:/data \
-p 8080:8080 \
--name gottyu \
-it horologger/gottyu:v1.5.0
```
#Subsequent runs on Zilla
```
docker run \
-e GOTTY_PORT=8080 \
-v data:/data \
-p 8080:8080 \
-it horologger/gottyu:v1.5.0
```

# Inspect
```sh
docker exec -it gottyu /bin/bash
```
# Clean up
```sh
docker stop gottyu ; docker rm gottyu
```
