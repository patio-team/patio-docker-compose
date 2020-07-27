[![License](https://img.shields.io/github/license/patio-team/patio-docker-compose)](https://www.gnu.org/licenses/gpl-3.0.en.html)

# patio - Docker Compose -

# ![patio](patio-assets/images/patio.png)

**patio** is a web application that tries to measure the happiness of a given team periodically by
asking for a level of happiness between Very bad and Very Good (being Very bad the saddest scenario and Very good the happiest). This repository
hosts the backend of the patio project. Cool!

![one](patio-assets/images/one_50.png) ![two](patio-assets/images/two_50.png) ![one](patio-assets/images/three_50.png ) ![one](patio-assets/images/four_50.png) ![one](patio-assets/images/five_50.png)

## Requirements

In order to execute the application you need to install [docker-compose](https://docs.docker.com/compose/).

## Getting Started

If you'd like to see the application running just execute:

```shell
docker-compose up -d
```

Then open then your browser at `http://localhost:20000` you'll see the login
page. By default there's no user loaded in the system, you can enable
a default user (see DEFAULT USER section) or insert a user afterwards hitting the database directly.

## Configuration

### Backend API

The Docker image allows to set several different parameters to customize your running image. You can change those properties by adding the
environment variables in the Docker compose description file.

#### Database

| Name                       | Description                 | Default value                                            |
|:---------------------------|:----------------------------|:---------------------------------------------------------|
| PATIO_JDBC_URL             | JDBC url                   | jdbc:postgresql://localhost:5433/patio                    |
| PATIO_JDBC_USER            | JDBC username              | patio                                                     |
| PATIO_JDBC_PASSWOR         | JDBC password              | patio                                                     |
| PATIO_JDBC_DRIVER          | JDBC driver                | org.postgresql.Driver                                     |

#### AWS integration

| Name                        | Description                 | Default value                                                 |
|:----------------------------|:----------------------------|:--------------------------------------------------------------|
| PATIO_ACCESS_KEY            | AWS access key              |                                                               |
| PATIO_SECRET_KEY            | AWS secret key              |                                                               |
| PATIO_AWS_EMAIL_SOURCE      | AWS source email            |                                                               |
| PATIO_AWS_EMAIL_REGION      | AWS region                  |                                                               |
| PATIO_AWS_EMAIL_ENABLED     | Enable AWS mailing          |                                                               |

#### JWT

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| PATIO_JWT_SECRET           | JWT secret                  | mysupersecret                                                 |
| PATIO_JWT_ALGO             | JWT signature algorithm     | HS256                                                         |
| PATIO_JWT_ISSUER           | JWT issuer claim            | patio                                                         |
| PATIO_JWT_DAYS             | JWT days before out of date | 7                                                             |

#### GOOGLE-OAUTH2

Google Oauth2 settings are required if you want front end to be authenticated using Google authentication.

| Name                        | Description                 | Default value                                                 |
|:----------------------------|:----------------------------|:--------------------------------------------------------------|
| PATIO_OAUTH2_KEY            | Oauth2 client id            |                                                               |
| PATIO_OAUTH2_SECRET         | Oauth2 client secret        |                                                               |
| PATIO_OAUTH2_CALLBACK       | Oauth2 callback URL         |                                                               |

`PATIO_OAUTH2_CALLBACK` must match frontend `VUE_APP_REDIRECT_URI` variable.

#### DEFAULT USER

In case you'd like to start the instance with a default user you can use the following environment variables:

| Name                       | Description                           | Default value                                        |
|:---------------------------|:--------------------------------------|:-----------------------------------------------------|
| PATIO_DUSER_ENABLED        | Whether or not to insert default user | false                                                |
| PATIO_DUSER_NAME           | Default user's name                   |                                                      |
| PATIO_DUSER_EMAIL          | Default user's email                  |                                                      |
| PATIO_DUSER_PASSWORD       | Default user's plain text password    |                                                      |

### Frontend

Because all environment variables are processed by webpack while building production code, the usual way of providing custom values is providing those values via `.env` files. In order to change frontend variables, change values at `./patio-front/files/.env.production.template` and copy it to `.env.production`. If you'd open the `.env.production.template` you'll find the following content.

```js
VUE_APP_API_URL=graphql
// VUE_APP_DEBUG=false
// VUE_APP_I18N_LOCALE=en
// VUE_APP_I18N_FALLBACK_LOCALE=en
// VUE_APP_OAUTH2_CLIENT_ID=
// VUE_APP_TOKEN_URI=
// VUE_APP_AUTH_URI=
// VUE_APP_REDIRECT_URI=
// VUE_APP_SCOPE='email'
```

TODO: documentar cómo setear estas variables en el docker-compose

#### API

| Name                       | Description                        | Default value                                          |
|:---------------------------|:-----------------------------------|:-------------------------------------------------------|
| VUE_APP_API_URL            | URL of the backend GraphQL API     | http://localhost/graphql                               |

#### GOOGLE OAUTH

The Google login button only appears if the following variables are set.

| Name                       | Description                 | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| VUE_APP_OAUTH2_CLIENT_ID   | Oauth2 client ID            |                                                               |
| VUE_APP_AUTH_URI           | Oauth2 provider auth URI    |                                                               |
| VUE_APP_TOKEN_URI          | OAuth2 provider token URI   |                                                               |
| VUE_APP_REDIRECT_URI       | Oauth2 redirect uri         |                                                               |
| VUE_APP_SCOPE              | Oauth2 main scope           |                                                               |

Backend `PATIO_OAUTH2_CALLBACK` variable must match frontend `VUE_APP_REDIRECT_URI` variable.

## Acknowledgments

Thanks to [Kaleidos Open Source](https://kaleidos.net/) to make this project possible.
