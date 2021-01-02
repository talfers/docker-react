# START PHASE 1
# Get node base image
FROM node:alpine

# Set working directory
WORKDIR /app

# Copy over package.json
COPY /package.json ./

# Install dependencies
RUN npm install

# Copy over all project files
COPY ./ ./

# Run the npm build process
RUN npm run build

# START PHASE 2
# Get nginx base image
FROM nginx

# Expose correct port for AWS (elastic beanstalk)
EXPOSE 80

# Copy over build directory (files that need a server) to nginx directory
COPY --from=0 /app/build /usr/share/nginx/html
