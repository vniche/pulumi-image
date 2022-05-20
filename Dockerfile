FROM alpine:3.1

LABEL "repository"="https://github.com/vniche/pulumi-alpine"
LABEL "maintainer"="Vinicius Niche"
LABEL org.opencontainers.image.description="Pulumi CLI in a container."

RUN apk update \
  && apk -U upgrade \
  && apk add --no-cache ca-certificates bash curl \
  && update-ca-certificates --fresh \
  && rm -rf /var/cache/apk/*

# adds inpublic user
RUN	addgroup inpublic \
  && adduser -S inpublic -u 1000 -G inpublic

# Install the Pulumi SDK, including the CLI and language runtimes.
RUN curl -sSL https://get.pulumi.com | sh && \
  mv ~/.pulumi/bin/* /usr/bin

USER inpublic

# I think it's safe to say if we're using this mega image, we want pulumi
ENTRYPOINT ["pulumi"]
