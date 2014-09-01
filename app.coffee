express = require('express')
path = require('path')
bodyParser = require('body-parser')
app = express()

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use bodyParser.json()
app.use require('stylus').middleware(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'public'))
app.use '/bower_components', express.static(__dirname, '/bower_components')



app.get "/", (req, res) ->
  res.render "index",
  title: "SVG Squasher"


if app.get('env') is 'development'
  app.use ->
    res.status(err.status || 500)
    res.render 'error', ->
      message: err.message
      error: err



app.listen 3000, ->
  console.log "listening on port 3000"


