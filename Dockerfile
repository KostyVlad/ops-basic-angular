# build stage
FROM node:16 AS build
WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build --prod

# serve stage
FROM nginx:alpine
COPY --from=build /app/dist/webapp /usr/share/nginx/html
