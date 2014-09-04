// Generated by CoffeeScript 1.8.0
(function() {
  var Game, app, bodyParser, express, http, io, path;

  app = require('express')();

  express = require('express');

  http = require('http').Server(app);

  path = require('path');

  bodyParser = require('body-parser');

  io = require('socket.io')(http);

  app.set('views', path.join(__dirname, 'views'));

  app.set('view engine', 'jade');

  app.use(bodyParser.json());

  app.use(require('stylus').middleware(path.join(__dirname, 'public')));

  app.use(express["static"](path.join(__dirname, 'public')));

  app.use('/bower_components', express["static"](__dirname, '/bower_components'));

  Game = {
    add_new_top_score: function(user) {
      if (Game.top_ten_scores()[Game.top_ten_scores.length].score < user.score || Game.top_scores.length < 10) {
        return Game.top_scores.push(user);
      }
    },
    top_ten_scores: function() {
      return Game.top_scores.sort(function(a, b) {
        return b.score - a.score;
      }).slice(0, 10);
    },
    top_scores: [
      {
        name: "JD",
        score: 123
      }, {
        name: "Ed",
        score: 178
      }, {
        name: "Trevor",
        score: 230
      }
    ]
  };

  app.get("/", function(req, res) {
    console.log('serving index');
    return res.render('index');
  });

  app.get('/rules', function(req, res) {
    return res.render("rules");
  });

  app.get('/game', function(req, res) {
    console.log('serving game template');
    return res.render('game');
  });

  app.get('/game_over', function(req, res) {
    console.log('serving game_over template');
    return res.render('game_over');
  });

  app.get('/new_top_score', function(req, res) {
    console.log('serving new_top_score template');
    return res.render('new_top_score');
  });

  io.on('connection', function(socket) {
    console.log("user connected to socket");
    socket.emit('top_scores', Game.top_ten_scores());
    return socket.on('new_top_score', function(user) {
      Game.add_new_top_score(user);
      console.log("reached new_top_score with user", user);
      return socket.emit('top_scores', Game.top_ten_scores());
    });
  });

  if (app.get('env') === 'development') {
    app.use(function() {
      res.status(err.status || 500);
      return res.render('error', function() {
        return {
          message: err.message,
          error: err
        };
      });
    });
  }

  http.listen(3000, function() {
    return console.log("listening on port 3000");
  });

}).call(this);
