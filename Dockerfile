FROM nginx:alpine

# we need openssl to generate the certs
RUN apk --no-cache add bash openssl

# set the workdir to a dedicated location
WORKDIR /nginx-selfsigned

# copy in the scripts
COPY ./generate-self-signed.sh ./entrypoint.sh ./

# and set the entrypoint
ENTRYPOINT [ "./entrypoint.sh" ]
