# Monster-Hunter-rise-Player-AI
This is the starting point of building a MHR Player AI(I'm not a expert in this field, I just thought it would be fun), join me if you like!
remember to install reframework(download the plugin and follow the installation here: https://www.nexusmods.com/monsterhunterrise/mods/26) and run the game at least once.
# Lua & Python info
The dll for the socket module is compiled with lua 5.4.4(as far as I know, it is also the version that the game uses)
For running the python client, I would recommend you to install anaconda to manage the virtual environment and packages. The python version I'm using is 3.9.16, so I would recommand you to install the same version as well. After the python setup, download the spyder editor from anaconda to load the clint.py file. press the green triangular button under the debug tab to run python script.
# File location
After you installed reframework plugin,

put the server.lua into autorun folder:![1681821866882](https://user-images.githubusercontent.com/66408806/232782011-d4037919-3eb0-4b0e-ad47-847b63baefe0.png)
And then put the socket folder into the game's root folder:![1681821883470](https://user-images.githubusercontent.com/66408806/232782156-2af22a25-0c5c-4ac6-9240-41b62e2c208a.png)

And start the game again, after a while you might see the game freezes, don't worry, because that is the server waiting for a connection from the client. After you start the client, the game will run the same as expected.
