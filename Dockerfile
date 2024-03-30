
# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available) to the working directory
COPY package*.json ./

# Install any necessary dependencies...
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Make port 8080 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NODE_ENV=production

# Run server.js when the container launches
CMD ["node", "server.js"]

