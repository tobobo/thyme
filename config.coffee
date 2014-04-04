module.exports = 
  port: Number(process.env.PORT or 8888)
  dirname: __dirname 
  db:
    url: 'mongodb://localhost/thyme-dev'
  session:
    secret: 'illlklklklk'
    cookie_secret: 'slfklksdjf'
    cookie_domain: 'localhost'
