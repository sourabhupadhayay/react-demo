# Dockerfile
FROM nginx:alpine
COPY react-demo/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
