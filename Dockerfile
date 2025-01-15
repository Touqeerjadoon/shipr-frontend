# Stage 1: Build the application
FROM node:16 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Serve the application using a lightweight server
FROM node:16-alpine

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app/build ./build
COPY package*.json ./

RUN npm install --only=production

CMD ["npm", "start"]