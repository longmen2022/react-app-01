#### stage 1
FROM node:19-alpine as build

WORKDIR /app
COPY package*.json ./

RUN npm install 
COPY . .

RUN npm run build 


### stage 2

FROM nginx:1.21.0-alpine

COPY ngnix.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]