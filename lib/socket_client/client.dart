import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOClient {
  late IO.Socket socket;

  SocketIOClient() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
  }

  void connectToServer() {
    socket.connect();

    socket.on('Message', (data) {
      print('Received message: $data');
    });

    socket.emit('Status', {'data': 'hello'});
  }
}
