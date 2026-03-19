FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

# 🔍 DEBUG: check scripts
RUN cat package.json

RUN npm install

COPY . .

# 🔍 DEBUG again
RUN cat package.json

RUN npm run build

FROM node:20-alpine AS runtime
WORKDIR /app

ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=builder /app/dist ./dist
COPY public ./public

EXPOSE 7000
CMD ["node", "dist/index.js"]