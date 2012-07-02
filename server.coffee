express = require('express')
Emitter = require('events').EventEmitter
app = express.createServer()
io = require('socket.io').listen(app)
pubdir = "#{__dirname}/pub"
events = new Emitter

app.use express.bodyParser()
app.listen 4567

io.sockets.on 'connection', (sockets) ->
  events.on 'log', (data) ->
    sockets.emit 'log', data
  sockets.on 'mlog', (data) ->
    events.emit 'log', data

app.get '/', (req, res) ->
	res.sendfile "#{pubdir}/screen.html"

app.post '/log', (req, res) ->
  events.emit 'log', req.body
  res.send 200