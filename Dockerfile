FROM node:lts-alpine3.14 as build-deps
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN yarn
COPY . ./
RUN npm run build

FROM nginx:1.21-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]