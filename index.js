const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// app.get('/', (req, res) => res.send('Hello World!'));

// app.listen(port, () => console.log(`Example app listening on port ${port}!`));

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.get('/', (req, res) => {
  res.json({ info: 'Node.js, Express, and Postgres API' })
});

app.listen(port, () => {
  console.log(`App running on port ${port}`)
});
