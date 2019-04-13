#!/usr/bin/env bash

/etc/init.d/postgresql start && \
    ./add_default_user.sh & \
    nginx & java -jar /back/dwbh-api-0.1.0-all.jar
