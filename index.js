const express = require('express');
const os = require('os');

const app = express();
const port = 8080;

const version = process.env.APP_VERSION || '1.0.0';

app.get('/', (req, res) => {
  res.send(`
    <h1>Informacje o serwerze</h1>
    <p>Adres IP serwera: ${req.ip}</p>
    <p>Nazwa serwera: ${os.hostname()}</p>
    <p>Wersja aplikacji: ${version}</p>
  `);
});

app.listen(port, () => {
  console.log(`Aplikacja działa na porcie ${port}`);
});