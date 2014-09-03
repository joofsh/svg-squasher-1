@socket = io()
@app = angular.module 'BugApp', ['ngRoute']

@app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/rules',
    templateUrl: '/rules'
  ).when('/game',
    templateUrl: '/game'
  ).when('/game_over',
    templateUrl: '/game_over'
  ).when('/new_top_score',
    templateUrl: '/new_top_score'
  ).otherwise redirectTo: '/rules'
]
@app.controller 'GameCtrl', ($rootScope, $scope, $interval, $location) ->
  window.scope = $scope

  $scope.users =
    green_class: (user) ->
      $scope.user.name is user.name

  $scope.user =
    score: 0
  $scope.game =
    create_bug_interval: null
    bug_move_interval: null
    bug_rate: 2000
    bugs: []
    bug_position: (lat, long) ->
      {left: long, top: lat}

  $scope.timer =
    clock: 0
    show_clock: ->
      Math.round($scope.timer.clock/1000)
    offset: null
    interval: null
    delta: ->
      now = Date.now()
      tmp = Date.now() - $scope.timer.offset
      $scope.timer.offset = now
      tmp
    update: ->
      $scope.timer.clock += $scope.timer.delta()


  $scope.create_bug = ->
    if $scope.timer.clock/1000 > 60
      bug = new HardBug
    else if $scope.timer.clock/1000 > 30
      bug = new MediumBug
    else
      bug = new EasyBug

    bug.lat = Math.floor((Math.random() * 420) + 1)
    $scope.game.bugs.push(bug)
    console.log "created new bug!"


  $scope.move_to_end_view = ->
    if $scope.user.score > $scope.users.top_scores[$scope.users.top_scores.length-1].score or $scope.users.top_scores.length < 10
      $location.path('/new_top_score')
    else
      $location.path('/game_over')

  $scope.check_for_game_end = ->
    for bug in $scope.game.bugs
      if bug.long >= 1080
        console.log "Bug reached the end! Ending game"
        $scope.stop_game()
        $scope.game.bugs = []
        $scope.move_to_end_view()
        break




  $scope.restart_game = ->
    $scope.stop_game()
    $scope.game.bugs = []
    $scope.timer.clock = 0
    $scope.user.score = 0
    $location.path('/rules')

  $scope.stop_game = ->
    $interval.cancel($scope.timer.interval) if $scope.timer.interval
    $interval.cancel($scope.game.create_bug_interval) if $scope.game.create_bug_interval
    $interval.cancel($scope.game.bug_move_interval) if $scope.game.bug_move_interval
    $scope.game.create_bug_interval = null
    $scope.game.bug_move_interval = null
    $scope.timer.interval = null

  $scope.initial_game_start = ->
    $location.path('/game')
    $scope.start_game()

  $scope.start_game = ->
    $scope.timer.offset = Date.now()
    $scope.timer.interval = $interval(->
      console.log "running game time interval"
      $scope.timer.update()
    , 200)
    $scope.game.bug_move_interval = $interval(->
      bug.move() for bug in $scope.game.bugs
    , 2000)


    $scope.set_bug_interval = (speed) ->

    $scope.set_bug_interval()

    $scope.game.create_bug_interval = $interval (->
      $scope.create_bug()
      $scope.check_for_game_end()
    ), $scope.game.bug_rate

  $scope.kill_bug = (bug) ->
    if $scope.timer.interval
      ind = $scope.game.bugs.indexOf(bug)
      $scope.game.bugs.splice(ind, 1)
      $scope.user.score += bug.points

  $scope.set_bug_interval = ->
    $interval.cancel($scope.game.create_bug_interval)
    $scope.game.create_bug_interval = $interval (->
    ), $scope.game.bug_rate


  $scope.$watch 'timer.clock', (timer) ->
    $location.path('/rules') if timer is 0
    if timer/1000 > 30
      $scope.game.bug_rate = 1000
      $scope.set_bug_interval()
    else if timer/1000 > 60
      $scope.game.bug_rate = 500
      $scope.set_bug_interval()

  socket.on 'top_scores', (top_scores) ->
    console.log 'top scores received from server'
    $scope.$apply($scope.users.top_scores = top_scores)


# Bug object templating
Bug =
  lat: 0.0
  long: 0.0
  move: ->
    @long = @long + @speed
    @lat = Math.floor(Math.random() * 400) + 1
    @long = 1100 if @long > 1100
    console.log "moving bug to #{@long} long and #{@lat} lat"


EasyBug = ->
  bug = Object.create(Bug)
  bug.speed = 100
  bug.points = 10
  bug.ratio = 1
  bug.color = 'green'
  bug

MediumBug = ->
  bug = Object.create(Bug)
  bug.speed = 200
  bug.points = 30
  bug.ratio = .6
  bug.color = 'orange'
  bug

HardBug = ->
  bug = Object.create(Bug)
  bug.speed = 300
  bug.points = 50
  bug.ratio = .3
  bug.color = 'red'
  bug

