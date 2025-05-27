# Stage 1: Build React app
FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

#<<<<<<< HEAD
#=======

# Dockerfile
#FROM nginx:alpine
#COPY react-demo/build /usr/share/nginx/html
#COPY nginx.conf /etc/nginx/nginx.conf
#>>>>>>> fc3c8789a994d4012f64a6fd6e71934195f360cd
