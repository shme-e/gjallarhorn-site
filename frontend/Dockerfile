# Build stage
FROM node:22-alpine AS build
WORKDIR /app
COPY yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn run build

# Production stage
FROM node:22-alpine
WORKDIR /app
RUN yarn global add serve
COPY --from=build /app/dist ./dist
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
