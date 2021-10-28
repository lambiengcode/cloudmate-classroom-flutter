import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

void connectAndListen() async {
  disconnectBeforeConnect();
  String socketUrl = Application.baseUrl!;
  socket = IO.io(
    socketUrl,
    IO.OptionBuilder().enableForceNew().setTransports(['websocket']).setExtraHeaders({
      'Authorization': 'Bearer ' + UserLocal().getAccessToken(),
    }).build(),
  );
  socket!.connect();
  socket!.onConnect((_) {
    debugPrint('connected');
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
