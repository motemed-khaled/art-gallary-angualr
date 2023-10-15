# Stage 1: Build the Angular app
FROM node:18.18.0 AS production

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build --prod

# Stage 2: Serve the app using Nginx
FROM nginx:stable-alpine

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=production /app/dist/art-gallary-uangular-ui /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
