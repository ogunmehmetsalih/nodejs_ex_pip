const http = require('http');

const server = http.createServer((req, res) => {
    res.end('Merhaba Jenkins! Bu bir otomatik test.');
});

server.listen(3001, () => {
    console.log('Sunucu 3001 portunda çalışıyor...');
});

