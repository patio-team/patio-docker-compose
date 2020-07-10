# -------------------------------
# ---------- STAGE-1 ------------
# -------------------------------
FROM node:10.15.1 as front

ARG VUE_APP_API_URL
ARG VUE_APP_SCOPE
ARG VUE_APP_OAUTH2_CLIENT_ID
ARG VUE_APP_TOKEN_URI
ARG VUE_APP_AUTH_URI

RUN git clone --single-branch https://github.com/patio-team/patio-front.git /build/dwbh-front
WORKDIR /build/dwbh-front

# Configuring variable to tell front end where to find back end
# endpoint right before building the distribution
RUN yarn add -D vue-cli && yarn build

# -------------------------------
# ---------- STAGE-2 ------------
# -------------------------------
FROM nginx:1.17-alpine as container

# NGINX >> CONFIG
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY --from=front /build/dwbh-front/dist /var/www/html

EXPOSE 80
