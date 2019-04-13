# -------------------------------
# ---------- STAGE-1 ------------
# -------------------------------
FROM node:10.15.1 as front

RUN git clone https://github.com/dont-worry-be-happy/dwbh-front.git /build/dwbh-front
WORKDIR /build/dwbh-front

# Configuring variable to tell front end where to find back end
# endpoint right before building the distribution
RUN sed -i "s/\$DWBH_API_URL/\/graphql/g" .env
RUN yarn add -D vue-cli && yarn build

# -------------------------------
# ---------- STAGE-2 ------------
# -------------------------------
FROM openjdk:11-jdk as back

RUN git clone https://github.com/dont-worry-be-happy/dwbh-api.git /build/dwbh-api
WORKDIR /build/dwbh-api
RUN ./gradlew assemble

# -------------------------------
# ---------- STAGE-3 ------------
# -------------------------------
FROM openjdk:11-jdk-slim as container

# LOCALE SETUP
RUN apt-get update && \
    apt-get install -yq locales ca-certificates wget sudo && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# POSTGRES >> SOURCES
RUN apt-get update && apt-get install -yq gnupg
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add - && \
  sudo apt-get update

# POSTGRES >> INSTALL
RUN apt-get update && \
    apt-get install -yq \
    xz-utils \
    nginx \
    postgresql-11 \
    postgresql-contrib-11

# POSTGRES >> CONFIG
COPY files/pg_hba.conf /etc/postgresql/11/main/pg_hba.conf

RUN /etc/init.d/postgresql start && \
    createuser --login --superuser --username=postgres dwbh && \
    createdb --username=dwbh dwbh && \
    /etc/init.d/postgresql stop

# NGINX >> CONFIG
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY --from=front /build/dwbh-front/dist /var/www/html

# APPLICATION >> CONFIG
# ---------------------
# These properties can be overriden by docker run execution or docker
# compose configuration

ENV MICRONAUT_ENVIRONMENTS=prod

ENV DWBH_JDBC_URL=jdbc:postgresql://localhost:5432/dwbh
ENV DWBH_JDBC_USER=dwbh
ENV DWBH_JDBC_PASSWORD=dwbh
ENV DWBH_JDBC_DRIVER=org.postgresql.Driver
ENV DWBH_JWT_SECRET=mysupersecret
ENV DWBH_JWT_DAYS=7

ENV DWBH_DEFAULT_USER_ENABLED=true
ENV DWBH_DEFAULT_USER_USERNAME=thanos@email.com
ENV DWBH_DEFAULT_USER_PASSWORD='$2a$10$OX9LAoZ4QarfDoSgIocrIedyVFfoe9fceI5zAXoYkKjOJV8f15YbS'

COPY --from=back /build/dwbh-api/build/libs/dwbh-api-0.1.0-all.jar /back/

# ENTRYPOINT
COPY files/entrypoint.sh .
COPY files/add_default_user.sh .
ENTRYPOINT ./entrypoint.sh

EXPOSE 80
