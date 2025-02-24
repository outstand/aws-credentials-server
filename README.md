# aws-credentials-server [![Build status](https://badge.buildkite.com/1dad36aae1fa8aeb5477fbeb9f6cfa5d6a68284faac8c2719d.svg)](https://buildkite.com/outstand/aws-credentials-server)

aws-credentials-server is a tool to expose a specified IAM role to your development environment.

It can be run directly on 169.254.169.254 or behind a proxy like [dinghy-http-proxy](https://github.com/codekitchen/dinghy-http-proxy).

Example:
```yaml
version: '3.8'
services:
  aws-credentials-server:
    image: outstand/aws-credentials-server:latest
    container_name: aws-credentials-server
    restart: unless-stopped
    ports:
      - '80'
    environment:
      APP_ENV: production
      AWS_REGION: us-east-1
      ROLE_ARN: "CHANGEME"
      VIRTUAL_HOST: 169.254.169.254
      VIRTUAL_PORT: 80
      HTTPS_METHOD: noredirect
    volumes:
      - ~/.aws:/home/srv/.aws
      - ~/.awsvault:/home/srv/.awsvault
```

## Inspiration

- https://github.com/99designs/aws-vault
