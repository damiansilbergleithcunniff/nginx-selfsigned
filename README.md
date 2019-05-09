# nginx-selfsigned
An nginx docker image which generates a self signed certificate for a specific set of domains when the container starts up.
The goal is to provide a quick development reverse proxy for fronting HTTPS only applications on the localhost.

# quick start
You can use docker-compose to start up nginx.
The provided `docker-compose.yaml` will build/launch the nginx-selfsigned container.
`nginx` will generate a cert and then listen on `https://localhost:443` and forward that to `https://host.docker.internal:443`.

> Use the following command to start up the container:
```
docker-compose up
```

> check if things are working with:
```
docker ps
```

> Use the following commands to complete remove the container:
```
docker-compose stop
docker-compose rm
```

# configuration

## cert generation
When you run the container you can specify a set of environment variables to control the generation of the cert.  They are: 
* `DOMAIN`: The common name domain for the certificate (default: "localhost")
* `VALID_DAYS`: The number of days the cert is valid for (default: 365)
* `ALT_NAMES`: A comma delimited list of DNS names for the SAN on the cert.  Can use wildcards. (default: \*.lcl)

## nginx

### default
The `docker-compose` which is provided will mount the `./conf` directory to `/etc/nginx/conf.d`.
This effectively makes this the config directory.
You can place whatever valid nginx config you want in this dirctory and the container will load it.
The default config that's in that directory maps:
* https://localhost
* https://example.lcl
To port `443` on the internal docker host address which is used on [docker for mac](https://docs.docker.com/docker-for-mac/networking/).

### customizing
If you want to customize the config you can update the default or place additional configs as you see fit.  
The generated cert/key is located in `/nginx-selfsigned/${DOMAIN}_*.pem`.  This means the name is dependent on the `DOMAIN` parameter and will default to `localhost`.
If you change the `DOMAIN` to something else you'll need to make sure that your config file points to the correct cert.

# references
https://medium.com/@oliver.zampieri/self-signed-ssl-reverse-proxy-with-docker-dbfc78c05b41



