# Use Node.js LTS as the base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Build the Vite project
RUN npm run build

# Serve the built files using a lightweight server
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 5173

# Command to start the app
CMD ["serve", "-s", "dist", "-l", "5173"]
