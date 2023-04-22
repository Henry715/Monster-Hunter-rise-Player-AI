local sdk=sdk;
local json=json;
local quest_stats={}

local managed_questManager=sdk.get_managed_singleton("snow.QuestManager");

local quest_manager_definition=sdk.find_type_definition("snow.QuestManager");
local field_definition=quest_manager_definition:get_field("_QuestTargetData");


local quest_life_method = quest_manager_definition:get_method("getQuestLife");
local death_number_method=quest_manager_definition:get_method("getDeathNum");
local total_target_num_method=quest_manager_definition:get_method("getQuestTargetTotalTgtNum");
local total_target_count_method=quest_manager_definition:get_method("getQuestTargetTotalCount");


local quest_total_time_min_method = quest_manager_definition:get_method("getQuestMaxTimeMin");

local get_quest_elapsed_time_min_method = quest_manager_definition:get_method("getQuestElapsedTimeMin");
local get_quest_elapsed_time_sec_method = quest_manager_definition:get_method("getQuestElapsedTimeSec");



local check_clear_method=quest_manager_definition:get_method("checkQuestClear");
local get_UpTimeSecond = sdk.find_type_definition("via.Application"):get_method("get_UpTimeSecond");
-- local interval = 5 -- In seconds
-- local lastTime = 0.0
-- local quest_status = require("MHR_Overlay.Game_Handler.quest_status");
-- quest_status.init_module();

function quest_stats.get_quest_info(quest_info_table)
	
	local real_array = field_definition:get_data(managed_questManager)
	local clear_info=check_clear_method:call(managed_questManager)
	local quest_life=quest_life_method:call(managed_questManager)
	local player_cart=death_number_method:call(managed_questManager)
	local elapsed_time_sec=get_quest_elapsed_time_sec_method:call(managed_questManager)
	local elapsed_time_min=get_quest_elapsed_time_min_method:call(managed_questManager)
	local quest_max_time=quest_total_time_min_method:call(managed_questManager)
	local total_target_count=total_target_count_method:call(managed_questManager)
	local total_target_num=total_target_num_method:call(managed_questManager)
	-- print(total_target_count, total_target_num)
	-- assign values to right field
	local array_count = real_array:call("get_Count")

	for i = 0, array_count-1 do
		local tbl=real_array:call("get_Item",i)
		-- print(real_array:call("get_Item",0):get_field("ID"))
		local ID = tbl:get_field("ID")
		if i ==0 and array_count ==11 and ID == 0 then
			message={response="no quest right now"}
			--print("no quest right now")
			return message
		end
		if  ID ~= 0 then
			local target_info={}
			-- print(ID)
			target_info.ID=ID
			target_info.Count=tbl:get_field("Count")
			target_info.Flag=tbl:get_field("Flag")
			-- print(json.dump_string(target_info))
			-- quest_info_table.target_num=quest_info_table.target_num + info_table.Count
			table.insert(quest_info_table.target_monster,i+1,target_info)
		end
		
		
	end
	quest_info_table.life_total=quest_life
	quest_info_table.quest_elapsed_time_sec=elapsed_time_sec
	quest_info_table.quest_elapsed_time_min=elapsed_time_min
	quest_info_table.quest_clear_flag=clear_info
	quest_info_table.cart=player_cart
	quest_info_table.quest_num_target=total_target_num
	quest_info_table.quest_num_DeadTarget=total_target_count
	quest_info_table.cart_remaining=quest_life-player_cart
	quest_info_table.quest_timeLimit=quest_max_time
	return quest_info_table
end

function quest_stats.init_questinfo()
	local quest_info={
			 target_monster={},
			 --target_num=0,
			 cart_remaining=0,
			 life_total=0,
			 cart=0,
			 quest_elapsed_time_sec=0,
			 quest_elapsed_time_min=0,
			 quest_timeLimit=0, -- in minutes!
			 quest_num_target=0,
			 quest_num_DeadTarget=0,
			 quest_clear_flag=false
		}
	return quest_info
end
-- re.on_frame(function()
		-- local quest_info={
			 -- target_monster={},
			 -- --target_num=0,
			 -- cart_remaining=0,
			 -- life_total=0,
			 -- cart=0,
			 -- quest_elapsed_time_sec=0,
			 -- quest_elapsed_time_min=0,
			 -- quest_timeLimit=0, -- in minutes!
			 -- quest_num_target=0,
			 -- quest_num_DeadTarget=0,
			 -- quest_clear_flag=false
		-- }
		-- quest_status.update_is_online();
		
		-- local newTime = get_UpTimeSecond:call(nil)
		
		-- if (newTime - lastTime) > interval then
			-- lastTime = newTime

			-- local info=get_quest_info(quest_info)
			
			-- print(json.dump_string(info).."\n")
		-- end
-- end)

return quest_stats;
-- print(quest_life,quest_cart,elapsed_time_sec)
-- print(clear_info)
-- re.on_frame(function()
	-- -- os.clock()
	-- local elapsed_time_sec=get_quest_elapsed_time_sec_method:call(sdk.get_managed_singleton("snow.QuestManager"))
	-- print(quest_life,quest_cart,elapsed_time_sec)
-- end);

	-- print(elapsed_time_sec)
-- local quest_data_obj=quest_data:call(sdk.get_managed_singleton("snow.QuestManager"),real_array)
-- local to_manage=sdk.to_managed_object(quest_data_obj)
-- print(to_manage:call("get_Count"))
--print(mystery_Data_Array:get_field("_HuntTargetNum"))
--print(real_array)


-- for k,v in pairs(real_array) do
  -- print(k,v)
-- end
-- if real_array ~=nil then
	-- print("yay!")
-- else
	-- print("Shit")
-- end
-- re.on_frame(function()
	-- local CharacterController_type = sdk.find_type_definition("via.physics.CharacterController")
	-- local PlayMan = sdk.get_managed_singleton("snow.player.PlayerManager")
	-- if not PlayMan then return end
	-- -- local MasterPlayer = PlayMan:call("findMasterPlayer")
	-- -- if not MasterPlayer then return end

	-- local player = PlayMan:call("getMasterPlayerID")	
	-- if not player or player > 4 then return end
	
	-- local MasterPlayer = PlayMan:get_field("PlayerList"):call("get_Item", player)
	-- if not MasterPlayer then return end


	-- local CharacterController = MasterPlayer:call("getCharacterController")
	-- if not CharacterController then return end

		-- --show 3d pos you
	-- local playerPos = sdk.call_native_func(CharacterController, CharacterController_type, "get_Position")
	-- if playerPos then
		-- print(playerPos)
		-- draw.world_text("MasterPlayer", playerPos, 0xFFFFFFFF)
	-- end
-- end
-- );