# Stage 1: Build React app
FROM node:18-alpine as build
WORKDIR /app
COPY react-demo/ ./
RUN npm install && npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf


# Dockerfile
#FROM nginx:alpine
#COPY react-demo/build /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf
