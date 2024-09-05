# Use Node.js base image
FROM node:16

# Install Python 3, pip, and essential packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    gfortran \
    libatlas-base-dev \
    --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and install Node.js dependencies
COPY package*.json ./
RUN npm install

# Copy Python requirements and install dependencies
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Node.js app
CMD ["node", "index.js"]
