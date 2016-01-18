conf = require("config")

exports.connect = (logger) ->

  io = require("socket.io")(conf.ws.port, {ransports: [conf.ws.transports]})
  console.log "Socket.io server listening on port " + conf.ws.port

  io.sockets.on "connection", (socket) ->
    
    sid = socket.id
    
    # クライアントに接続成功メッセージを表示
    socket.emit "cnOk", sid, "It was connected to the websocket server."
    

    # クライアントのKeepAliveに答える処理
    socket.on "keepAlive", (data) ->
      socket.emit "keepAlive", data
      return
  

    # 切断処理
    socket.on "disconnect", ->
  
    
    # Websocket接続数を返却
    socket.on "cnCnt", ->
      socket.emit "cnCnt", io.sockets.manager.server.connections
      return
  
    return

