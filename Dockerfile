# Use the official Node.js 20 image as a base
FROM node:20.16.0-bullseye-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available) to install dependencies
COPY . .

RUN npm run build

# Set the script as the default command
CMD ["node", "dist/informer.js"]
