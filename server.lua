local quest_status = require("MHR_Overlay.Game_Handler.quest_status");
local player = require("MHR_Overlay.Damage_Meter.players");
local large_monster = require("MHR_Overlay.Monsters.large_monster");

local json=json;
local re=re;
local string=string;
local tostring=tostring;
local sdk=sdk;
local table=table;


quest_status.init_module();

player.init_module();

large_monster.init_module();

local enemy_manager = sdk.get_managed_singleton("snow.enemy.EnemyManager");
local enemy_manager_type_def = sdk.find_type_definition("snow.enemy.EnemyManager");
local get_boss_enemy_count_method = enemy_manager_type_def:get_method("getBossEnemyCount"); 
local get_boss_enemy_method = enemy_manager_type_def:get_method("getBossEnemy");
package.path="D:\\SteamLibrary\\steamapps\\common\\MonsterHunterRise\\reframework"
local socket=dofile("D:\\SteamLibrary\\steamapps\\common\\MonsterHunterRise\\socket\\socket.lua")
local quest_stat=dofile("D:\\SteamLibrary\\steamapps\\common\\MonsterHunterRise\\reframework\\autorun\\stats\\quest_Info.lua")

local server = assert(socket.bind("*", 8080))

local client = server:accept()
client:settimeout(10)
print(server:getsockname())
print(client:getpeername())
-- log_to_file("Server started successfully..")

local get_UpTimeSecond = sdk.find_type_definition("via.Application"):get_method("get_UpTimeSecond")
local interval = 5 -- In seconds
local lastTime = 0.0

re.on_frame(function()

	player.update_myself_position();
	quest_status.update_is_online();

	
	if quest_status.flow_state >= quest_status.flow_states.PLAYING_QUEST and quest_status.flow_state <= quest_status.flow_states.WYVERN_RIDING_START_ANIMATION then
		-- draw_modules(config.current_config.global_settings.module_visibility.playing_quest, "Playing Quest");
		local newTime = get_UpTimeSecond:call(nil)
		if (newTime - lastTime) > interval then
			lastTime = newTime
			local world_info={quest={},
								monster_stats={},
								player_stats={	player={},
												act_position={}
											}
				}
			-- print("someting\n")
			local info=quest_stat.init_questinfo()
			local quest_result=quest_stat.get_quest_info(info)
			
			-- local message = "response\n"
			local enemy_count = get_boss_enemy_count_method:call(enemy_manager);
			-- table.insert(world_info)
			-- table.insert(world_info.quest,0,quest_result)
			world_info.quest=quest_result
			-- print(json.dump_string(quest_result).."\n")
			local player_position=player.myself_position
			world_info.player_stats.act_position={x=player_position.x,y=player_position.y,z=player_position.z}
			print(json.dump_string(player.myself))
			world_info.player_stats.player=player.myself
			-- local succ, err = client:send(json.dump_string(quest_result))
			for i = 0, enemy_count-1 do
				local enemy = get_boss_enemy_method:call(enemy_manager,i)
				
				local target_monster= large_monster.list[enemy]
				
				target_monster.static_UI=nil
				target_monster.highlighted_UI=nil
				target_monster.dynamic_UI=nil
				target_monster.act_position={x=target_monster.position.x,y=target_monster.position.y,z=target_monster.position.z}
				-- print(json.dump_string(target_monster))
				table.insert(world_info.monster_stats,i+1,target_monster)

			end
			-- print(json.dump_string(world_info).."\n")
			local succ, err = client:send(json.dump_string(world_info))
			--print("Sending" )
			-- for i = 0, enemy_count - 1 do
			-- local enemy_manager_type_def = sdk.find_type_definition("snow.enemy.EnemyManager");
			-- local get_boss_enemy_count_method = enemy_manager_type_def:get_method("getBossEnemyCount");
			-- local get_boss_enemy_method = enemy_manager_type_def:get_method("getBossEnemy");
			-- local enemy_count = get_boss_enemy_count_method:call(singletons.enemy_manager);
			-- print(type(enemy_count))
			-- local enemy = get_boss_enemy_method:call(singletons.enemy_manager, enemy_count-1);
			-- if enemy == nil then
				-- print("no enemy")
					-- -- customization_menu.status = "No enemy";
					-- -- goto continue
			-- else
				-- print("yes enemy")
				-- local target_monster= json.dump_string(large_monster.list[enemy])
				-- local enemy_position=large_monster.list[enemy].position
				
				-- local succ, err = client:send(target_monster)
				-- print(target_monster)-- next(large_monster.list[enemy]) 
				-- print(enemy_position.x,enemy_position.y,enemy_position.z)
		end
			
			
			
			-- print(ta)
			-- local player_info=json.dump_string(player)
			-- print(player.myself_position.x,player.myself_position.y,player.myself_position.z)
			-- local player_info_length=string.len(player_info)
			-- local succ, err = client:send(tostring(player_info_length)..'\n'..player_info)
			--local succ, err = client:send(json.dump_string(player))

		-- end
	end
end);

-- re.on_frame(function()
	-- local message = "response\n"
	-- --print("Sending" )
	-- singletons.init();
	-- player.update_myself_position();
	-- quest_status.update_is_online();
	-- timer.tick();
	-- -- print(player)
	-- -- print(player.list)
	-- -- print(json.dump_string(player))
	-- -- print(json.dump_string(player.list))
	-- -- print(json.dump_string(damage_hook))
	-- -- print(json.dump_string(timer))
	-- -- print(json.dump_string(player.myself_position))
	-- -- print(timer.dump_string)
	-- local player_info=json.dump_string(player)
	-- local player_info_length=string.len(player_info)
	-- -- local succ, err = client:send(tostring(player_info_length)..'\n'..player_info)
	-- local succ, err = client:send(json.dump_string(player))
	-- socket.sleep(0.0001)
-- end)

-- while true do



