import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

void connectAndListen() async {
  disconnectBeforeConnect();
  String socketUrl = 'http://139.180.211.98:3005';
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder().enableForceNew().setTransports(['websocket']).build(),
  );
  socket!.connect();
  socket!.onConnect((_) {
    debugPrint('connect');
    socket!.onDisconnect((_) => debugPrint('disconnect'));
  });
}

void disconnectBeforeConnect() {
  if (socket != null) {
    if (socket!.connected) {
      socket!.disconnect();
    }
  }
}
