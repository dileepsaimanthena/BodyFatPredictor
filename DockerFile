# Use Node.js base image
FROM node:16

# Install Python 3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Set working directory and copy app files
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

# Install Python dependencies (e.g., sklearn, pandas)
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Node.js app
CMD ["node", "index.js"]