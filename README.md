[![License](https://img.shields.io/github/license/dont-worry-be-happy/dwbh-docker.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

# Don't Worry Be Happy - Docker Compose -

![dwbh](dwbh-assets/images/dwbh.png)

**Don't Worry Be Happy** is a web application that tries to measure
the happiness of a given team periodically by asking for a level of
happiness between 1 and 5 (being 1 the saddest scenario and 5 the
happiest). This repository hosts the backend of the DWBH
project. Cool!

## Requirements

In order to execute the application you need to install [docker-compose](https://docs.docker.com/compose/).

## Getting Started

If you'd like to see the application running just execute:

```shell
docker-compose up -d
```

Then open then your browser at `http://localhost` you'll see the login
page. The default user is `thanos@email.com` and the password is
`avengers`.

## Configuration

### Backend API

The Docker image allows to set several different parameters to customize your running image. You can change those properties by adding the
environment variables in the Docker compose description file.

#### Database

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| DWBH_JDBC_URL              | JDBC url                    | jdbc:postgresql://localhost:5432/dwbh                         |
| DWBH_JDBC_USER             | JDBC username               | dwbh                                                          |
| DWBH_JDBC_PASSWORD         | JDBC password               | dwbh                                                          |
| DWBH_JDBC_DRIVER           | JDBC driver                 | org.postgresql.Driver                                         |

#### AWS integration

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| DWBH_ACCESS_KEY            | AWS access key              |                                                               |
| DWBH_SECRET_KEY            | AWS secret key              |                                                               |
| DWBH_AWS_EMAIL_SOURCE      | AWS source email            |                                                               |
| DWBH_AWS_EMAIL_REGION      | AWS region                  |                                                               |
| DWBH_AWS_EMAIL_ENABLED     | Enable AWS mailing          |                                                               |

#### JWT

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| DWBH_JWT_SECRET            | JWT secret                  | mysupersecret                                                 |
| DWBH_JWT_ALGO              | JWT signature algorithm     | HS256                                                         |
| DWBH_JWT_ISSUER            | JWT issuer claim            | dwbh                                                          |
| DWBH_JWT_DAYS              | JWT days before out of date | 7                                                             |

#### GOOGLE-OAUTH2

Google Oauth2 settings are required if you want front end to be authenticated using Google authentication.

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| DWBH_OAUTH2_KEY            | Oauth2 client id            |                                                               |
| DWBH_OAUTH2_SECRET         | Oauth2 client secret        |                                                               |
| DWBH_OAUTH2_CALLBACK       | Oauth2 callback URL         |                                                               |

`DWBH_OAUTH2_CALLBACK` must match frontend `VUE_APP_REDIRECT_URI` variable.

### Frontend

Because all environment variables are processed by webpack while building production code, the usual way of providing custom values is providing those values via `.env` files. In order to change frontend variables, change values at `./dwbh-front/files/.env.production.template` and copy it to `.env.production`. If you'd open the `.env.production.template` you'll find the following content.

```js
// VUE_APP_DEBUG=false
VUE_APP_API_URL=http://localhost/graphql
// VUE_APP_OAUTH2_CLIENT_ID=
// VUE_APP_TOKEN_URI=
// VUE_APP_AUTH_URI=
// VUE_APP_REDIRECT_URI=
// VUE_APP_SCOPE=
```

#### API

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| VUE_APP_API_URL            | URL of the backend GraphQL API            | http://localhost/graphql |

#### GOOGLE OAUTH

The Google login button only appears if the following variables are set.

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| VUE_APP_OAUTH2_CLIENT_ID   | Oauth2 client ID            | |
| VUE_APP_AUTH_URI           | Oauth2 provider auth URI    | |
| VUE_APP_TOKEN_URI          | OAuth2 provider token URI   | |
| VUE_APP_REDIRECT_URI       | Oauth2 redirect uri         | |
| VUE_APP_SCOPE              | Oauth2 main scope           | |

Backend `DWBH_OAUTH2_CALLBACK` variable must match frontend `VUE_APP_REDIRECT_URI` variable.

## Acknowledgments

Thanks to [Kaleidos Open Source](https://kaleidos.net/) to make this project possible.
