FROM node:20.11.1-alpine3.19 as build
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:1.26.0-alpine3.19-slim
COPY /ci/nginx.conf /data/conf/nginx.conf
COPY --from=build /dist /usr/share/nginx/html
EXPOSE 80
CMD nginx -g "daemon off;" -c "/data/conf/nginx.conf"
