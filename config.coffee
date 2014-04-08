module.exports = 
  port: Number(process.env.PORT or 8888)
  host: process.env.THYME_HOST or 'localhost:8888'
  clients: [
    /localhost:.*/,
    'thyme-frontend.s3-website-us-west-1.amazonaws.com'
  ]
  dirname: __dirname 
  db:
    url: process.env.THYME_DB_URL or 'mongodb://localhost/thyme-dev'
  session:
    secret: process.env.THYME_SESSION_SECRET or 'illlklklklk'
    cookie_secret: process.env.THYME_COOKIE_SECRET or 'slfklksdjf'
    cookie_domain: process.env.THYME_COOKIE_DOMAIN or 'localhost'
