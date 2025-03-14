FROM node:22-alpine as builder
WORKDIR /app
COPY package*.json .
RUN npm ci # install dependencies
COPY . .
RUN npm run build # execute build process defined in package.json

FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]