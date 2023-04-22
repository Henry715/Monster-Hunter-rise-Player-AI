import socket
import json
import threading
def recvall(sock, n):
    data = b''
    while len(data) < n:
        packet = sock.recv(n - len(data))
        if not packet:
            return None
        data += packet
    return data

def receive_data(client):
    while True:
        length = 1024
        jsonString = recvall(client, length).decode()
        data = json.loads(jsonString)
        print(data)
        # process the received data
def receive_all(sock):
    data = b''
    while True:
        chunk = sock.recv(4096)
        if not chunk:
            break
        data += chunk
    print(data)
    return data
if __name__=="__main__":
    # create a socket object
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    
    # get local machine name
    host = socket.gethostname()
    
    # connection to hostname on the port.
    s.connect(("localhost", 8080))
    # while True:
    # receive_thread = threading.Thread(target=receive_data, args=(s,))
    # receive_thread.start()

    while True:
    
        message = ''
    
        while True:
            # Receive data from the server
            data = s.recv(1024)
            
            # Decode the data from bytes to string
            chunk = data.decode('utf-8')
            
            # Concatenate the chunk to the message
            message += chunk
            
            # Check if the entire message has been received
            if len(data) < 1024:
                break
        
        # Load the message as a JSON object
        message_json = json.loads(message)
        
        # Print the message
        # print(message_json['total']['display']['total_damage'])
        
        print(message_json)        # break
    #     # succ=s.sendall(b'Thank you for connecting')
        
    
    #     data = receive_all(s)#s.recv(9000)
    #     if not data:
    #         print("not data")
    #         break
    #     print(data.decode('utf-8'))
        # print(json.loads(data.decode('utf-8')))
        # length = int(data.decode('utf-8'))
        # jsonString = data.recv(length).decode()
        # # datas=data.decode('utf-8')
        # # print(datas)
        # print(json.loads(jsonString))
        # print()
    
