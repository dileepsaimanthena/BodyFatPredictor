# Use Python base image with Node.js installed
FROM python:3.9-slim

# Install Node.js and necessary packages
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs build-essential gfortran libatlas-base-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN python3 -m pip install --upgrade pip

# Set working directory and copy package files
WORKDIR /usr/src/app
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy requirements file and install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Node.js app
CMD ["node", "index.js"]
