# Etap 1: Budowanie aplikacji
FROM node:alpine AS build

WORKDIR /usr/app

# Skopiowanie plików aplikacji
COPY ./package.json ./
RUN npm install

# Skopiowanie pozostałych plików aplikacji
COPY ./index.js ./

# Zdefiniowanie wersji aplikacji jako argumentu budowania
ARG VERSION
ENV APP_VERSION=${VERSION}

# Etap 2: Budowanie obrazu końcowego
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

# Usunięcie domyślnej strony Nginx
RUN rm -rf ./*

# Skopiowanie plików z etapu 1
COPY --from=build /usr/app ./

# Ustawienie zdrowia kontenera
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s \
  CMD curl -f http://localhost:8080/ || exit 1

# Eksponowanie portu
EXPOSE 8888

# Uruchomienie aplikacji
CMD ["nginx", "-g", "daemon off;"]