# Monster-Hunter-rise-Player-AI
This is the starting point of building a MHR Player AI(I'm not a expert in this field, I just thought it would be fun), join me if you'd like!
remember to install reframework(download the plugin and follow the installation here: https://www.nexusmods.com/monsterhunterrise/mods/26) and run the game at least once.
# Lua & Python info
The dll for the socket module is compiled with lua 5.4.4(as far as I know, it is also the version that the game uses).
For running the python client, I would recommend you to install anaconda to manage the virtual environment and packages. The python version I'm using is 3.9.16, so I would recommand you to install the same version as well. After the python setup, download the spyder editor from anaconda to load the clint.py file. press the green triangular button under the debug tab to run python script.
# Developing state
Well, now the server only sends a message "response" to the client and the client will print it out on the console, it's just a starting point right now, and hopefully I can work on this project till it's finished. And like I said, I'm not an expert in deep reinforcement learning, and this is the first time me creating a MHR game mod. But I know if a person needs to train an AI for a game, the game information and the game stats is crucial, which is what I am doing now, to make the game info and game stats available. So I need experts or maybe just enthusiasts to tell me if the game info is enough for training AI, thanks a lot in advance. If you are also interested, please don't hesitate to join(I am not familiar with any of the github settings, if you need some changes, say role allocation or whatever, please let me know and give me some details of how to achieve that, thank you.)
# Game stats to send for now
now the server sends no useful information, but there are some that is already on my mind, for example, the position, HP of the player and monster, damages received, damages caused by the player and the monster, quest stats(# of carts, fail or success?), quest time, maybe even buff stats.
# File location
After you installed reframework plugin (run the game once and you'll have the auto run folder),

put the server.lua into autorun folder:![1681821866882](https://user-images.githubusercontent.com/66408806/232782011-d4037919-3eb0-4b0e-ad47-847b63baefe0.png)
And then put the socket folder into the game's root folder:![1681821883470](https://user-images.githubusercontent.com/66408806/232782156-2af22a25-0c5c-4ac6-9240-41b62e2c208a.png)

In terms of Python client, you can put it anywhere you'd like, as long as you can run the client, that would be fine.
And start the game again, after a while you might see the game freezes, don't worry, because that is the server waiting for a connection from the client. After you start the client, the game will run the same as expected.
# About me
I'm just a computer science student that just graduated from university and loves Monster Hunter series. By the way, I'm Chinese, in case if you'd like to communicate in Chinese.

