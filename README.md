# aws-credentials-server

aws-credentials-server is a tool to expose a specified IAM role to your development environment.

It can be run directly on 169.254.169.254 or behind a proxy like [dinghy-http-proxy](https://github.com/codekitchen/dinghy-http-proxy).

Example:
```yaml
version: '3.8'
services:
  aws-credentials-server:
    image: 786715713882.dkr.ecr.us-east-1.amazonaws.com/aws-credentials-server:latest
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
