import socket
import json


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
        quest_json=message_json["quest"]
        monster_stats_json=message_json["monster_stats"][0]["act_position"]
        player_pos_json=message_json["player_stats"]["act_position"]
        player_stats_json=message_json["player_stats"]["player"]
        print(quest_json)   
        print(monster_stats_json)# break
        print(player_stats_json)
        print(player_pos_json)
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
    
