FROM bee42/node:4.4.4

# Copy list of dependencies
COPY package.json /tmp/package.json

# Install dependencies
RUN cd /tmp && npm install

# Copy dependencies libraries
RUN mkdir /app && cp -a /tmp/node_modules /app/

# Copy source code
COPY . /app

# Change current dir
WORKDIR /app

# Expose API port
ENV PORT 80
EXPOSE 80

# Run application
CMD ["npm", "start"]