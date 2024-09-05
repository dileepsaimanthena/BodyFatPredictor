# Use Node.js base image
FROM node:16

# Install Python 3.12 and pip, along with necessary build tools
RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-dev \
    python3.12-distutils \
    python3-pip \
    build-essential \
    gfortran \
    libatlas-base-dev

# Upgrade pip to the latest version to ensure compatibility
RUN python3.12 -m pip install --upgrade pip

# Set working directory and copy package files
WORKDIR /usr/src/app
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy requirements file and install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Copy the rest of the application files
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Node.js app
CMD ["node", "index.js"]
