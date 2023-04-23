import socketio

# standard python client
sio = socketio.Client()

# boolean state to check
global switch
switch = False
# functions to debug connection
@sio.event
def connect():
    print("Connected")
    # event handler that takes in data and spits it out to the raspberry pi
    while True:
        print(switch)

@sio.event
def connect_error():
    print("Unsuccessful Connection")

    
@sio.on("Status: ")
def receive_data(data):
    global switch
    switch = data

# connect to the server 
sio.connect('http://localhost:3000')
