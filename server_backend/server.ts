import * as http from 'http';
import {Server as SocketIOServer, Socket } from 'socket.io';
import express from 'express';

const app = express();
const server = http.createServer(app);
const ioServer = new SocketIOServer(server);

ioServer.on('connection', (socket: Socket) => {
  console.log('A user connected');
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

ioServer.on('Switch', (Status: boolean) => {
    ioServer.emit("Status: ", Status);
})
