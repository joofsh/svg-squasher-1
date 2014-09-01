@app = angular.module 'BugApp', []

@app.controller 'GameCtrl', ($scope, $interval) ->
  window.scope = $scope
  $scope.game =
    interval: null
    score: 0
    bug_rate: 2000
    bugs: []

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
    if $scope.timer.clock/1000 > 120
      bug = new HardBug
    else if $scope.timer.clock/1000 > 60
      bug = new MediumBug
    else
      bug = new EasyBug

    bug.lat = Math.floor((Math.random() * 100) + 1)
    $scope.game.bugs.push(bug)
    console.log "created new bug!"


  $scope.pause_game = ->
    $interval.cancel($scope.timer.interval) if $scope.timer.interval
    $interval.cancel($scope.game.interval) if $scope.game.interval
    $scope.game.interval = null
    $scope.timer.interval = null

  $scope.start_game = ->
    $scope.timer.offset = Date.now()
    $scope.timer.interval = $interval(->
      console.log "running game time interval"
      $scope.timer.update()
    , 200)

    $scope.game.interval = $interval (->
      bug.move() for bug in $scope.game.bugs
      $scope.create_bug()
    ), $scope.game.bug_rate

  $scope.kill_bug = ->


Bug =
  lat: 0.0
  long: 0.0
  move: ->
    @long = @long + @speed
    @lat = @lat + Math.floor((Math.random() * @speed) + 1)
    console.log "moving bug to #{@long} long and #{@lat} lat"


EasyBug = ->
  bug = Object.create(Bug)
  bug.speed = 1
  bug.color = 'green'
  bug

MediumBug = ->
  bug = Object.create(Bug)
  bug.speed = 2
  bug.color = 'orange'
  bug

HardBug = ->
  bug = Object.create(Bug)
  bug.speed = 3
  bug.color = 'red'
  bug

