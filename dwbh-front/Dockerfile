# -------------------------------
# ---------- STAGE-1 ------------
# -------------------------------
FROM node:10.15.1 as front

RUN git clone --single-branch https://github.com/dont-worry-be-happy/dwbh-front.git /build/dwbh-front
WORKDIR /build/dwbh-front

# Production configuration
COPY files/.env.production /build/dwbh-front

# Configuring variable to tell front end where to find back end
# endpoint right before building the distribution
RUN sed -i "s/\$DWBH_API_URL/\/graphql/g" .env
RUN yarn add -D vue-cli && yarn build

# -------------------------------
# ---------- STAGE-2 ------------
# -------------------------------
FROM nginx:1.17-alpine as container

# NGINX >> CONFIG
COPY files/nginx.conf /etc/nginx/nginx.conf
COPY --from=front /build/dwbh-front/dist /var/www/html

EXPOSE 80
