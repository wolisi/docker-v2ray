This project is designed to provide a image to quickly run v2ray on your host

Checkout project home on [github](https://github.com/wolisi/docker-v2ray)

# Build the image

There is NO need to run the build yourself if you just want to run thie image, checkout the [Run the container](#run-the-container) section

If you want to build the image from this `Dockerfile`, just clone the github repo, go to project path and run `docker build -t wolisi/docker-v2ray .` You might need to set proxy,
add proxy settings right before the `RUN curl` statement. eg

```dockerfile
ENV http_proxy=host:port
ENV https_proxy=host:port
```

# Run the container

1. run `docker pull wolisi/v2ray`
2. edit the `config.json`, at least change the `id` field. You can generate one [here](https://www.uuidgenerator.net/version4)
3. Run command `docker run -d -p [hostport]:1080 -v /host/path/to/config.json:/etc/v2ray/config.json wolisi/v2ray` replace host port with your server port and `/host/path/to/config.json`, then you are done, enjoy.