FROM node:14

# RUN mkdir app

WORKDIR /usr/src/app

# Create app directory

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)

# Bundle app source
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

COPY . .

CMD [ "npm", "start" ]



