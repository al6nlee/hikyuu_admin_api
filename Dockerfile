FROM node:14.17.6 AS build
COPY . /opt/vue
WORKDIR /opt/vue
RUN sed -i 's/config.headers/\/\/&/' src/api/request.js
RUN npm install && npm run build

FROM nginx:1.20.1
COPY --from=build /opt/vue/dist /opt/vue/dist
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g","daemon off;"]
