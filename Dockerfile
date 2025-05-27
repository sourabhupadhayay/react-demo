# Dockerfile
FROM nginx:alpine
COPY react-app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
