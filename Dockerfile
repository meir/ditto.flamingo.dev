FROM node:15.3.0-alpine3.10

RUN npm run export

FROM nginx:1.15.4

COPY ./__sapper__/export /usr/share/nginx/html
