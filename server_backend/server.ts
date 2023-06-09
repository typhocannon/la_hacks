import * as http from 'http';
import {Server as SocketIOServer, Socket } from 'socket.io';
import express from 'express';
import { Request, Response } from 'express';

const app = express();
const server = http.createServer(app);
const ioServer = new SocketIOServer(server, { cors: {origin: "*"}});

app.get('/', (req: Request, res: Response) => {
  res.send(`health check -- ${process.env.BUILD_ENV}`)
})


ioServer.on('connection', (socket: Socket) => {
  console.log('A user connected with id ' + socket.id);
  
  socket.on('switch', (Status: boolean) => {
    console.log("New switch:", Status);
    ioServer.emit("Status: ", Status);
  })
});

const PORT = process.env.PORT || 3000;

server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});

