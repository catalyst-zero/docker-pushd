# docker-pushd

pushd in a docker container.

###### build
```bash
docker build -t pushd .
```

###### run
To run the containerized pushd, one need to mount a volume containing
APN certificates and a generell configuration. Also some environment variables are required.
```bash
docker run \
  -v /your/config/dir/:/mnt/pushd/ \
  -e APN_PUSH_GATEWAY=$APN_PUSH_GATEWAY \
  -e APN_FEEDBACK_ADDRESS=$APN_FEEDBACK_ADDRESS \
  -e GCM_API_KEY=$GCM_API_KEY \
  --link redis:redis \
  pushd
```

`/your/config/dir/` should contain the following file:
- `/mnt/pushd/cert.pem`, the apn cert file
- `/mnt/pushd/key.pem`, the apn key file
- `settings.coffee`, the pushd config file
