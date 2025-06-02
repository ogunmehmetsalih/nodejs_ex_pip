# Node.js base image kullan
FROM node:18

# Uygulama dosyalarını container içine kopyala
WORKDIR /app
COPY . .

# Bağımlılıkları yükle
RUN npm install

# Uygulamayı çalıştır
CMD ["npm", "start"]

