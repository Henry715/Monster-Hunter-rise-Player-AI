import socket

# create a socket object
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# get local machine name
host = socket.gethostname()

# connection to hostname on the port.
s.connect(("localhost", 8080))

while True:

    # succ=s.sendall(b'Thank you for connecting')


    data = s.recv(1024)
    if not data:
        print("not data")
        break
    print(data.decode('utf-8'))

