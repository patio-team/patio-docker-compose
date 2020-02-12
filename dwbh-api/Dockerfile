# -------------------------------
# ---------- STAGE-1 ------------
# -------------------------------
FROM openjdk:11-jdk as back

RUN git clone --single-branch https://github.com/dont-worry-be-happy/dwbh-api.git /build/dwbh-api
WORKDIR /build/dwbh-api
RUN ./gradlew assemble

# -------------------------------
# ---------- STAGE-2 ------------
# -------------------------------
FROM openjdk:11-jdk-slim as container

# LOCALE SETUP
RUN apt-get update && \
    apt-get install --no-install-recommends -yq locales ca-certificates wget sudo && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# APPLICATION >> CONFIG
# ---------------------
# These properties can be overriden by docker run execution or docker
# compose configuration

ENV MICRONAUT_ENVIRONMENTS=prod

COPY --from=back /build/dwbh-api/build/libs/dwbh-api-0.1.0-all.jar /back/

EXPOSE 8080

# ENTRYPOINT
COPY files/entrypoint.sh .
ENTRYPOINT ./entrypoint.sh
