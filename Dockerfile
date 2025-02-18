FROM node:20-alpine AS build
# setup
RUN npm install -g @angular/cli
WORKDIR /build
# dependencies
COPY package.json .
RUN npm install
# build
COPY . .
RUN ng build --configuration production

FROM nginx:1-alpine AS web
# copy config
COPY nginx.conf /etc/nginx/nginx.conf
# copy web files
COPY --from=build /build/dist/c2-server-web/browser /usr/share/nginx/html
# run
EXPOSE 80
