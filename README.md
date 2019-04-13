[![License](https://img.shields.io/github/license/dont-worry-be-happy/dwbh-docker.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)

# Don't Worry Be Happy - Docker image -

![dwbh](files/dwbh.png)

**Don't Worry Be Happy** is a web application that tries to measure
the happiness of a given team periodically by asking for a level of
happiness between 1 and 5 (being 1 the saddest scenario and 5 the
happiest). This repository hosts the backend of the DWBH
project. Cool!

## Getting Started

If you'd like to see the Docker image running just execute:

```shell
docker run -p 80:80 kaleidos-docker-registry.bintray.io/dwbh/dwbh:latest
```

Then open then your browser at `http://localhost` you'll see the login
page. The default user is `thanos@email.com` and the password is
`avengers`.

## To Build the image

From this repository's root folder execute:

```shell
./dwbh.sh build
```

It'll take a while until it finishes creating the image. Once it's
finished you can run the Docker image by just executing:

```shell
docker run -p 80:80 kaleidos-docker-registry.bintray.io/dwbh/dwbh:latest
```

## Configuration

The Docker image allows to set several different parameters to customize your running image:

| Name                       | Value                       | Default value                                                 |
|:---------------------------|:----------------------------|:--------------------------------------------------------------|
| DWBH_JDBC_URL              | JDBC url                    | jdbc:postgresql://localhost:5432/dwbh                         |
| DWBH_JDBC_USER             | JDBC username               | dwbh                                                          |
| DWBH_JDBC_PASSWORD         | JDBC password               | dwbh                                                          |
| DWBH_JDBC_DRIVER           | JDBC driver                 | org.postgresql.Driver                                         |
| DWBH_AWS_SOURCE_EMAIL      | AWS source email            |                                                               |
| DWBH_AWS_REGION            | AWS region                  |                                                               |
| DWBH_ACCESS_KEY            | AWS access key              |                                                               |
| DWBH_SECRET_KEY            | AWS secret key              |                                                               |
| DWBH_JWT_SECRET            | JWT secret                  | mysupersecret                                                 |
| DWBH_JWT_DAYS              | JWT days before out of date | 7                                                             |
| DWBH_DEFAULT_USER_ENABLED  | Create default  user        | true                                                          |
| DWBH_DEFAULT_USER_USERNAME | Default user's username     | thanos@email.com                                              |
| DWBH_DEFAULT_USER_PASSWORD | Default user's password     | $2a$10$OX9LAoZ4QarfDoSgIocrIedyVFfoe9fceI5zAXoYkKjOJV8f15YbS  |

You can change those properties when running the application with the
`docker run` command or if you're using Docker compose by adding the
environment variables in the Docker compose description file. An
example when using the `docker run` command:

```shell
docker run -p 80:80 -e DWBH_JWT_DAYS=2 kaleidos-docker-registry.bintray.io/dwbh/dwbh:latest
```

The value of the default user's password is the result of hashing
`avengers` using BCrypt. If you'd like to provide the default user's
password, please notice that the password should have been hashed with
Bcrypt and the value of `DWBH_JWT_SECRET` as the salt value.

## To Publish

Before publishing an image to the Bintray's repository you have to log in:

```shell
docker login kaleidos-docker-registry.bintray.io
```

Then you can execute:

```shell
./dwbh.sh publish
```

## Acknowledgments

Thanks to [Kaleidos Open Source](https://kaleidos.net/) to make this project possible.
