app = require('express')()
express= require('express')
http = require('http').Server(app)
path = require('path')
bodyParser = require('body-parser')
io = require('socket.io')(http)

app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use bodyParser.json()
app.use require('stylus').middleware(path.join(__dirname, 'public'))
app.use express.static(path.join(__dirname, 'public'))
app.use '/bower_components', express.static(__dirname, '/bower_components')

Game =
  add_new_top_score: (user) ->
    if Game.top_ten_scores()[Game.top_ten_scores.length].score < user.score or Game.top_scores.length < 10
      Game.top_scores.push(user)

  top_ten_scores: ->
    Game.top_scores.sort((a, b) -> b.score - a.score).slice(0, 10)

  # Dummy data
  top_scores: [
    {name: "JD", score: 123},
    {name: "Ed", score: 178},
    {name: "Trevor", score: 230}
  ]

app.get "/", (req, res) ->
  console.log 'serving index'
  res.render 'index'

# Routes for angular templates
app.get '/rules', (req, res) ->
  res.render "rules"

app.get '/game', (req, res) ->
  console.log 'serving game template'
  res.render 'game'

app.get '/game_over', (req, res) ->
  console.log 'serving game_over template'
  res.render 'game_over'

app.get '/new_top_score', (req, res) ->
  console.log 'serving new_top_score template'
  res.render 'new_top_score'


# IO sockets for handling top 10 scores
io.on 'connection', (socket) ->
  console.log "user connected to socket"
  socket.emit 'top_scores', Game.top_ten_scores()

  socket.on 'new_top_score', (user) ->
    Game.add_new_top_score(user)
    console.log "reached new_top_score with user", user
    socket.emit 'top_scores', Game.top_ten_scores()


if app.get('env') is 'development'
  app.use ->
    res.status(err.status || 500)
    res.render 'error', ->
      message: err.message
      error: err



http.listen 3000, ->
  console.log "listening on port 3000"


