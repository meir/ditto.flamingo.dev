FROM node:15.3.0-alpine3.10

COPY . .

RUN npm install
RUN npm run export

CMD npx serve __sapper__/export
