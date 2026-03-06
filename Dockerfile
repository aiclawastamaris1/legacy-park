FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY v1.html /usr/share/nginx/html/v1.html
COPY v2.html /usr/share/nginx/html/v2.html
EXPOSE 80
