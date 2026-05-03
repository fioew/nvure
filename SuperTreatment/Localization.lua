stimport = ""

BINDING_HEADER_SUPERTREATMENT = "晋升堡垒";
BINDING_NAME_SuperTreatment_SHOW = "SuperTreatment_SHOW";
BINDING_NAME_SuperTreatment_STARTSTOP = "SuperTreatment_STARTSTOP";
BINDING_NAME_SuperTreatment_RUN = "SuperTreatment_RUN";
BINDING_NAME_SuperTreatment_AUTO = "SuperTreatment_AUTO";
BINDING_NAME_SuperTreatment_BURSTS = "SuperTreatment_BURSTS";
BINDING_NAME_SuperTreatment_STOPAL = "SuperTreatment_STOPALL";
BINDING_NAME_SuperTreatment_CastProgram1 = "SuperTreatment_CastProgram1";
BINDING_NAME_SuperTreatment_CastProgram2 = "SuperTreatment_CastProgram2";
BINDING_NAME_SuperTreatment_CastProgram3 = "SuperTreatment_CastProgram3";
BINDING_NAME_SuperTreatment_CastProgram4 = "SuperTreatment_CastProgram4";
BINDING_NAME_SuperTreatment_CastProgram5 = "SuperTreatment_CastProgram5";
BINDING_NAME_SuperTreatment_CastProgram6 = "SuperTreatment_CastProgram6";
BINDING_NAME_SuperTreatment_CastProgram7 = "SuperTreatment_CastProgram7";
BINDING_NAME_SuperTreatment_CastProgram8 = "SuperTreatment_CastProgram8";
BINDING_NAME_SuperTreatment_CastProgram9 = "SuperTreatment_CastProgram9";
BINDING_NAME_SuperTreatment_CastProgram10 = "SuperTreatment_CastProgram10";
BINDING_NAME_SuperTreatment_CastProgram11 = "SuperTreatment_CastProgram11";
BINDING_NAME_SuperTreatment_CastProgram12 = "SuperTreatment_CastProgram12";
BINDING_NAME_SuperTreatment_RunProgram1 = "SuperTreatment_RunProgram1";
BINDING_NAME_SuperTreatment_RunProgram2 = "SuperTreatment_RunProgram2";
BINDING_NAME_SuperTreatment_RunProgram3 = "SuperTreatment_RunProgram3";
BINDING_NAME_SuperTreatment_RunProgram4 = "SuperTreatment_RunProgram4";
BINDING_NAME_SuperTreatment_RunProgram5 = "SuperTreatment_RunProgram5";
BINDING_NAME_SuperTreatment_RunProgram6 = "SuperTreatment_RunProgram6";
BINDING_NAME_SuperTreatment_RunProgram7 = "SuperTreatment_RunProgram7";
BINDING_NAME_SuperTreatment_RunProgram8 = "SuperTreatment_RunProgram8";
BINDING_NAME_SuperTreatment_RunProgram9 = "SuperTreatment_RunProgram9";
BINDING_NAME_SuperTreatment_RunProgram10 = "SuperTreatment_RunProgram10";
BINDING_NAME_SuperTreatment_RunProgram11 = "SuperTreatment_RunProgram11";
BINDING_NAME_SuperTreatment_RunProgram12 = "SuperTreatment_RunProgram12";


BACKDROP_SUPERTREATMENT_TOOLTIP = {
	bgFile = [[Interface\\Tooltips\\UI-Tooltip-Background]],
 	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	tile = true, tileSize = 16, edgeSize = 16,
    insets = {left = 3, right = 3, top = 3, bottom = 3}
};

function LoadSister_357FC8E() 
	if UnitAffectingCombat("player") == nil then
		local temp = CreateFrame('Button', 'wowamSister',UIParent, 'SecureActionButtonTemplate')
		temp:SetAttribute('type', 'macro')
		temp:SetAttribute('macrotext','/run type(1)' .. string.rep(' ', 544))
		SetOverrideBindingClick(temp, true,'Insert',temp:GetName())
		LoadSister_357FC8E_Loaded_Variable = true --避免衝突
		--print("Loaded!")
	end
end

local function LoadCommonScript()
	if IsLoad_runspell then return end
	local GetEclipseDirection = _G.GetEclipseDirection
	local UnitGUID = _G.UnitGUID
	local UnitName = _G.UnitName
	local GetActionCooldown = _G.GetActionCooldown
	local UnitIsUnit = _G.UnitIsUnit
	local stime = GetTime()
	am_index = {}
	for i = 1 , 700 do 
		am_index[i] = 0
	end
	am_index[1] = tonumber("910000000010")
	am_index[300] = tonumber("820000000010")
	am_index[2] = 100

	local tempFrame = CreateFrame("Frame")
		tempFrame:RegisterEvent("PLAYER_LOGOUT")
		tempFrame:RegisterEvent("PLAYER_LOGIN")

	local function tempFrame_OnEvent(self, event, ...)
		if ( event == "PLAYER_LOGIN" ) then
			am_index[2] = 100
		elseif ( event == "PLAYER_LOGOUT" ) then
			am_index[2] = 101
			am_index[1] = 0
		end
	end

	local function tempFrame_OnUpdate()
		if am_index[3] == 100 then
			am_index[3] = 101
		end

		if am_index[4]~= 0 and GetTime() - stime > 0.5 then
			am_index[4] = 0
			stime = GetTime()
		end
		if am_index[4] == 0 then
			stime=GetTime()
		end
	end
	tempFrame:SetScript("OnEvent", tempFrame_OnEvent)
	tempFrame:SetScript("OnUpdate",tempFrame_OnUpdate)
	-----------------------------
	function Wowam_Runsp_old(spell,Type)
		--spell=gsub(spell,"\n", "\\n")
		--spell = '/amRunMacro("' .. spell .. '")'
		if am_index[4] ~= 0 then return false end
		local length = string.len(spell)
		if length > 200 then
			DEFAULT_CHAT_FRAME:AddMessage("請縮短命令!",192,0,192,0)
			return
		end
		for i = 1, length do
			am_index[i + 10] = string.byte(spell, i);
		end
		am_index[length + 1 + 10] = 0
		if not Type then
			am_index[4] = 101
		else
			am_index[4] = 1000 + tonumber(Type)
		end
		stime = GetTime()
	end
	----------------------------------------------
	function amSetThreadSpeed(v)
		if am_index and am_index[303] then
			am_index[303] = v
		end
	end

	function amSetThreadSpeed(v)
		if am_index and am_index[303] then
			am_index[303] = v
		end
	end

	function amRunThreadSpeedTime()
		if am_index and am_index[304] then
			return am_index[304]
		end
	end

	local aml = aml
	local amact = amact
	local amac = amac
	local amr = amr
	local amSpellCooldown = amSpellCooldown
	local amGetUnitName = amGetUnitName
	local amIsPlayerCastSpell = amIsPlayerCastSpell
	local amisr = amisr
	local aminspell = aminspell
	local amrun = amrun
	local amdelay = amdelay
	local amCountAttack = amCountAttack
	local ambufflist = ambufflist
	local amecd = amecd
	local amtotem = amtotem
	local UnitIsDead = _G.UnitIsDead
	local UnitIsDeadOrGhost = _G.UnitIsDeadOrGhost
	local UnitIsConnected = _G.UnitIsConnected
	local UnitInRaid = _G.UnitInRaid
	local UnitInParty = _G.UnitInParty
	local UnitIsUnit = _G.UnitIsUnit
	local GetSpellInfo = C_Spell.GetSpellInfo
	local UnitName = _G.UnitName
	local UnitPlayerOrPetInParty = _G.UnitPlayerOrPetInParty
	local UnitPlayerOrPetInRaid = _G.UnitPlayerOrPetInRaid
	local GetRaidRosterInfo = _G.GetRaidRosterInfo
	local UnitClass = _G.UnitClass
	local UnitGroupRolesAssigned = _G.UnitGroupRolesAssigned
	local UnitHealth = _G.UnitHealth
	local UnitHealthMax = _G.UnitHealthMax
	local UnitMana = _G.UnitMana
	local UnitManaMax = _G.UnitManaMax
	local UnitDebuff = _G.UnitDebuff
	local format = _G.format
	local tonumber = _G.tonumber
	local GetTime = _G.GetTime
	local UnitCastingInfo = _G.UnitCastingInfo
	local UnitChannelInfo = _G.UnitChannelInfo
	local GetSpellCooldown = C_Spell.GetSpellCooldown
	local GetItemCooldown = _G.GetItemCooldown
	local GetItemInfo = _G.C_Item.GetItemInfo
	local IsEquippedItem = _G.IsEquippedItem
	local UnitPower = _G.UnitPower
	local GetShapeshiftFormInfo = _G.GetShapeshiftFormInfo
	local GetPetActionInfo = _G.GetPetActionInfo
	local IsCurrentSpell = C_Spell.IsCurrentSpell
	local UnitGUID = _G.UnitGUID
	local type = _G.type
	local GetSpellBookItemInfo = C_SpellBook.GetSpellBookItemInfo
	local GetSpellLink = _G.GetSpellLink
	local GetInventoryItemID = _G.GetInventoryItemID
	local GetBagName = _G.C_Container.GetBagName
	local GetContainerNumSlots = _G.GetContainerNumSlots
	local GetContainerItemID = _G.GetContainerItemID
	local GetUnitSpeed = _G.GetUnitSpeed
	local select = _G.select
	local UnitCanAssist = _G.UnitCanAssist
	local UnitCanAttack = _G.UnitCanAttack
	local IsSpellInRange = C_Spell.IsSpellInRange
	local IsUsableSpell = C_Spell.IsSpellUsable
	local IsUsableItem = C_Item.IsUsableItem
	local IsItemInRange = C_Item.IsItemInRange
	local GetMacroIndexByName = _G.GetMacroIndexByName
	local GetMacroInfo = _G.GetMacroInfo
	local ItemHasRange = C_Item.ItemHasRange
	local UnitLevel = _G.UnitLevel

	local addon = SuperTreatment["Menu"]["Main"]["addon"]
	local SD
	local ST = SuperTreatmentInf

	SuperTreatmentInf.UNIT_HEALTHS = {}
	SuperTreatmentInf.UNIT_HEALTHS.Health_Percentage_Min = {}
	SuperTreatmentInf.UNIT_HEALTHS.LackHealth_Max = {}

	local UNIT_HEALTHS = SuperTreatmentInf.UNIT_HEALTHS
	local UNIT_HEALTH_TBL = {}
	local UNIT_HEALTH_TBL_INDEX = {}

	ST.CastSpell = {}
	ST.CastSpell.Cast = {}
	ST.CastSpell.CastOver={}
	ST.CastOffSchem = {}
	ST.CastOffSchem.Cast = {}
	ST.CastOffSchem.End = {}

	local Colors = {}
		Colors.RED = "|cffff0000"
		Colors.GREEN = "|cff00ff00"
		Colors.BLUE = "|cff0000ff"
		Colors.MAGENTA = "|cffff00ff"
		Colors.YELLOW = "|cffffff00"
		Colors.CYAN = "|cff00ffff"
		Colors.WHITE = "|cffffffff"

	function IsRangeCheckAngle(v)
		local TBL = SuperTreatmentDBF
		for i, data in pairs(TBL["Spells"]["List"]) do
			for k, t in pairs(data["spell"]) do
				if t["TargetSubgroup"] == -2 and t["unit"] == v then
					return true
				end
				if t["Targets"] then
					for k1, t1 in pairs(t["Targets"]) do
						if t1["Conditions"] then
							for k2, t2 in pairs(t1["Conditions"]) do
								if t2["TargetSubgroup"] == -2 and t2["unit"] then
									if TBL["Unit"]["RaidList"][t2["unit"]] and TBL["Unit"]["RaidList"][t2["unit"]]["types"] == "RangeCheckAngle" then
										return true
									end
								end
							end
						end
					end
				end
			end
		end
		return false
	end

	local function ExcludedTargetGroup(name)
		local index = ST["Spells_Index"]
		local tbl = SD["Spells"]["List"][index]
		local Global_subgroup
		local GlobalExcludedGroup = true
		local GlobalExcludeTarget = true
		local GlobalExcludeMT = true
		if tbl["ExcludedGroupChecked"] then
			if SD["Unit"]["RaidList"][name] and SD["Unit"]["RaidList"][name]["subgroup"] then
				Global_subgroup = SD["Unit"]["RaidList"][name]["subgroup"]
				GlobalExcludedGroup = not tbl["ExcludedGroup"][Global_subgroup]
			end
		else
			if SD["Unit"]["RaidList"][name] and SD["Unit"]["RaidList"][name]["subgroup"] then
				Global_subgroup = SD["Unit"]["RaidList"][name]["subgroup"]
				GlobalExcludedGroup = not SD["Unit"]["ExcludedGroup"][Global_subgroup]
			end
		end
		if tbl["ExcludeTargetChecked"] then
			GlobalExcludeMTChecked = not tbl["ExcludeTarget"][name]
		else
			GlobalExcludeTarget = not SD["Unit"]["ExcludeTarget"][name]
		end
		if tbl["ExcludeMTChecked"] then
			local tblmt = stGetMtList()
			GlobalExcludeMT = not tblmt[name]
		end
		return GlobalExcludedGroup and GlobalExcludeTarget and GlobalExcludeMT
	end

	local function IsBuffPlayer(v,unitCaster)
		local IsPlayer = false
		if v["IsPlayer"]== "All" or not v["IsPlayer"] then
			IsPlayer = true
		elseif v["IsPlayer"]== "PLAYER" then
			IsPlayer = unitCaster == "player"
		elseif v["IsPlayer"]== "NoPlayer" then
			IsPlayer = unitCaster ~= "player"
		end
		return IsPlayer
	end

	local function IsBuffValue(v,isok,IsPlayer,name,count,duration, expirationTime, unitCaster)
		if name then
			IsPlayer = IsBuffPlayer(v,unitCaster)
		end
		if not name and v["IsCd"] == "NotPresence" then
			isok = true
		elseif v["IsCd"] == "No" then
			return true
		elseif name and (v["IsCd"] == "Presence" or not v["IsCd"]) then
			isok = IsPlayer
		elseif v["IsCd"] == "End" or v["IsCd"] == "Start" then
			local n
			local a, b = true, true
			if name then
				if IsPlayer then
					if v["IsCd"] == "End" then
						n = expirationTime - GetTime()
					elseif v["IsCd"] == "Start" then
						n = duration - (expirationTime - GetTime())
					end
					a, b = true, true
					if v["Cd"][">"]["Checked"] then
						a = n >= v["Cd"][">"]["Value"]
					end
					if v["Cd"]["<"]["Checked"] then
						b = n <= v["Cd"]["<"]["Value"]
					end
					isok = a and b
				end
			else
				n = -1
				a, b = true, true
				if v["Cd"][">"]["Checked"] then
					a = n >= v["Cd"][">"]["Value"]
				end
				if v["Cd"]["<"]["Checked"] then
					b = n <= v["Cd"]["<"]["Value"]
				end
				isok = a and b
			end
		end
		if v["IsCount"] then
			local n = count or -1
			local a, b = true, true
			if v["Count"][">"]["Checked"] then
				a = n >= v["Count"][">"]["Value"]
			end
			if v["Count"]["<"]["Checked"] then
				b = n <= v["Count"]["<"]["Value"]
			end
			if name and v["IsCd"] == "NotPresence" then
				isok = IsPlayer and a and b
			else
				isok = isok and a and b
			end
		end
		if name and v["IsCd"] == "NotPresence" then
			isok = not IsPlayer
		end
		return isok
	end

	local function GetBuffFilter(v)
		local filter
		if v["IsPlayer"]== "PLAYER" then
			filter = "PLAYER"
		end
		if v.IsCanceLable ~= "No" then
			if filter then
				filter = filter .. "|" ..v.IsCanceLable
			else
				filter = v.IsCanceLable
			end
		end
		if v.IsRaid ~= "No" then
			if filter then
				filter = filter .. "|" ..v.IsRaid
			else
				filter = v.IsRaid
			end
		end
		return filter
	end

	local function RGBToHex(r, g, b)
		r = r <= 255 and r >= 0 and r or 0
		g = g <= 255 and g >= 0 and g or 0
		b = b <= 255 and b >= 0 and b or 0
		return string.format("%02x%02x%02x", r, g, b)
	end

	local function RGBPercToHex(r, g, b)
		r = r <= 1 and r >= 0 and r or 0
		g = g <= 1 and g >= 0 and g or 0
		b = b <= 1 and b >= 0 and b or 0
		return  "|cff" .. string.format("%02x%02x%02x", r*255, g*255, b*255)
	end

	local sortedpairs = sortedpairs
	local DelayCastSpellMacro_StartTime = GetTime()

	local function DelayCastSpellMacro_OnUpdate(arg1)
		if GetTime() - DelayCastSpellMacro_StartTime > 0.01  then
			DelayCastSpellMacro_StartTime = GetTime()
			for i, data in pairs(ST.CastSpell.Cast) do
				if data.SpellCommand and data["DelayValue"] and data["DelayValue"] > 0 and GetTime() - data["time"] > data["DelayValue"] then
					local r = data.SpellCommand
					r(data.SpellText)
					ST.CastSpell.Cast[i] = nil
					return
				end
			end
		end
	end

	local DelayCastSpellMacroFrame= CreateFrame("Frame", nil ,UIParent)
	DelayCastSpellMacroFrame:SetScript("OnUpdate",DelayCastSpellMacro_OnUpdate)
	local Sort_Health_Percentage_Min = function(a, b)
		return b["Health%"] > a["Health%"]
	end
	local Sort_LackHealth_Max = function(a, b)
		return b["HealthLack"] < a["HealthLack"]
	end
	function stSort_Health()
		ST.UNIT_HEALTHS.Health_Percentage_Min = {}
		table.sort(UNIT_HEALTH_TBL_INDEX, Sort_Health_Percentage_Min)
		for i, v in pairs(UNIT_HEALTH_TBL_INDEX) do
			table.insert(UNIT_HEALTHS.Health_Percentage_Min,v)
		end
		ST.UNIT_HEALTHS.LackHealth_Max = {}
		table.sort(UNIT_HEALTH_TBL_INDEX, Sort_LackHealth_Max)
		for i, v in pairs(UNIT_HEALTH_TBL_INDEX) do
			table.insert(UNIT_HEALTHS.LackHealth_Max,v)
		end
		SuperTreatmentInf.UNIT_HEALTHS.UNIT_HEALTH_TBL = UNIT_HEALTH_TBL
		SuperTreatmentInf.UNIT_HEALTHS.UNIT_HEALTH_TBL_INDEX = UNIT_HEALTH_TBL_INDEX
	end
	
	local function UP_HEALTH(unit)
		if UNIT_HEALTH_TBL[unit] then
			local _,e = UnitClassBase(unit)
			UNIT_HEALTH_TBL[unit]["Health"] = UnitHealth(unit) or 0
			UNIT_HEALTH_TBL[unit]["HealthMax"] = UnitHealthMax(unit) or 0
			UNIT_HEALTH_TBL[unit]["Health%"] = aml(unit,"%")
			--UNIT_HEALTH_TBL[unit]["HealthLack%"]= aml(unit,"%",1)
			UNIT_HEALTH_TBL[unit]["HealthLack"] = aml(unit,nil,1)
			UNIT_HEALTH_TBL[unit]["Enable"] = not UnitIsDeadOrGhost(unit) and UnitIsConnected(unit) or false
			UNIT_HEALTH_TBL[unit]["Class"] = e or ""
			
			if UNIT_HEALTH_TBL[unit]["UnitId"] ~= unit then
				UNIT_HEALTH_TBL[unit]["UnitId"]= unit
			end
			return true
		end
	end

	local function EVENTS_UNIT_HEALTH_REST()
		UNIT_HEALTH_TBL = {}
		UNIT_HEALTH_TBL_INDEX = {}
		if UnitInRaid("player") then
			local k = GetNumGroupMembers()
			for i = 1, k do
				UNIT_HEALTH_TBL["raid" .. i] = {}
				if UP_HEALTH("raid" .. i) then
					UNIT_HEALTH_TBL_INDEX[i] = UNIT_HEALTH_TBL["raid" .. i]
				end
			end
		elseif GetNumSubgroupMembers() > 0 then
			local k = GetNumSubgroupMembers()
			for i = 1, k do
				UNIT_HEALTH_TBL["party" .. i] = {}
				if UP_HEALTH("party" .. i) then
					UNIT_HEALTH_TBL_INDEX[i] = UNIT_HEALTH_TBL["party" .. i]
				end
			end
			UNIT_HEALTH_TBL["player"] = {}
			if UP_HEALTH("player") then
				UNIT_HEALTH_TBL_INDEX[k + 1] = UNIT_HEALTH_TBL["player"]
			end
		end
		stSort_Health()
	end

	local function EVENTS_UNIT_HEALTH(self,event,arg1)
		if (event == "UNIT_HEALTH" or event == "UNIT_CONNECTION") and arg1 then
			UP_HEALTH(arg1)
			stSort_Health()
		elseif arg1 and (event ==  "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE") and not UnitInRaid("player") then
			UP_HEALTH("party" .. arg1 )
			stSort_Health()
		elseif event ==  "UPDATE_BATTLEFIELD_STATUS" or (event == "PARTY_LEADER_CHANGED" and not UnitInRaid("player")) then
			EVENTS_UNIT_HEALTH_REST()
		elseif (event == "RAID_ROSTER_UPDATE") then
			if GetNumGroupMembers() > 0 then
				EVENTS_UNIT_HEALTH_REST()
			end
		elseif (event == "PARTY_MEMBERS_CHANGED" and not UnitInRaid("player")) then
			if GetNumGroupMembers() == 0 then
				EVENTS_UNIT_HEALTH_REST()
			end
		end
	end

	local st_Unit_Health= CreateFrame("Frame", nil ,UIParent)

	--[[\r\nst_Unit_Health:SetScript("OnEvent", EVENTS_UNIT_HEALTH);
	st_Unit_Health:RegisterEvent("UNIT_HEALTH");--
	st_Unit_Health:RegisterEvent("PARTY_MEMBERS_CHANGED");
	st_Unit_Health:RegisterEvent("RAID_ROSTER_UPDATE");
	st_Unit_Health:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	--st_Unit_Health:RegisterEvent("UNIT_NAME_UPDATE");
	st_Unit_Health:RegisterEvent("UNIT_CONNECTION");
	st_Unit_Health:RegisterEvent("PARTY_MEMBER_ENABLE"); --ID
	st_Unit_Health:RegisterEvent("PARTY_MEMBER_DISABLE"); --ID
	st_Unit_Health:RegisterEvent("PARTY_LEADER_CHANGED");
	st_Unit_Health:RegisterEvent("PARTY_CONVERTED_TO_RAID");
	--]]

	function ST.MacroFinishing(macro,unit,isunit)
		--local Linebreaks = strchar(13) .. strchar(10)
		--local temp = gsub(macro,"\\n",Linebreaks)
		if not unit then
			return macro
		end
		local temp
		if isunit then
			temp = gsub(macro,"*unit",unit)
			temp = gsub(temp,'"' .. unit .. '"',unit)
		else
			temp = gsub(macro,"*unit",unit)
		end
		return temp
	end

	local function CastOffSchemProcessing(vv,spell,unit,event)
		if vv == "star" then
			for k, v in pairs(ST.CastOffSchem.Cast) do
				if v[spell] then
					stcommand("select:off " .. k)
					ST.CastOffSchem.Cast[k] = nil
					break
				end
			end
		elseif vv == "end" and event=="UNIT_SPELLCAST_SUCCEEDED" then
			for k, v in pairs(ST.CastOffSchem.End) do
				if v[spell] then
					stcommand("select:off " .. k)
					ST.CastOffSchem.End[k] = nil;
					break
				end
			end
		end
	end

	function ST.CastSpellfinishing(arg1,vv,spell,unit,event)
		CastOffSchemProcessing(vv,spell,unit,event)
		if vv == "star" then
			if ST.CastSpell.Cast[spell] and GetTime()- ST.CastSpell.Cast[spell]["time"] < 3 then
				local s = ST.CastSpell.Cast[spell]
				--print(s.ChatCommand,s.ScriptCommand,s.SpellCommand)
				local r
				if s.ChatCommand then
					r = s.ChatCommand
					r(s.ChatText)
				end
				if s.ScriptCommand then
					r = s.ScriptCommand
					r(s.ScriptText)
				end
				if s.SpellCommand and s["DelayValue"] and s["DelayValue"] == 0 then
					r = s.SpellCommand
					r(s.SpellText)
				end
				if s.SpellCommand and s["DelayValue"] and s["DelayValue"] > 0 then
					return
				end
				ST.CastSpell.Cast[spell] = nil
			end
		elseif vv == "end" and event == "UNIT_SPELLCAST_SUCCEEDED" then
			--print(111)
			if ST.CastSpell.CastOver[spell] and GetTime() - ST.CastSpell.CastOver[spell]["time"] < 20 then
				local s = ST.CastSpell.CastOver[spell]
				local r 
				if s.ChatCommand then
					r = s.ChatCommand
					r(s.ChatText)
				end
				if s.ScriptCommand then
					r = s.ScriptCommand
					r(s.ScriptText)
				end
				ST.CastSpell.CastOver[spell] = nil
			end
		end
	end

	function amtoboolean(v)
		if v then
			return true
		else
			return false
		end
	end

	function ST.SpellsRun() 
		if not SD then
			SD = SuperTreatmentDBF
		end
		if not ST.runindex then
			ST.runindex=1;
		else
			ST.runindex = ST.runindex +1;
		end
		if SuperTreatmentDBF["Config"]["aminspell"] and amruninspell() then
			return true
		end
		if not SuperTreatmentDBF then
			return false
		end
		local Spells = SuperTreatmentDBF["Spells"]["List"]
		for i, data in pairs(Spells) do
			if data["checked"] then
				local v,v1 = ST.SpellsRun_1(i)
				if v and not v1 then
					return true
				end
			end
		end
	end

	function ST.SpellsRun_1(index)
		ST["Spells_Index"] = index
		local Spells = SuperTreatmentDBF["Spells"]["List"][index]["spell"]
		local re = ST.cq[1]
		for i, data in pairs(Spells) do
			if data["checked"] then
				local unit,FireHasBeenSet,u,namespell,Rank,castTime
				local amrsdt = getglobal("RunScript")
				local group = data["TargetSubgroup"]
				local IsNoStopCastingSpells = true
				local iscd, iscdc = true,"IsSpell"
				local acspellname
				if data["Type"] == "spell" then
					--namespell,Rank, _, _,_,_,castTime = GetSpellInfo(data["spellId"])
					-- namespell,Rank, _, castTime,_,_ = GetSpellInfo(data["spellId"])

					local spell_info = GetSpellInfo(data["spellId"])
					namespell = spell_info.name
					Rank = nil
					castTime = spell_info.castTime

				elseif data["Type"] == "item" then
					namespell = GetItemInfo(data["spellId"])
				end
				unit = nil
				--acspellname = amact("player") > wowam_config.SpellAttackTime;
				acspellname = amac("player")
				--ST.acspellid = tonumber(format("%.f",RaidIndex or 0))>25;
				if acspellname then
					IsNoStopCastingSpells = not SuperTreatmentDBF["Spells"]["NoStopCastingSpells"][acspellname]
				end
				local allNoStopCastingChecked = SuperTreatmentDBF["Spells"]["List"][index]["NoStopCastingChecked"]
				if data["StopCastingChecked"] then
					if namespell ~= acspellname then
						IsNoStopCastingSpells = true
					end
				elseif allNoStopCastingChecked and acspellname then
					IsNoStopCastingSpells = false
				elseif SuperTreatmentDBF["Spells"]["NoStopCastingSpells"][acspellname] then
					IsNoStopCastingSpells = false
				end
				if data["Type"] == "spell" and amac("player") == namespell then
					IsNoStopCastingSpells = false
				end
				if data["NoAcChecked"] then
					IsNoStopCastingSpells = true
				end
				if data["RankChecked"] and Rank and Rank ~= "" then
					namespell = namespell .."(" .. Rank ..")"
				end
				--local disabled = data["Type"] and (data["Type"] =="macro" or data["Type"] =="script")
				--local strcdc = iscdc.."InRange"
				local disabled = data["Type"] and (data["Type"] ~="spell")
				local strcdc = iscdc.."InRange"
				if data["Type"] == "spell" and namespell then
					local Cooldown = amSpellCooldown(namespell);
					if castTime <= 0 then
						Cooldown = Cooldown - wowam_config.PromptSpellAttackTime
					else
						Cooldown = Cooldown - wowam_config.SpellAttackTime
					end
					iscd = Cooldown <= 0
				end
				if getglobal(re) and amrsdt then
					amrsdt("function "..strcdc.."() return aml()<0 end ")
				end
				if iscd and data["checked"] and (data["unit"] or disabled) and IsNoStopCastingSpells then
				--print(group)
					if group == -1 then
						unit = stUnitExplanation(data["unit"],data)--unit
						--unit = data["unit"];
						--print(">>",data["unit"],unit)
					elseif group == -2 then
						--unit = ST.AmminimumFast_SpellsRun(data);
						--SuperTreatmentDBF["Unit"]["RaidList"][data["unit"]]["ReturnsUnit"]=unit
						--SuperTreatmentDBF["Unit"]["RaidList"][data["unit"]]["runindex"]= ST.runindex
						local tbl = SuperTreatmentDBF["Unit"]["RaidList"][data["unit"]]
						if not tbl["runindex"] then
							tbl["runindex"] = 0
						end
						if not ST.Multitasking[data["unit"]] then
							ST.Multitasking[data["unit"]] = {}
						end
						if tbl["runindex"] ~= ST.runindex then
							local ism = ST["Multitasking"][data["unit"]];
							if ism["MultitaskingStart"] then
								unit =ism["ReturnsUnit"]
								--print("a",i,unit)
							else
								unit = ST.AmminimumFast_SpellsRun(data)
								--print("b",i,unit)
							end
							tbl["ReturnsUnit"] = unit
							tbl["runindex"] = ST.runindex
						else
						unit = tbl["ReturnsUnit"]
						--print("c",i,unit)
						end
						--print("xxx",data["unit"],ism["MultitaskingStart"],unit)
					elseif group >= 1 then
						unit = data["unit"]
					elseif group == 0 then
						unit = data["unit"]
					end
					--print(data["spellId"],amIsNoSpellTarget(data["spellId"]))
					--if data["spellId"] and amIsNoSpellTarget and amIsNoSpellTarget(data["spellId"]) then
					--	unit = "nogoal"
					--end
					if unit and unit ~= "nogoal" then
						local TargetLayer = data["TargetLayer"] or 0
						local TargetLayerText = ""
						for n = 1, TargetLayer do
							TargetLayerText = TargetLayerText .. "-target"
						end
						unit = unit .. TargetLayerText
					end
					local IsEx = true
					local name
					if unit then
						name = amGetUnitName(unit,true)
						if name then
							local tbl = SuperTreatmentDBF["Spells"]["List"][index]
							local Global_subgroup
							local GlobalExcludedGroup = true
							local GlobalExcludeTarget = true
							local GlobalExcludeMT = true
							if tbl["ExcludedGroupChecked"] then
								if SuperTreatmentDBF["Unit"]["RaidList"][name] and SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"] then
								Global_subgroup = SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"]
								GlobalExcludedGroup = not tbl["ExcludedGroup"][Global_subgroup]
							end
						else
							if SuperTreatmentDBF["Unit"]["RaidList"][name] and SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"] then
								Global_subgroup = SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"]
								GlobalExcludedGroup = not SuperTreatmentDBF["Unit"]["ExcludedGroup"][Global_subgroup]
							end
						end
						if tbl["ExcludeTargetChecked"] then
							GlobalExcludeTarget = not tbl["ExcludeTarget"][name]
						else
							GlobalExcludeTarget = not SuperTreatmentDBF["Unit"]["ExcludeTarget"][name]
						end
						if tbl["ExcludeMTChecked"] then
							local tblmt = stGetMtList()
							GlobalExcludeMT = not tblmt[name]
						end
						IsEx = GlobalExcludedGroup and GlobalExcludeTarget and GlobalExcludeMT
					end
				end
				if not data["StopCastingChecked"] then
					local tbl = SuperTreatmentDBF["Spells"]["List"][index]
					if tbl["WaitSpellCastComplete"] then
						local t = amIsPlayerCastSpell()
						IsEx = IsEx and not t
					end
				end
				if IsEx and unit and unitfr and (name or unit == "nogoal") then
					local temp_v = ST.Unit_SpellsRun(data,unit)
					if data["subgroup"] ~= -3 and data["subgroup"] ~= -4 then
						if unit and temp_v then
							local tv
							if data["PlayerChaosChecked"] and UnitGUID(unit) == UnitGUID("player") then
								tv = not UnitIsCorpse(unit) and not UnitIsDeadOrGhost(unit)
							else
								local PowerCostChecked = amtoboolean(data["PowerCostChecked"])
								local tempPowerCostChecked
								if PowerCostChecked then
									tempPowerCostChecked = 1
								end
									tv = amisr(namespell,unit,false,tempPowerCostChecked,false,data["StopCastingChecked"] and true,nil,data["NoAcChecked"])
									if not(unit =="nogoal" or unit=="none") then
										tv = tv and UnitIsConnected(unit) and not UnitIsCorpse(unit) and not UnitIsDeadOrGhost(unit)
									end
								end
								if tv then
									if data["AOEChecked"] then
										if data["CastingSpellStartOrEnd"] and data["CastingSpellStartOrEnd"]["checked"] then
											local tbl = data["CastingSpellStartOrEnd"]["Start"]
											local checked = tbl["checked"]
											--local isRadio = tbl["isRadio"]
											local script
											local text = tbl["Chat"]["text"] or ""
											local channel = tbl["Chat"]["isRadio"]
											local Chat = tbl["Chat"]["channel"]
											text = gsub(text, "*unit", name or "")
											text = gsub(text, "*spell", namespell)
											--print(text)
											--RunScript
											if checked then
												local namespell = amGetSpellName(data["spellId"])
												if tbl["ChatChecked"] and text ~= "" then
												if channel == "channel" then
													script = "SendChatMessage('" .. text .."','" .. channel .. "', nil, GetChannelName(" .. Chat .."))"
												elseif channel == "print" then
													script = "print('" .. text .."')"
												else
													script = "SendChatMessage('" .. text .."','" .. channel .. "')"
												end
												--RunScript(script)
												if not ST.CastSpell.Cast[namespell] then
													ST.CastSpell.Cast[namespell] = {}
												end
												ST.CastSpell.Cast[namespell]["time"] = GetTime()
												ST.CastSpell.Cast[namespell]["ChatText"] = script
												ST.CastSpell.Cast[namespell]["target"] = unit
												ST.CastSpell.Cast[namespell]["ChatCommand"] = RunScript
											end
											if tbl["ScriptChecked"] and (tbl["script"] or "") ~= "" then
												local text = tbl["script"] or ""
												if not ST.CastSpell.Cast[namespell] then
													ST.CastSpell.Cast[namespell] = {}
												end
												ST.CastSpell.Cast[namespell]["time"] = GetTime()
												ST.CastSpell.Cast[namespell]["ScriptText"] = text
												ST.CastSpell.Cast[namespell]["target"] = unit
												local Macro = strsub(text, 1, 1) == "/"
												if Macro then
													ST.CastSpell.Cast[namespell]["ScriptCommand"] = amrun
												else
													ST.CastSpell.Cast[namespell]["ScriptCommand"] = RunScript
												end
											end
											if tbl["SpellChecked"] then
												local Spells = tbl["spell"]
												local text = ""
												for i, data in pairs(Spells) do
													local spellId = data["spellId"]
													local spellType = data["Type"]
													local name
													if spellType == "item" then
														name = GetItemInfo(spellId)
														name = "/use " .. name
													elseif spellType == "spell" then
														name = GetSpellInfo(spellId)
														name = "/cast " .. name
													elseif spellType == "macro" then
														name = data["Macro"]
													end
													if text == "" then
														text = name
													else
														text = text .. "\n" .. name
													end
												end
												if text ~= "" then
													if tbl["DelayValue"] == -1 then
														DelayCastSpellMacro = text
														--print(100)
													else
														if not ST.CastSpell.Cast[namespell] then
															ST.CastSpell.Cast[namespell] = {}
														end
														ST.CastSpell.Cast[namespell]["time"] = GetTime()
														ST.CastSpell.Cast[namespell]["SpellText"] = text
														ST.CastSpell.Cast[namespell]["target"] = unit
														ST.CastSpell.Cast[namespell]["DelayValue"] = tbl["DelayValue"] or 0
														ST.CastSpell.Cast[namespell]["SpellCommand"] = amrun
														--print(200)
													end
												end
											end
										end
										local tbl = data["CastingSpellStartOrEnd"]["End"]
										local checked = tbl["checked"]
										--local isRadio = tbl["isRadio"]
										local script
										local channel = tbl["Chat"]["isRadio"]
										local Chat = tbl["Chat"]["channel"]
										if checked then
											local namespell = amGetSpellName(data["spellId"])
											local text = tbl["Chat"]["text"] or ""
											if tbl["ChatChecked"] and text ~= "" then
												text = gsub(text,"*unit", "[".. (name or "") .. "]")
												text = gsub(text,"*spell",data["itemLink"])
												if channel == "channel" then
													script = "SendChatMessage('" .. text .."','" .. channel .. "',nil,GetChannelName(" .. Chat .."))"
												elseif channel == "print" then
													script = "print('" .. text .."')"
												else
													script = "SendChatMessage('" .. text .."','" .. channel .. "')"
												end
												if not ST.CastSpell.CastOver[namespell] then
													ST.CastSpell.CastOver[namespell] = {}
												end
												ST.CastSpell.CastOver[namespell]["time"] = GetTime()
												ST.CastSpell.CastOver[namespell]["ChatText"] = script
												ST.CastSpell.CastOver[namespell]["target"] = unit
												ST.CastSpell.CastOver[namespell]["ChatCommand"] = RunScript
											end
											if tbl["ScriptChecked"] and (tbl["script"] or "") ~= ""  then
												local text = tbl["script"] or ""
												if not ST.CastSpell.CastOver[namespell] then
													ST.CastSpell.CastOver[namespell] = {}
												end
												ST.CastSpell.CastOver[namespell]["time"] = GetTime()
												ST.CastSpell.CastOver[namespell]["ScriptText"] = text
												ST.CastSpell.CastOver[namespell]["target"] = unit
												local Macro = strsub(text,1,1) == "/" 
												if Macro then
													ST.CastSpell.CastOver[namespell]["ScriptCommand"] = amrun
												else
													ST.CastSpell.CastOver[namespell]["ScriptCommand"] = RunScript
												end
											end
										end
									end
									aminspell(namespell,"aoe",amtoboolean(data["StopCastingChecked"]),2,1)
									local CastOffSchem = SuperTreatmentDBF["Spells"]["List"][index]
									local CastOffSchemName = CastOffSchem["name"]
									if CastOffSchem["CastOffSchem"] then
										if not ST.CastOffSchem.Cast[CastOffSchemName] then
											ST.CastOffSchem.Cast[CastOffSchemName] = {}
											ST.CastOffSchem.Cast[CastOffSchemName][namespell] = {}
										end
										ST.CastOffSchem.Cast[CastOffSchemName][namespell]["time"] = GetTime()
									end
								else
									local strtarget,t_unit
									if data["Type"] == "item" or unit =="nogoal" then
										strtarget = ""
										t_unit = ""
									else
										strtarget = "[target=" .. unit .. "]"
										t_unit = unit
									end
									local gospell
									local DelayCastSpellMacro
									local CastingSpell = data["CastingSpell"]
									if CastingSpell and CastingSpell["Checked"] then
										local temp = addon:TblToMacro(CastingSpell["spell"],strtarget)
										if temp ~= "" then
											gospell = temp
										end
									else
										if data["StopCastingChecked"] and acspellname then
											--gospell = "/stopcasting[nochanneling:"..namespell .."]\n/cast " .. strtarget .. namespell
											gospell = "/stopcasting\n/cast " .. strtarget .. namespell
										else
											gospell = "/cast " .. strtarget .. namespell
										end
									end
									if data["CastingSpellStartOrEnd"] and data["CastingSpellStartOrEnd"]["checked"] then
										local tbl = data["CastingSpellStartOrEnd"]["Start"]
										local checked = tbl["checked"]
										--local isRadio = tbl["isRadio"]
										local script
										local text = tbl["Chat"]["text"] or ""
										local channel = tbl["Chat"]["isRadio"]
										local Chat = tbl["Chat"]["channel"]
										text = gsub(text,"*unit",name or "")
										text = gsub(text,"*spell",namespell)
										--print(text)
										--RunScript
										if checked then
											local namespell = amGetSpellName(data["spellId"])
											if tbl["ChatChecked"] and text ~= "" then
												if channel == "channel" then
													script = "SendChatMessage('" .. text .."','" .. channel .. "',nil,GetChannelName(" .. Chat .."))"
												elseif channel == "print" then
													script = "print('" .. text .."')"
												else
													script = "SendChatMessage('" .. text .."','" .. channel .. "')"
												end
												--RunScript(script)
												if not ST.CastSpell.Cast[namespell] then
													ST.CastSpell.Cast[namespell] = {}
												end
												ST.CastSpell.Cast[namespell]["time"] = GetTime()
												ST.CastSpell.Cast[namespell]["ChatText"] = script
												ST.CastSpell.Cast[namespell]["target"] = unit
												ST.CastSpell.Cast[namespell]["ChatCommand"] = RunScript
											end
											if tbl["ScriptChecked"] and (tbl["script"] or "") ~= "" then
												local text = tbl["script"] or ""
												if not ST.CastSpell.Cast[namespell] then
													ST.CastSpell.Cast[namespell] = {}
												end
												ST.CastSpell.Cast[namespell]["time"] = GetTime()
												ST.CastSpell.Cast[namespell]["ScriptText"] = text
												ST.CastSpell.Cast[namespell]["target"] = unit
												local Macro = strsub(text,1,1) == "/"
												if Macro then
													ST.CastSpell.Cast[namespell]["ScriptCommand"] = amrun
												else
													ST.CastSpell.Cast[namespell]["ScriptCommand"] = RunScript
												end
											end
											if tbl["SpellChecked"] then
												local Spells =tbl["spell"]
												local text = ""
												for i, data in pairs(Spells) do
													local spellId = data["spellId"]
													local spellType = data["Type"]
													local name
													if spellType == "item" then
														name = GetItemInfo(spellId)
														name = "/use " .. name
													elseif spellType == "spell" then
														name = GetSpellInfo(spellId)
														name = "/cast " .. name
													elseif spellType == "macro" then
														name = data["Macro"]
													end
													if text == "" then
														text = name
													else
														text = text .. "\n" .. name
													end
												end
											if text ~= "" then
												if tbl["DelayValue"]== -1 then
													DelayCastSpellMacro = text
													--print(100)
												else
													if not ST.CastSpell.Cast[namespell] then
														ST.CastSpell.Cast[namespell] = {}
													end
													ST.CastSpell.Cast[namespell]["time"] = GetTime()
													ST.CastSpell.Cast[namespell]["SpellText"] = text
													ST.CastSpell.Cast[namespell]["target"] = unit
													ST.CastSpell.Cast[namespell]["DelayValue"] = tbl["DelayValue"] or 0
													ST.CastSpell.Cast[namespell]["SpellCommand"] = amrun
													--print(200)
												end
											end
										end
									end
									local tbl = data["CastingSpellStartOrEnd"]["End"]
									local checked = tbl["checked"]
									--local isRadio = tbl["isRadio"]
									local script
									local channel = tbl["Chat"]["isRadio"]
									local Chat = tbl["Chat"]["channel"]
									if checked then
										local namespell = amGetSpellName(data["spellId"])
										local text = tbl["Chat"]["text"] or ""
										if tbl["ChatChecked"] and text ~= "" then
											--local playerClass, englishClass = UnitClass(unit)
											--local color = RAID_CLASS_COLORS[englishClass]
											--local NameRGBToHex = RGBPercToHex(color.r,color.g,color.b)
											--text = gsub(text,"*unit", "["..NameRGBToHex .. (name or "") .. "|r]")
											text = gsub(text,"*unit", "[".. (name or "") .. "]")
											text = gsub(text,"*spell",data["itemLink"])
											if channel == "channel" then
												script = "SendChatMessage('" .. text .."','" .. channel .. "',nil,GetChannelName(" .. Chat .."))"
											elseif channel == "print" then
												script = "print('" .. text .."')"
											else
												script = "SendChatMessage('" .. text .."','" .. channel .. "')"
											end
											--SendChatMessage(">>" .. text,channel,nil,GetChannelName(Chat));
											--RunScript(script)
											--print(script);
											if not ST.CastSpell.CastOver[namespell] then
												ST.CastSpell.CastOver[namespell] = {}
											end
											ST.CastSpell.CastOver[namespell]["time"] = GetTime()
											ST.CastSpell.CastOver[namespell]["ChatText"] = script
											ST.CastSpell.CastOver[namespell]["target"] = unit
											ST.CastSpell.CastOver[namespell]["ChatCommand"] = RunScript
										end
										if tbl["ScriptChecked"] and (tbl["script"] or "") ~= ""  then
											local text = tbl["script"] or ""
											if not ST.CastSpell.CastOver[namespell] then
												ST.CastSpell.CastOver[namespell] = {}
											end
											ST.CastSpell.CastOver[namespell]["time"] = GetTime()
											ST.CastSpell.CastOver[namespell]["ScriptText"] = text
											ST.CastSpell.CastOver[namespell]["target"] = unit
											local Macro = strsub(text,1,1) == "/"
											if Macro then
												ST.CastSpell.CastOver[namespell]["ScriptCommand"] = amrun
											else
												ST.CastSpell.CastOver[namespell]["ScriptCommand"] = RunScript
											end
										end
									end
								end
								local CastOffSchem = SuperTreatmentDBF["Spells"]["List"][index]
								local CastOffSchemName = CastOffSchem["name"]
								if CastOffSchem["CastOffSchem"] then
									if not ST.CastOffSchem.Cast[CastOffSchemName] then
										ST.CastOffSchem.Cast[CastOffSchemName] = {}
									end
									if not ST.CastOffSchem.Cast[CastOffSchemName][namespell] then
										ST.CastOffSchem.Cast[CastOffSchemName][namespell] = {}
									end
									ST.CastOffSchem.Cast[CastOffSchemName][namespell]["time"] = GetTime()
								end
								if CastOffSchem["CastOffSchemEnd"] then
									if not ST.CastOffSchem.End[CastOffSchemName] then
										ST.CastOffSchem.End[CastOffSchemName] = {}
										ST.CastOffSchem.End[CastOffSchemName][namespell] = {}
									end
									ST.CastOffSchem.End[CastOffSchemName][namespell]["time"] = GetTime()
								end
								if DelayCastSpellMacro and not data["CastingSpell"]["Checked"] then
									gospell = gospell .. "\n" .. DelayCastSpellMacro
								end
								if SuperTreatmentDBF["Config"]["aminspellGo_checked"] then
									aminspell(gospell,"Macro")
								else
									--gospell = gospell .. ";#" .. namespell .. "#"..t_unit;
									amrun(gospell,t_unit,false,false,namespell)
								end
							end
							if data["DelayChecked"] then
								--print(amGetSpellName(data["spellId"]),data["DelayValue"],unit)
								amdelay(amGetSpellName(data["spellId"]),data["DelayValue"],unit)
							end
							return true
						end
					end
				elseif data["subgroup"] == -3 and temp_v then
					local checked = data["PropertiesSetChecked"]
					local gospell, MacroTbl
					if data["id"] then
						for k, t in pairs(SuperTreatmentDBF["Macro"]) do
							if t["id"] == data["id"] then
								gospell=t["Macro"]
								MacroTbl = t
								break
							end
						end
					else
						gospell = data["Macro"]
					end
					if checked == 1 then
						if data["Type"]=="script" then
							--gospell=gsub(gospell,"*unit",unit)
							gospell = "/Script " .. gospell
						elseif data["Type"]=="macro" then
							--gospell=gsub(gospell,"*unit",unit);
						end
						--gospell=gsub(gospell,"\\n",strchar(13))
						gospell = ST.MacroFinishing(gospell,unit)
						if SuperTreatmentDBF["Config"]["aminspellGo_checked"] then
							aminspell(gospell,"Macro")
						else
							amrun(gospell)
						end
						--ST.showruninf(data["itemLink"],unit)
						if not data["PropertiesSet_Continue_Checked"] then
							return true
						end
					elseif checked == 2 then
						--[[
						gospell = ST.MacroFinishing(gospell,unit);
						RunScript(gospell)--]]
						local v
						if MacroTbl and MacroTbl["time"] then
							if MacroTbl["func"] and MacroTbl["time"] == MacroTbl["functime"] and checked == MacroTbl["runType"] then
								v = MacroTbl["func"]
							else
								gospell = ST.MacroFinishing(gospell,"SuperTreatment_Run_unit",true)
								gospell = "return function(SuperTreatment_Run_unit) \n" .. gospell .. "\n end"
								local func = assert(loadstring(gospell))
								local vv = func()
								if vv then
									if MacroTbl and MacroTbl["time"] then
										local Stime = GetTime()
										MacroTbl["func"] = vv
										MacroTbl["time"] = Stime
										MacroTbl["functime"] = Stime
										MacroTbl["runType"] = checked
									end
									v = vv
								end
							end
						else
							gospell = ST.MacroFinishing(gospell,unit)
							local func = assert(loadstring(gospell))
							v = func
						end
						local vr = v(unit)
						if not data["PropertiesSet_Continue_Checked"] then
							return true
						end
					elseif checked == 3 then
						local v
						if MacroTbl and MacroTbl["time"] then
							if MacroTbl["func"] and MacroTbl["time"] == MacroTbl["functime"] and checked == MacroTbl["runType"] then
								v = MacroTbl["func"]
							else
								gospell = ST.MacroFinishing(gospell,"SuperTreatment_Run_unit",true)
								gospell = "return function(SuperTreatment_Run_unit) \n" .. gospell .. "\n end"
								local func = assert(loadstring(gospell))
								local vv = func()
								if vv then
									if MacroTbl and MacroTbl["time"] then
										local Stime = GetTime()
										MacroTbl["func"] = vv
										MacroTbl["time"] = Stime
										MacroTbl["functime"] = Stime
										MacroTbl["runType"] = checked
									end
									v = vv
								end
							end
						else
							gospell = ST.MacroFinishing(gospell,unit)
							local func = assert(loadstring(gospell))
							v = func
						end
						local vr = v(unit);
						if not data["PropertiesSet_Continue_Checked"] then
							if vr then
								return vr
							end
						else
							if vr then
							end
						end
					elseif checked == 4 then
						local v
						if MacroTbl and MacroTbl["time"] then
							if MacroTbl["func"] and MacroTbl["time"] == MacroTbl["functime"] and checked == MacroTbl["runType"] then
								v = MacroTbl["func"]
							else
								gospell = gospell .. "\n if true then return false; end;"
								gospell = ST.MacroFinishing(gospell,"SuperTreatment_Run_unit",true)
								gospell = "return function(SuperTreatment_Run_unit) \n" .. gospell .. "\n end"
								local func = assert(loadstring(gospell))
								local vv = func()
								if vv then
									if not isunit and MacroTbl and MacroTbl["time"] then
										local Stime = GetTime()
										MacroTbl["func"] = vv
										MacroTbl["time"] = Stime
										MacroTbl["functime"] = Stime
										MacroTbl["runType"] = checked
									end
									v = vv
								end
							end
						else
							gospell = ST.MacroFinishing(gospell,unit)
							gospell = gospell .. "\n if true then return false; end;"
							local func = assert(loadstring(gospell))
							v = func
						end
						local vr = v(unit)
						if not data["PropertiesSet_Continue_Checked"] then
							if vr then
								return vr
							end
						else
							if vr then
							end
						end
						--[[
							gospell = ST.MacroFinishing(gospell,unit)
							gospell = gospell .. "\n if true then return false; end;"
							local func = assert(loadstring(gospell))
							local v = func()
							if v == nil then
								v = true
							end
							--print(v,false)
							if not data["PropertiesSet_Continue_Checked"] then
								if v then
									return v
								end
							else
								if v then
								end
							end--]]
						end
					elseif data["subgroup"] == -4 and temp_v then
						local Run_ApiDbf_v
						local Run_ApiDbf = data["ApiDbf"]
						local Run_ApiDbf_tbl=Run_ApiDbf[1]
						Run_ApiDbf_v = ST.Unit_SpellsRun_Run_ApiDbf(Run_ApiDbf_tbl,unit)
						if Run_ApiDbf_v then
							--ST.showruninf(data["itemLink"],unit)
							local apiinf = SuperTreatment["Api"][Run_ApiDbf_tbl["id"]]
							--print(apiinf["end"])
							return true, apiinf["end"]
						end
					end
				end
			end
		end
	end
end

function ST.AmminimumFast_SpellsRun(data,u)
    local v = data["unit"]
    if u then
        v = u
    end
    local tbl = SuperTreatmentDBF["Unit"]["RaidList"][v]["AmminimumFast"]
    local MultitaskingChecked=tbl["MultitaskingChecked"]
    if not ST.Multitasking[v] then
        ST.Multitasking[v]={}
    end
    local tb = ST.Multitasking[v]
    if MultitaskingChecked then
        if not ST.Multitasking[v]["MultitaskingStart"] then
            ST.Multitasking[v]["MultitaskingStart"]=true
            ST["Multitasking"]["MultitaskingStart"]=true
            local Count=ST["Multitasking"]["Count"]
            if not Count then
                Count=1
            end
            tb.thread = coroutine.create(amGetHandle(ST.AmminimumFast_SpellsRun_1))
            tb.frame = CreateFrame("Frame")
            if not tbl.MultitaskingTime or tbl.MultitaskingTime<50 then
                tbl.MultitaskingTime=50;
            end
            tb.counter = 0 
            local throttle = tbl.MultitaskingTime/1000/Count
            if throttle<0.001  then
                throttle=0.001;
            end
            if not tbl.func then
                tb.func = function(self, elapsed) 
                    tb.counter = tb.counter + elapsed 
                    if tb.counter >= throttle then
                        tb.counter = tonumber(format("%.4f",tb.counter - throttle))
                        if coroutine.status(tb.thread) ~= "dead" then
                            coroutine.resume(tb.thread,data,u,v) 
                        end
                    end
                end
                tb.frame:SetScript("OnUpdate", tb.func)
            end
        end
    else
        return ST.AmminimumFast_SpellsRun_2(data,u)
    end
end
	
	function ST.AmminimumFast_SpellsRun_1(data,u,v)
		---print(">>99<<",data,u,v)
		local IsExit = true
		local tbl = SuperTreatmentDBF["Unit"]["RaidList"][v]
		local i = 1
		while IsExit
		do
			local r1
			ST["Multitasking"][v]["ReturnsUnit"],r1 = ST.AmminimumFast_SpellsRun_2(data,u)
			if r1 then coroutine.yield() end
			if not ST["Multitasking"]["MultitaskingStart"] then
				ST.Multitasking[v]["MultitaskingStart"] = nil
				tbl["AmminimumFast"]["func"] = nil
				IsExit=false
			end
			-- print(i,ST["Multitasking"][v]["ReturnsUnit"]);
			i = i + 1
		end
	end
	
	function ST.AmminimumFast_SpellsRun_2(data,u)
		local v = data["unit"]
		if u then
			v = u
		end
		local TBL = SuperTreatmentDBF["Unit"]["RaidList"][v]
		local unit
		local Code,group,buff,spell,Class,SpellDistanceChecked,DistanceChecked,Distancevalue,AmminimumFastCode,Nobuff,NoDistanceChecked
		local Maximum,MaximumCode,MinimumCode
		local Minimumchecked = TBL["AmminimumFast"]["Minimumchecked"]
		local Maximumchecked = TBL["AmminimumFast"]["Maximumchecked"]
		local FireHasBeen
		local MultitaskingChecked = ST.Multitasking[v]["MultitaskingStart"] and TBL["AmminimumFast"]["MultitaskingChecked"]
		local namespell,Rank,PowerCostChecked
		if data["spellId"] then
			namespell,Rank = GetSpellInfo(data["spellId"])
			if data["RankChecked"] and Rank and Rank ~= "" then
				namespell = amGetSpellName(data["spellId"])
			end
			PowerCostChecked = amtoboolean(data["PowerCostChecked"])
		end
		if TBL.types =="unit" or TBL["unitchecked"] then
			unit = TBL["unit"]
			return unit
		elseif TBL.types =="RangeCheckAngle" and TBL["PlayerRangeCheckAngle"] then
			if not st_Unit_Health:GetScript("OnEvent") then
				st_Unit_Health:SetScript("OnEvent", EVENTS_UNIT_HEALTH)
				st_Unit_Health:RegisterEvent("UNIT_HEALTH")
				st_Unit_Health:RegisterEvent("PARTY_MEMBERS_CHANGED")
				st_Unit_Health:RegisterEvent("RAID_ROSTER_UPDATE")
				st_Unit_Health:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
				st_Unit_Health:RegisterEvent("UNIT_CONNECTION")
				st_Unit_Health:RegisterEvent("PARTY_MEMBER_ENABLE")
				st_Unit_Health:RegisterEvent("PARTY_MEMBER_DISABLE")
				st_Unit_Health:RegisterEvent("PARTY_LEADER_CHANGED")
				st_Unit_Health:RegisterEvent("PARTY_CONVERTED_TO_RAID")
				EVENTS_UNIT_HEALTH_REST()
			end
			if TBL["PlayerRangeCheckAngle"]["Min_Max"]["Type"] == "Minimum_Blood_Percentage" then
				for i, v in pairs(ST.UNIT_HEALTHS.Health_Percentage_Min) do
					if v.Enable then
						unit = ST.mminimumFast_SpellsRun_RangeCheckAngle(TBL,v.UnitId)
						if unit then
							return unit
						end
					end
				end
			elseif TBL["PlayerRangeCheckAngle"]["Min_Max"]["Type"] == "Maximum_LackBlood" then
				for i, v in pairs(ST.UNIT_HEALTHS.LackHealth_Max) do
					if v.Enable then
						unit = ST.mminimumFast_SpellsRun_RangeCheckAngle(TBL,v.UnitId)
						if unit then
							return unit
						end
					end
				end
			end
		elseif TBL.types == "function" or TBL["functionchecked"] then
			local Script = TBL["function"]
			local func = assert(loadstring(Script))
			unit = func()
			return unit
		elseif TBL.types == "AmminimumFast" or TBL["AmminimumFastchecked"] then
			group = TBL["AmminimumFast"]["group"]
			--if group == "partyraid" and GetNumGroupMembers() > 0 then
			if group == "partyraid" and UnitInRaid("player") then
				group = "raid"
			elseif group == "partyraid" and GetNumSubgroupMembers() > 0 then
				group = "party"
			elseif group == "partyraidpet" and GetNumGroupMembers() > 0 then
				group = "raidpet"
			elseif group == "partyraid" and GetNumSubgroupMembers() > 0 then
				group = "partypet"
			elseif group == "partyraid" and GetNumSubgroupMembers() == 0 and GetNumGroupMembers() == 0 then
				group = "party"
			elseif group == "partyraidpet" and GetNumSubgroupMembers() == 0 and GetNumGroupMembers() == 0 then
				group = "party"
			end
			SpellDistanceChecked = TBL["AmminimumFast"]["SpellDistanceChecked"]
			DistanceChecked = TBL["AmminimumFast"]["DistanceChecked"]
			Distancevalue = TBL["AmminimumFast"]["Distancevalue"]
			NoDistanceChecked = TBL["AmminimumFast"]["NoDistanceChecked"]
			if Minimumchecked then
				MinimumCode = TBL["AmminimumFast"]["Minimum"]["CodeFunction"]
				if not MinimumCode then
					local temp = TBL["AmminimumFast"]["Minimum"]["Code"]
					if temp then
						RunScript("function SuperTreatment_AmminimumFast_temp(unit) return " .. temp .. "; end")
						MinimumCode = SuperTreatment_AmminimumFast_temp
						SuperTreatment_AmminimumFast_temp = nil
					end
				end
			end
			if Maximumchecked then
				MaximumCode = TBL["AmminimumFast"]["Maximum"]["CodeFunction"]
				if not MaximumCode then
					local temp = TBL["AmminimumFast"]["Maximum"]["Code"]
					if temp then
						RunScript("function SuperTreatment_AmminimumFast_temp(unit) return " .. temp .. "; end")
						MaximumCode = SuperTreatment_AmminimumFast_temp
						SuperTreatment_AmminimumFast_temp = nil
					end
				end
			end
			if TBL["AmminimumFast"]["CodeChecked"] then
				AmminimumFastCode = TBL["AmminimumFast"]["CodeFunction"]
				if not AmminimumFastCode then
					local temp = TBL["AmminimumFast"]["Code"]
					if temp then
						RunScript("function SuperTreatment_AmminimumFast_temp(unit) return " .. temp .. "; end")
						AmminimumFastCode = SuperTreatment_AmminimumFast_temp
						SuperTreatment_AmminimumFast_temp = nil
					end
				end
			end
			if TBL["AmminimumFast"]["buffchecked"] then
				----buff = TBL["AmminimumFast"]["buff"]
				buff = TBL["AmminimumFast"]["NewBuff"]["buffs"]
			end
			if TBL["AmminimumFast"]["Nobuffchecked"] then
				--Nobuff = TBL["AmminimumFast"]["Nobuff"]
				Nobuff = TBL["AmminimumFast"]["NewNobuff"]["buffs"]
			end
			if TBL["AmminimumFast"]["spellchecked"] then
				--spell = TBL["AmminimumFast"]["spell"]
				spell = TBL["AmminimumFast"]["NewSpell"]
			end
			if TBL["AmminimumFast"]["Classchecked"] then
				Class = TBL["AmminimumFast"]["Class"]
			end
			if not TBL["AmminimumFast"]["ApiDbf"] then
				TBL["AmminimumFast"]["ApiDbf"] = {}
			end
			local ApiDbf = ST.Unit_SpellsRun_2_ApiDbf_Count(TBL["AmminimumFast"]) > 0
			--if not(MinimumCode or MaximumCode or buff or spell or Class or Nobuff or TBL["AmminimumFast"]["Countchecked"] or ApiDbf) then
				--return false
			--end
			--local temp = TBL["AmminimumFast"]["group"]\r\n\t\t\r\n\t\tlocal temp = group
			local Members = 0
			local disabled =  temp == "maintank" or temp == "party" or temp == "partypet" or temp == "raid" or temp == "raidpet" or temp == "arena"
			if temp == "FireHasBeenSet" then
				local FireHasBeenSetValue =TBL["AmminimumFast"]["FireHasBeenSetValue"]
				if not FireHasBeenSetValue then
					return false
				end
				local FireHasBeenSet, u = amCountAttack()
				if FireHasBeenSet >= FireHasBeenSetValue then
					FireHasBeen = u
				else
					return false
				end
			elseif temp == "SelectedTarget" then
				if TBL["AmminimumFast"]["Group_SelectedTarget"]["name"] then
					FireHasBeen = TBL["AmminimumFast"]["Group_SelectedTarget"]["name"]
				else
					return false
				end
			elseif temp == "maintank1" or temp == "maintank2" or temp == "maintank3" or temp == "maintank4" or temp == "maintank5" or temp == "maintank6" or temp == "maintank7" or temp == "maintank8"  then
				local tbl =SuperTreatmentDBF["Unit"]["RaidList"][temp]
				local MT = SuperTreatmentDBF["Unit"]["MTList"]
				local index = tonumber(strsub(temp,9,9))
				if MT["TypeChecked"] == 1 then
					FireHasBeen = MT["Default"][index] or ""
				elseif MT["TypeChecked"] == 2 then
					FireHasBeen = MT["Custom"][index]
				end
			elseif not disabled and temp ~= "SelectedTarget" and temp ~= "FireHasBeenSet" then
				FireHasBeen = temp
			end
			local value,temp,v_unit,name,s_unit
			local Count = 0
			local MaximumValue,MinimumValue
			local MaximumUnit,MinimumUnit
			if FireHasBeen then
				Members = 1
			else
				if group == "party" or group=="partypet" then
					Members = GetNumSubgroupMembers() + 1
				elseif group == "raid"  or group == "raidpet" then
					Members =GetNumGroupMembers()
				elseif group == "arena" then
					Members = 5
				elseif group == "arenapet" then
					Members = 5
				elseif group == "maintank" then
					Members = 8
				end
			end
			if MultitaskingChecked and Members<=0 then
				ST.Multitasking["Count"] = 1
				coroutine.yield()
			else
				ST.Multitasking["Count"] = Members
			end
			for i=1, Members do
				local isok = true
				if FireHasBeen then
					unit = FireHasBeen
				else
					if i == Members and group == "party" then
						unit = "player"
					elseif i == Members and group == "partypet" then
						unit = "pet"
					elseif group == "maintank" then
						local RDB = SuperTreatmentDBF["Unit"]["RaidList"]
						local MT = SuperTreatmentDBF["Unit"]["MTList"]
						local MTindex = i
						local tbl = RDB[group .. tostring(MTindex)]
						if MT["TypeChecked"] == 1 then
							unit = MT["Default"][MTindex]
							if not unit then
								unit = ""
							end
							--tbl["unit"] = unit
						elseif MT["TypeChecked"]==2 then
							unit = MT["Custom"][MTindex]
							--tbl["unit"] = unit
						end
					else
						unit = group .. tostring(i)
					end
				end
				local TargetLayer = TBL["AmminimumFast"]["TargetLayer"] or 0
				local TargetLayerText = ""
				for n = 1, TargetLayer do
					TargetLayerText = TargetLayerText .. "-target"
				end
				unit = unit .. TargetLayerText
				if unit then
					name = amGetUnitName(unit,true)
				end
				if MultitaskingChecked then
					coroutine.yield()
				end
				local IsEx
				if  name then
					--print(name,SuperTreatmentDBF["Unit"]["RaidList"][name])
					local ExcludedTarget = not TBL["AmminimumFast"]["ExcludedTarget"][name]
					local ExcludedGroup = true
					if TBL["AmminimumFast"]["ExcludedGroup"] and SuperTreatmentDBF["Unit"]["RaidList"][name] and SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"] then
						ExcludedGroup = not TBL["AmminimumFast"]["ExcludedGroup"][SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"]]
					end
					local index = ST["Spells_Index"]
					local tbl = SuperTreatmentDBF["Spells"]["List"][index]
					local Global_subgroup
					local GlobalExcludedGroup = true
					local GlobalExcludeTarget = true
					local GlobalExcludeMT = true
					if tbl["ExcludedGroupChecked"] then
						if SuperTreatmentDBF["Unit"]["RaidList"][name] and SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"] then
							Global_subgroup = SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"]
							GlobalExcludedGroup = not tbl["ExcludedGroup"][Global_subgroup]
						end
					else
						if SuperTreatmentDBF["Unit"]["RaidList"][name] and SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"] then
							Global_subgroup = SuperTreatmentDBF["Unit"]["RaidList"][name]["subgroup"]
							GlobalExcludedGroup = not SuperTreatmentDBF["Unit"]["ExcludedGroup"][Global_subgroup]
						end
					end
					if tbl["ExcludeTargetChecked"] then
						GlobalExcludeMTChecked = not tbl["ExcludeTarget"][name]
					else
						GlobalExcludeTarget = not SuperTreatmentDBF["Unit"]["ExcludeTarget"][name]
					end
					if tbl["ExcludeMTChecked"] then
						local tblmt = stGetMtList()
						GlobalExcludeMT = not tblmt[name]
					end
					IsEx = ExcludedGroup and ExcludedTarget and GlobalExcludedGroup and GlobalExcludeTarget and GlobalExcludeMT
				end
				if name and IsEx and unitfr then
					--local tv = amisr(namespell,unit) and UnitIsConnected(unit) and not UnitIsCorpse(unit) and not UnitIsDeadOrGhost(unit)
					local tv
					if TBL["AmminimumFast"]["GhostChecked"] then
						tv =  UnitIsConnected(unit) and not UnitIsCorpse(unit) and not UnitIsDeadOrGhost(unit)
					else
						tv =true
					end
					if tv then
						if SpellDistanceChecked then
							--tv = amisr(namespell,unit,false,PowerCostChecked,false,true)
							local tempPowerCostChecked
							if PowerCostChecked then
								tempPowerCostChecked = 1
							end
							tv = amisr(namespell,unit,false,tempPowerCostChecked,false,true,nil,data["NoAcChecked"])
						elseif NoDistanceChecked then
						elseif DistanceChecked then
							tv = amjl(unit) <= Distancevalue
						end
					end
					if name and tv then
						local v_buff,v_spell,v_Class,v_code,v_Nobuff,v_ApiDbf,v_RangeCheckAngle
						if buff then
							v_buff = ST.mminimumFast_SpellsRun_buff(unit,buff,TBL,TBL["AmminimumFast"]["NewBuff"])
						else
							v_buff = true
						end
						isok = isok and v_buff
						if Nobuff and isok then
							--v_Nobuff = ST.mminimumFast_SpellsRun_Nobuff(unit,Nobuff,TBL,TBL["AmminimumFast"]["NewNobuff"])
							v_Nobuff = not ST.mminimumFast_SpellsRun_buff(unit,Nobuff,TBL,TBL["AmminimumFast"]["NewNobuff"])
						else
							v_Nobuff = true
						end
						isok = isok and v_Nobuff
						if spell and isok then
							v_spell = ST.mminimumFast_SpellsRun_spell(unit,TBL["AmminimumFast"]["NewSpell"])
						else
							v_spell = true
						end
						isok = isok and v_nobuff and v_spell
						if AmminimumFastCode and isok then
							v_code = AmminimumFastCode(unit)
						else
							v_code = true
						end
						isok = isok and v_code
						if Class and isok then
							v_Class = ST.mminimumFast_SpellsRun_Class(unit,Class)
						else
							v_Class = true
						end
						isok = isok and v_Class
						if ApiDbf and isok then
							v_ApiDbf = ST.mminimumFast_SpellsRun_ApiDbf(TBL["AmminimumFast"],unit)
						else
							v_ApiDbf = true
						end
						isok = isok and v_ApiDbfEx and v_ApiDbf
						--print(v_buff,v_spell,v_Class,v_code,v_Nobuff,v_ApiDbf)
						--print("isok",isok)
						if isok then
							if not Maximumchecked and not Minimumchecked then
								Count = Count + 1
								s_unit = unit
								--return unit
							else
								local IsMaximum
								local IsMinimum
								if Maximumchecked then
									if MaximumCode then
										local funcV1,funcV2 = MaximumCode(unit)
										if funcV1 then
											--print(funcV1,funcV2)
											IsMaximum = funcV2
										end
									end
								end
								if Minimumchecked then
									if MinimumCode then
										local funcV1,funcV2 = MinimumCode(unit)
										if funcV1 then
											IsMinimum = funcV2
										end
									end
								end
								if Maximumchecked and Minimumchecked then
									if IsMaximum and IsMinimum then
										if not value then
											value = IsMaximum
											v_unit = unit
										else
											if IsMaximum < value then
												--value = funcV2
												value = IsMaximum
												v_unit = unit
											end
										end
										Count = Count + 1
									end
								elseif Maximumchecked and not Minimumchecked then
									if IsMaximum then
										if not value then
											value = IsMaximum
											v_unit = unit
										else
											--if IsMaximum < value then
											if IsMaximum > value then
												--value = funcV2
												value = IsMaximum
												v_unit = unit
											end
										end
										Count = Count + 1
									end
								elseif not Maximumchecked and Minimumchecked then
									if IsMinimum then
										if not value then
											value = IsMinimum
											v_unit = unit
										else
											if IsMinimum < value then
												--value = funcV2
												value = IsMinimum
												v_unit = unit
											end
										end
										Count = Count + 1
									end
								end
								if value then
									--print(s_unit,value)
									s_unit=v_unit
									--return v_unit;
								end
							end
						end
					end
				end
			end
			local v_Count=TBL["AmminimumFast"]["Count"]
			local v_Count_L = true
			local v_Count_H = true
			local IsCount = true
			if TBL["AmminimumFast"]["Countchecked"] then
				if v_Count["<"]["checked"] and v_Count["<"]["Value"] then
					v_Count_L = Count <= v_Count["<"]["Value"]
				end
				if v_Count[">"]["checked"] and v_Count[">"]["Value"] then
					v_Count_H = Count >= v_Count[">"]["Value"]
				end
				IsCount = v_Count_L and v_Count_H
			end
			--print(Count,IsCount)
			--[[
			if (s_unit) then
				if st_h ~= amGetUnitName(s_unit,true).. aml(s_unit) then
					st_h = amGetUnitName(s_unit,true).. aml(s_unit)
					print(IsCount,"|cffff0000" .. format("%.0f",aml(s_unit,"%",1)) .. "|r",amGetUnitName(s_unit,true))
				end
			end--]]
			if (TBL["AmminimumFast"]["CountFalseChecked"] and not s_unit and IsCount) then
				return "player",true
			elseif (s_unit and IsCount) then
				return s_unit,true
			end
		end
	end
	
	function ST.mminimumFast_SpellsRun_Nobuff_bak(unit,BuffName,TBL)
		local OwnChecked = TBL["NobuffOwnChecked"]
		local strlist = {}
		local TextureTbl = {}
		local SpellIdTbl = {}
		local NameTbl = {}
		local Name,Texture
		local v1, v2, v3 = {}, {}, {}
		for k, d in pairs(BuffName) do
			Name,_,Texture = GetSpellInfo(d.SpellId)
			if d["IsTexture"] then
				table.insert(TextureTbl,Texture)
			elseif d["IsSpellId"] then
				table.insert(SpellIdTbl,d.SpellId)
			else
				table.insert(NameTbl,Name)
			end
		end
		if #NameTbl > 0 or #TextureTbl > 0 or #SpellIdTbl > 0 then
			if OwnChecked then
				table.insert(v1,"player")
				table.insert(v2,false)
				table.insert(v3,false)
			end
			if #NameTbl > 0 then
				table.insert(v1,"name")
				table.insert(v2,NameTbl)
				table.insert(v3,0)
			end
			if #TextureTbl > 0 then
				table.insert(v1,"icon")
				table.insert(v2,TextureTbl)
				table.insert(v3,false)
			end
			if #SpellIdTbl > 0 then
				table.insert(v1,"id")
				table.insert(v2,SpellIdTbl)
				table.insert(v3,false)
			end
			local N = #ambufflist(unit,v1,v2,v3)
			amm = {}
			amm.v1 = v1
			amm.v2 = v2
			amm.v3 = v3
			return  N <= 0
		end
		return true
	end
	
	function ST.mminimumFast_SpellsRun_buff_bak(unit,buff,TBL)
		local _, Class = UnitClassBase(unit)
		local IsClass = 0
		local BuffCdChecked = TBL["AmminimumFast"]["BuffCdChecked"]
		local BuffCdMaxChecked = TBL["AmminimumFast"]["BuffCdMaxChecked"]
		local BuffCd = TBL["AmminimumFast"]["BuffCd"]
		local BuffCdMax = TBL["AmminimumFast"]["BuffCdMax"]
		local RemoveBuff = TBL["AmminimumFast"]["RemoveBuff"]
		local AddBuff = TBL["AmminimumFast"]["AddBuff"]
		local value = TBL["AmminimumFast"]["ValueBuff"]
		local checked = TBL["AmminimumFast"]["ValueBuffchecked"]
		local OwnChecked = TBL["AmminimumFast"]["BuffOwnChecked"]
		local IsBuff = true
		if not checked and (AddBuff or RemoveBuff) then
			IsBuff =false
			local BuffName = buff
			local Name,Texture
			local v= TBL["AmminimumFast"]
			local TextureTbl = {}
			local SpellIdTbl = {}
			local NameTbl = {}
			local v1, v2, v3 = {}, {}, {}
			for k, d in pairs(BuffName) do
				if not d["Class"] or not d["Class"][Class] then
					Name, _, Texture = GetSpellInfo(d.SpellId)
					if d["IsTexture"] then
						table.insert(TextureTbl,Texture)
					end
					if d["IsSpellId"] then
						table.insert(SpellIdTbl,d.SpellId)
					end
					table.insert(NameTbl,Name)
				end
			end
			if #NameTbl > 0 then
				if OwnChecked then
					table.insert(v1,"player")
					table.insert(v2,false)
					table.insert(v3,false)
				end
				table.insert(v1,"name")
				table.insert(v2,NameTbl)
				table.insert(v3,0)
				if #TextureTbl > 0 then
					table.insert(v1,"icon")
					table.insert(v2,TextureTbl)
					table.insert(v3,false)
				end
				if #SpellIdTbl > 0 then
					table.insert(v1,"id")
					table.insert(v2,SpellIdTbl)
					table.insert(v3,false)
				end
				local N = #ambufflist(unit,v1,v2,v3)
				if AddBuff then
					IsBuff = N <= 0
				elseif RemoveBuff then
					IsBuff = N > 0
				end
			end
		elseif not checked and (BuffCdChecked or BuffCdMaxChecked) then
			IsBuff = false
			local BuffName = buff
			local Name,Texture
			local v= TBL["AmminimumFast"]
			local TextureTbl = {}
			local SpellIdTbl = {}
			local NameTbl = {}
			local v1,v2,v3={},{},{}
			for k, d in pairs(BuffName) do
				if not d["Class"] or not d["Class"][Class] then
					Name,_,Texture=GetSpellInfo(d.SpellId)
					if d["IsTexture"] then
						table.insert(TextureTbl,Texture)
					end
					if d["IsSpellId"] then
						table.insert(SpellIdTbl,d.SpellId)
					end
					table.insert(NameTbl,Name)
				end
			end
			if #NameTbl > 0 then
				if OwnChecked then
					table.insert(v1,"player")
					table.insert(v2,false)
					table.insert(v3,false)
				end
				table.insert(v1,"name")
				table.insert(v2,NameTbl)
				table.insert(v3,0)
				if #TextureTbl  >0 then
					table.insert(v1,"icon")
					table.insert(v2,TextureTbl)
					table.insert(v3,false)
				end
				if #SpellIdTbl > 0 then
					table.insert(v1,"id")
					table.insert(v2,SpellIdTbl)
					table.insert(v3,false)
				end
				local N = #ambufflist(unit,v1,v2,v3);
				v1,v2,v3={},{},{};
				if N>0 then
					if OwnChecked then
						table.insert(v1,"player")
						table.insert(v2,false)
						table.insert(v3,false)
					end
					table.insert(v1,"name")
					table.insert(v2,NameTbl)
					table.insert(v3,0)
					--BuffCdChecked or BuffCdMaxChecked
					if BuffCdChecked then
						table.insert(v1,"time")
						table.insert(v2,false)
						table.insert(v3,BuffCd)
					end
					if BuffCdMaxChecked then
						table.insert(v1,"time")
						table.insert(v2,BuffCdMax)
						table.insert(v3,false)
					end
					if v1 and #v1>0 then
						if #TextureTbl>0 then
							table.insert(v1,"icon")
							table.insert(v2,TextureTbl)
							table.insert(v3,false)
						end
						if #SpellIdTbl>0 then
							table.insert(v1,"id")
							table.insert(v2,SpellIdTbl)
							table.insert(v3,false)
						end
						table.insert(v1,"name")
						table.insert(v2,NameTbl)
						table.insert(v3,false)
						IsBuff = #ambufflist(unit,v1,v2,v3)>0
						--[[
						amv={}
						amv[1]=v1
						amv[2]=v2
						amv[3]=v3
						--]]
					end
				else
					if BuffCdChecked and not BuffCdMaxChecked then
						IsBuff =  0 <= BuffCd
					elseif not BuffCdChecked and BuffCdMaxChecked then
						IsBuff = 0 >= BuffCdMax
					elseif BuffCdChecked and BuffCdMaxChecked then
						IsBuff =  0 <= BuffCd and 0 >= BuffCdMax
					end
				end
			end
		elseif checked then
			IsBuff = false
			local BuffName = buff
			local Name,Texture
			local v= TBL["AmminimumFast"]
			local TextureTbl={}
			local SpellIdTbl={}
			local NameTbl={}
			local v1,v2,v3={},{},{}
			for k, d in pairs(BuffName) do
				if not d["Class"] or not d["Class"][Class] then
					Name,_,Texture=GetSpellInfo(d.SpellId)
					if d["IsTexture"] then
						table.insert(TextureTbl,Texture)
					end
					if d["IsSpellId"] then
						table.insert(SpellIdTbl,d.SpellId)
					end
					table.insert(NameTbl,Name)
				end
			end
			if #NameTbl>0 then
				if OwnChecked then
					table.insert(v1,"player")
					table.insert(v2,false)
					table.insert(v3,false)
				end
				table.insert(v1,"name")
				table.insert(v2,NameTbl)
				table.insert(v3,0)
				if #TextureTbl>0 then
					table.insert(v1,"icon")
					table.insert(v2,TextureTbl)
					table.insert(v3,false)
				end
				if #SpellIdTbl>0 then
					table.insert(v1,"id")
					table.insert(v2,SpellIdTbl)
					table.insert(v3,false)
				end
				local N = #ambufflist(unit,v1,v2,v3)
				v1,v2,v3={},{},{};
				if N>0 then
					if OwnChecked then
						table.insert(v1,"player")
						table.insert(v2,false)
						table.insert(v3,false)
					end
					table.insert(v1,"name")
					table.insert(v2,NameTbl)
					table.insert(v3,0)
					if #TextureTbl>0 then
						table.insert(v1,"icon")
						table.insert(v2,TextureTbl)
						table.insert(v3,false)
					end
					if #SpellIdTbl>0 then
						table.insert(v1,"id")
						table.insert(v2,SpellIdTbl)
						table.insert(v3,false)
					end
					table.insert(v1,"passingtime")
					table.insert(v2,value)
					table.insert(v3,false)
					IsBuff = #ambufflist(unit,v1,v2,v3)>0
				end
			end --BuffCdChecked or BuffCdMaxChecked
		end
		return IsBuff
		--[[
		for v, data in pairs(buff) do
			--print(v)if type(data) == "table" then
			local name,duration,expirationTime,TOTime
			local isbuff = true
			if BuffCdChecked or BuffCdMaxChecked then
				local unitCaster,tn
				tn,_,_,_,_,unitCaster,duration,expirationTime = amaura(v,unit,2,0)
				if tn > 0 then
					name = v
				else
					name = false
				end
				local n;
				if name then
					n = expirationTime - GetTime()
					TOTime = duration - (expirationTime - GetTime())
				else
					n = 0
					TOTime = 0
				end
				if BuffCdChecked then
					isbuff = isbuff and n <= BuffCd
				end
				if BuffCdMaxChecked then
					isbuff = isbuff and n >= BuffCdMax
				end
				if checked then
					if name then
						isbuff = isbuff and TOTime > value
					else
						isbuff = false
					end
				end
			elseif RemoveBuff then
				local unitCaster,tn
				tn,_,_,_,_,unitCaster,duration,expirationTime = amaura(v,unit,2,0)
				if tn > 0 then
					name = v
				else
					name = false
				end
				if name then
					if checked then
						isbuff = isbuff and (duration - (expirationTime - GetTime()) > value)
					else
						isbuff = true
					end
				else
					isbuff = false
				end
			elseif AddBuff then
				local unitCaster,tn;
				tn,_,_,_,_,unitCaster,duration,expirationTime = amaura(v,unit,2,0)
				if tn > 0 then
					name = v
					isbuff = false
				else
					name = false
					isbuff = true
				end
				if name then
					if checked then
						isbuff = isbuff and (duration - (expirationTime - GetTime()) > value)
					end
				else
					isbuff=true
				end
			else
				isbuff = false
			end
			if isbuff then
				if not data["Class"] or not data["Class"][Class] then
					IsClass = IsClass + 1
				end
			end
		end
	end--]]
	--return IsClass > 0 ;
end

local function GetBuffName(unit, buffName, filter)
	if buffName then
		for i = 1, 40 do
			local name,_,_,_,_,_,unitCaster,_,_,spellId = UnitBuff(unit,i, filter)
			if buffName == name then
				return UnitBuff(unit, i, filter)
			end 
		end
	end
end

local function GetDeBuffName(unit, buffName, filter)
	if buffName then
		for i = 1, 40 do
			local name,_,_,_,_,_,unitCaster,_,_,spellId = UnitDebuff(unit,i, filter)
			if buffName == name then
				return UnitDebuff(unit, i, filter)
			end 
		end
	end
end


local function mminimumFast_SpellsRun_buff_IsName(isok,i,v,buffname,Rank,unit,buff)
	local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3
	local IsPlayer = true
	local filter,IsRank
	filter = GetBuffFilter(v)
	if v.IsSpellIdTexture == "IsNameRank" then
		IsRank = v.Rank or Rank
	end
	if v["IsType"]== "Auto" or not v["IsType"] then
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = GetDeBuffName(unit,buffname,IsRank,filter)
		if not name then
			name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId= GetBuffName(unit,buffname,filter)
		end
	elseif v["IsType"]== "HELPFUL" then
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId= GetBuffName(unit,buffname,IsRank,filter)
	elseif v["IsType"]== "HARMFUL" then
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = GetDeBuffName(unit,buffname,IsRank,filter)
	end
	return IsBuffValue(v,isok,IsPlayer,name,count,duration, expirationTime, unitCaster)
end

local function mminimumFast_SpellsRun_buff_IsSpellIdTexture(isok,i,v,buffname,Rank,Texture,unit,buff)

	local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, nameplateShowAll, timeMod, value1, value2, value3
	local IsPlayer = true
	local filter,IsRank,buffname_e
	filter = GetBuffFilter(v)
	for i=1,100 do
		if v["IsType"]== "Auto" or not v["IsType"] then
			name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = UnitDebuff(unit,i,filter)
			if not name then
				name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId= UnitBuff(unit,i,filter)
			end
		elseif v["IsType"]== "HELPFUL" then
			name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId= UnitBuff(unit,i,filter)
		elseif v["IsType"]== "HARMFUL" then
			name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellId = UnitDebuff(unit,i,filter)
		end
		if not name then
			break
		end
		if (v.IsSpellIdTexture == "IsSpellId" and v.SpellId == spellId) or (v.IsSpellIdTexture == "IsTexture" and Texture == icon) then
			isok = true
			buffname_e=name
			break
		end
	end
	isok = IsBuffValue(v,isok,IsPlayer,buffname_e,count,duration, expirationTime, unitCaster)
	return isok
end

function ST.mminimumFast_SpellsRun_buff(unit,buff,TBL,dbl)
	local IsCounts = 0
	local isok = false
	local Counts = 0
	local Class = select(2,UnitClassBase(unit))
	local isClass = true
	for i, v in pairs(buff) do
		if v["IsCd"] ~= "No" then
			isok=false
			if v["IsClass"] then
				isClass = not v["Class"][Class]
			end
			if isClass then
				local buffname,Rank,Texture = GetSpellInfo(v["SpellId"])
				if buffname then
					if v.IsSpellIdTexture == "IsName" or v.IsSpellIdTexture == "IsNameRank" or not v.IsSpellIdTexture then
						isok = mminimumFast_SpellsRun_buff_IsName(isok,i,v,buffname,Rank,unit,buff)
					elseif v.IsSpellIdTexture == "IsSpellId" or v.IsSpellIdTexture == "IsTexture" then
						isok = mminimumFast_SpellsRun_buff_IsSpellIdTexture(isok,i,v,buffname,Rank,Texture,unit,buff)
					end
					if isok and v_isok then
						IsCounts = IsCounts + 1
					end
					if isok and dbl["IsOrAnd"] == "Or" then
						break
					end
				end
				Counts = Counts + 1
			end
		end
	end
	if dbl["IsOrAnd"] == "Or" or not dbl["IsOrAnd"] then
		return IsCounts > 0
	else
		return IsCounts > 0 and IsCounts == Counts
	end
end

function ST.mminimumFast_SpellsRun_spell_BAK(unit,TBL,T)
	local spell, _, _, _, startTime, endTime = UnitCastingInfo(unit)
	if not spell then
		spell, _, _, _, startTime, endTime = UnitChannelInfo(unit)
	end
	if not spell then
		return false
	end
	local GTime =GetTime() - (startTime/1000)
	local LTime = (endTime/1000) - GetTime() 
	local Isvalue,IsPoorvalue
	local AllSpell = T["AmminimumFast"]["AllSpell"]
	local AllValueChecked = T["AmminimumFast"]["SpellValueChecked"]
	local AllValue = T["AmminimumFast"]["SpellValue"]
	local AllSpellValuePoorChecked = T["AmminimumFast"]["SpellValuePoorChecked"]
	local AllSpellValuePoorvalue = T["AmminimumFast"]["SpellValuePoorvalue"]
	if AllSpell then
		if spell then
			if AllValueChecked then
				if not AllValue then
					AllValue=0
				end
				Isvalue =  GTime >= AllValue
			else
				Isvalue = true
			end
			if AllSpellValuePoorChecked then
				if not AllSpellValuePoorvalue then
					AllSpellValuePoorvalue = 0
				end
				IsPoorvalue =  LTime <= AllSpellValuePoorvalue
			else
				IsPoorvalue = true
			end
			return IsPoorvalue and Isvalue
		end
	else
		if TBL[spell] then
			if AllValueChecked then
				if not AllValue then
					AllValue=0
				end
				Isvalue =  GTime >= AllValue
			else
				if TBL[spell]["Checked"] then
					local vvv = TBL[spell]["value"]
					Isvalue = GTime >= vvv
				else
					Isvalue = true
				end
			end
			if AllSpellValuePoorChecked then
				if not AllSpellValuePoorvalue then
					AllSpellValuePoorvalue=0
				end
				IsPoorvalue =  LTime <= AllSpellValuePoorvalue 
			else
				if TBL[spell]["PoorChecked"] then
					local vvv = TBL[spell]["Poorvalue"]
					IsPoorvalue =  LTime <= vvv
				else
					IsPoorvalue = true
				end
			end
			return IsPoorvalue and Isvalue
		end
	end
	return false
end

function ST.mminimumFast_SpellsRun_RangeCheckAngle(data,unit) ---职业 函数处理
	local tbl = data["PlayerRangeCheckAngle"]
	local IsRange = false
	local IsCount = true
	local IsBuff = true
	local IsHealth = true
	local tblR = tbl["Range"]
	local tblC = tbl["Count"]
	local dots
	local ExcludedPlayerChecked = tbl["ExcludedPlayerChecked"]
	local MinHealth = 0
	local MaxHealth = 0
	local MinHealthUnit
	local MaxHealthUnit
	dots = ST.RangeCheck.Radar(unit,1000)
	if not dots then
		return false
	end
	if true then
		local Count = 0
		local A,B
		for k, v in pairs(dots) do
			v.IsRange = false
			v.ok = false
			if not ExcludedPlayerChecked or (not UnitIsUnit(v.uId, "player")) then
				--print(ExcludedPlayerChecked,UnitName(v.uId),UnitName(unit))
				local x = v.x
				local y = v.y
				local range = (x*x + y*y) ^ 0.5
				if tblR["<"]["checked"] then
					A = range <= 1.10 * tblR["<"]["Value"]
				else
					A = true
				end
				if tblR[">"]["checked"] then
					B = range >= tblR[">"]["Value"]
				else
					B = true
				end
				if A and B and (tblR[">"]["checked"] or tblR["<"]["checked"]) then
					Count = Count + 1
					v.IsRange = true
					v.ok = true
				end
			end
		end
		if Count<=0 then
			return false
		else
			IsRange=true
		end
	end
	for k, v in pairs(dots) do
		if v.ok then
			local Group = ST["UnitId"][v.uId]["subgroup"]
			local name = ST["UnitId"][v.uId]["name"]
			if tbl["ExcludedTarget"]["checked"] then
				local IsExcludedTarget = true
				local IsExcludedGroup = true
				if tbl["ExcludedTarget"]["TargetCount"]>0 then
					IsExcludedTarget = not tbl["ExcludedTarget"]["Target"][name]
				end
				if tbl["ExcludedTarget"]["GroupCount"]>0 then
					IsExcludedGroup = not tbl["ExcludedTarget"]["Group"][Group];
				end
				if IsExcludedGroup and IsExcludedTarget then
					v.ok = true
				else
					v.ok = false
				end
			else
				--v.ok =  ExcludedTargetGroup(name)
			end
			if tbl["ExcludedClass"]["checked"] and v.ok then
				if tbl["ExcludedClass"]["ClassCount"]>0 then
					local Class = ST["UnitId"][v.uId]["englishClass"]
					v.ok = not tbl["ExcludedClass"]["Class"][Class];
				end
			end
		end
	end
	if true then
		local Percentage,Lack;
		local Count = 0
		if tbl["Min_Max"]["Type"]=="Minimum_Blood_Percentage" or tbl["Min_Max"]["Type"]=="Minimum_LackBlood_Percentage" or tbl["Min_Max"]["Type"]=="Maximum_Blood_Percentage" or tbl["Min_Max"]["Type"]=="Maximum_LackBlood_Percentage" then
			Percentage = "%";
		else
			Percentage = "1";
		end
		if tbl["Min_Max"]["Type"]=="Minimum_LackBlood_Percentage" or tbl["Min_Max"]["Type"]=="Minimum_LackBlood" or tbl["Min_Max"]["Type"]=="Maximum_LackBlood_Percentage" or tbl["Min_Max"]["Type"]=="Maximum_LackBlood" then
			Lack = 1
		else
			Lack = 0;
		end
		for k, v in pairs(dots) do
			if v.ok then
				local A,B
				local Health = aml(v.uId,Percentage,Lack)
				if tbl["Min_Max"]["<"]["checked"] then
					A = Health <= tbl["Min_Max"]["<"]["Value"]
				else
					A = true
				end
				if tbl["Min_Max"][">"]["checked"] then
					B = Health >= tbl["Min_Max"][">"]["Value"]
				else
					B = true
				end
				if A and B then
					Count = Count +1
					v.ok = true
					--[[
					if Health < MinHealth then
						MinHealth = Health
						MinHealthUnit = v.uId
					end
					if Health > MaxHealth then
						MaxHealth = Health
						MaxHealthUnit = v.uId
					end --]]
				else
					v.ok = false
				end
			end
		end
	end
	if tbl["NewBuff"]["checked"] then
		for k, v in pairs(dots) do
			if v.ok then
				v.ok= ST.mminimumFast_SpellsRun_buff(unit,tbl["NewBuff"]["buffs"],nil,tbl["NewBuff"])
				v.IsBuff=v.ok
			end
		end
	end
	if tbl["Count"][">"]["checked"] or tbl["Count"]["<"]["checked"] then
		local a,b;
		local Count = 0;
		IsCount = false
		for k, v in pairs(dots) do
			v.IsCount = false;
			if v.ok then
				Count = Count +1;
			end
		end
		if tblC["<"]["checked"] then
			a = Count <= tblC["<"]["Value"];
		else
			a = true
		end
		if tblC[">"]["checked"] then
			b = Count >= tblC[">"]["Value"]
		else
			b = true
		end
		if not tblC[">"]["checked"] and not tblC["<"]["checked"] then
			IsCount = true
		else
			IsCount = a and b;
		end
	end
	if IsCount then
		--[[
		if tbl["Min_Max"]["Type"]=="Minimum_Blood_Percentage" or tbl["Min_Max"]["Type"]=="Minimum_Blood" or tbl["Min_Max"]["Type"]=="Minimum_LackBlood_Percentage" or tbl["Min_Max"]["Type"]=="Minimum_LackBlood" then
			return MinHealthUnit
		else
			return MaxHealthUnit
		end--]]
		return unit
	end
	return false
end


function ST.mminimumFast_SpellsRun_spell(unit,dbf)
	local spell, _, _, startTime, endTime, isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unit)
	if not spell then
		spell,_,_,startTime,endTime,_,notInterruptible  = UnitChannelInfo(unit)
	end
	if not spell then
		return false
	end
	local StartTime = GetTime() - (startTime/1000)
	local EndTime = (endTime/1000) - GetTime()
	local IsStart,IsEnd,IsNotInterrupt = true,true,true;
	if dbf["AllSpell"] then
		if  dbf["NotInterrupt"]=="No" and not notInterruptible then
			return false
		elseif  dbf["NotInterrupt"]=="Yes" and notInterruptible then
			return false
		end
		if dbf["Cd"]["Start"]["Checked"] then
			IsStart = StartTime >= dbf["Cd"]["Start"]["Value"];
		end
		if dbf["Cd"]["End"]["Checked"] then
			IsEnd = EndTime <= dbf["Cd"]["End"]["Value"]
		end
		return IsEnd and IsStart
	end
	for k,v in pairs(dbf["Spell"]) do
		local Name = GetSpellInfo(v.SpellId) or false
		if Name then
			IsStart,IsEnd,IsNotInterrupt = true,true,true
			if v["Checked"] and spell == Name then
				if  (v["NotInterrupt"]=="No" and notInterruptible) or (v["NotInterrupt"]=="Yes" and not notInterruptible) or v["NotInterrupt"]=="All" or v["NotInterrupt"]==nil then
					if v["Random"] then
						if v["Cd"]["Start"]["Checked"] then
							if castID then
								if (v["Cd"]["Start"]["Random"]["castID"] or 0) ~= castID then
									local Temp_StartTime = math.random((v["Cd"]["Start"]["Random"][">"]["Value"] or 0) * 1000, (v["Cd"]["Start"]["Random"]["<"]["Value"] or 0) *1000)
									v["Cd"]["Start"]["Random"]["castID"] = castID
									v["Cd"]["Start"]["Random"]["Randomval"] = Temp_StartTime
								end
							else
								if GetTime() - (v["Cd"]["Start"]["Random"]["RandomTime"] or 0) >1.3 then
									local Temp_StartTime = math.random((v["Cd"]["Start"]["Random"][">"]["Value"] or 0) * 1000, (v["Cd"]["Start"]["Random"]["<"]["Value"] or 0) *1000)
									v["Cd"]["Start"]["Random"]["RandomTime"] = GetTime()
									v["Cd"]["Start"]["Random"]["Randomval"] = Temp_StartTime
								end
							end
							IsStart = StartTime >= v["Cd"]["Start"]["Random"]["Randomval"]/1000;
						end
						if v["Cd"]["End"]["Checked"] then
							if castID then
								if (v["Cd"]["End"]["Random"]["castID"] or 0) ~= castID then
									local Temp_EndTime = math.random((v["Cd"]["End"]["Random"][">"]["Value"] or 0) * 1000, (v["Cd"]["End"]["Random"]["<"]["Value"] or 0) *1000)
									v["Cd"]["End"]["Random"]["castID"] = castID
									v["Cd"]["End"]["Random"]["Randomval"] = Temp_EndTime
								end
							else
								if GetTime() - (v["Cd"]["End"]["Random"]["RandomTime"] or 0) >1.3 then
									local Temp_EndTime = math.random((v["Cd"]["End"]["Random"][">"]["Value"] or 0) * 1000,(v["Cd"]["End"]["Random"]["<"]["Value"] or 0) *1000);
									v["Cd"]["End"]["Random"]["RandomTime"] = GetTime()
									v["Cd"]["End"]["Random"]["Randomval"] = Temp_EndTime
								end
							end
							IsEnd = EndTime <= v["Cd"]["End"]["Random"]["Randomval"]/1000
						end
					else
						if v["Cd"]["Start"]["Checked"] then
							IsStart = StartTime >= v["Cd"]["Start"]["Value"]
						end
						if v["Cd"]["End"]["Checked"] then
							IsEnd = EndTime <= v["Cd"]["End"]["Value"];
						end
					end
					if IsEnd and IsStart then
						return true
					end
				end
			end
		end
	end
	return false
end


function ST.mminimumFast_SpellsRun_Class(unit,TBL)
	local _,Class = UnitClassBase(unit)
	if not TBL[Class] then
		return true
	end
	return false
end

function ST.Unit_SpellsRun(data,unit)
	local Targets = data["Targets"]; 
	local vr={};
	local r=false
	local checkedok = false
	local k = 0
	if data["and/or"] then
		for i, v in pairs(Targets) do
			if v["checked"] then
				checkedok=true
				local vr = ST.Unit_SpellsRun_1(v,unit)
				if v["not"] then
					vr= not vr
				end
				if vr then
					r=true
					break
				end
			end
		end
	else
		for i, v in pairs(Targets) do
			if v["checked"] then
				checkedok=true
				k=k+1
				vr[i] = ST.Unit_SpellsRun_1(v,unit)
				if v["not"] then
					vr[i]= not vr[i]
				end
				if k ==1 then
					r = vr[i];
				else
					r = r and vr[i]
				end
				if not r then
					r=false;
					break;
				end
			end
		end
	end
	if not checkedok then
		return true;
	end
	return r and ST ;
end

function ST.Unit_SpellsRun_1(data,unit)
	local Conditions = data["Conditions"]; --条件
	local vr={};
	local r = false;
	local checkedok = false
	local k =0;
	for i, v in pairs(Conditions) do
		--print("cc")
		if v["checked"] then
			k=k+1
			checkedok=true
			if v["TargetSubgroup"] == -2 then
				local tbl = SuperTreatmentDBF["Unit"]["RaidList"][v["unit"]];
				if not tbl["runindex"] then
					tbl["runindex"] =0;
				end
				if not ST.Multitasking[v["unit"]] then
					ST.Multitasking[v["unit"]]={};
				end
				if tbl["runindex"] ~= ST.runindex then
					local ism = ST["Multitasking"][v["unit"]];
					if ism["MultitaskingStart"] then
						unit =ism["ReturnsUnit"];
						--print(1,i,unit)
					else
						unit = ST.AmminimumFast_SpellsRun(data,v["unit"])
						--print(2,i,unit)
					end
					tbl["ReturnsUnit"]=unit;
					tbl["runindex"]=ST.runindex;
				else
					unit = tbl["ReturnsUnit"]
					--print(3,i,unit)
				end
			else
				unit = stUnitExplanation(v["unit"]); 
				--unit
			end
			if not unit or not amGetUnitName(unit,true) then
				return false;
			end
			local TargetLayer = v["TargetLayer"] or 0;
			local TargetLayerText="";
			for n=1,TargetLayer do
				TargetLayerText = TargetLayerText .. "-target"
			end
			unit = unit .. TargetLayerText;
			--print(unit)
			vr[i] = ST.Unit_SpellsRun_2(v,unit)
			if v["not"] then
				vr[i]= not vr[i];
			end
			if data["and/or"] then
				if k ==1 then
					r = vr[i];
				else
					r = r or vr[i];
				end
				if r then
					return r;
				end
			else
				if k ==1 then
					r = vr[i];
				else
					r = r and vr[i];
				end
				if not r then
					return r;
				end
			end
		end
	end
	if not checkedok then
		return true
	end
	return r
end

function ST.Unit_SpellsRun_2(data,unit)  -- 函数处理
	local checkedok = false
	local Relationship = data["and/or"]
	local con ;
	---------------------------
	local ApiDbf
	ApiDbf,con = ST.Unit_SpellsRun_2_ApiDbf(data,unit)
	if not con then checkedok = true end 
	if checkedok then
		if Relationship then
			if ApiDbf then
				return ApiDbf
			end
		else
			if not ApiDbf then
				return ApiDbf
			end
		end
	else
		ApiDbf = true
	end
	------------------------
	local Blood
	if data["Blood"]["checked"] then
		Blood ,con = ST.Unit_SpellsRun_2_Blood(data,unit)
		if not con then checkedok = true end 
		--print("Blood",Blood)
		if data["Blood"]["not"] then
			Blood = not Blood
		end
		if Relationship then
			if Blood then
				return Blood
			end
		else
			if not Blood then
				return Blood
			end
		end
	else
		Blood = true
	end
	-------------------------
	local Buff
	if data["NewBuff"] and data["NewBuff"]["checked"] then
		Buff ,con = ST.Unit_SpellsRun_2_Buff(data,unit)
		if not con then checkedok=true;end;
		if data["NewBuff"]["not"] then
			Buff = not Buff
		end
		if Relationship then
			if Buff then
				return Buff
			end
		else
			if not Buff then
				return Buff
			end
		end
	else
		Buff = true
	end
	-------------------------
	local CastSpell;
	if data["NewSpell"] and data["NewSpell"]["checked"] then
		CastSpell ,con = ST.Unit_SpellsRun_2_CastSpell(data["NewSpell"],unit)
		if not con then checkedok=true;end;
		--print("CastSpell",CastSpell)
		if data["NewSpell"]["not"] then
			CastSpell = not CastSpell;
		end
		if Relationship then 
			if CastSpell then
				return CastSpell; 
			end
		else
			if not CastSpell then
				return CastSpell; 
			end
		end
	else
		CastSpell = true
	end
	-------------------------
	local Class;
	if data["Class"]["checked"] then
		Class ,con = ST.Unit_SpellsRun_2_Class(data,unit);
		if not con then checkedok=true;end;
		--print("Class",Class)
		if data["Class"]["not"] then
			Class = not Class;
		end
		if Relationship then 
			if Class then
				return Class; 
			end
		else
			if not Class then
				return Class;
			end
		end;
	else
		Class = true;
	end
	-------------------------
	local ComboPoints;
	if data["ComboPoints"]["checked"] then
		ComboPoints ,con = ST.Unit_SpellsRun_2_ComboPoints(data,unit);
		if not con then checkedok=true;end;
		--print("ComboPoints",ComboPoints)
		if data["ComboPoints"]["not"] then
			ComboPoints = not ComboPoints;
		end
		if Relationship then
			if ComboPoints then
				return ComboPoints;
			end
		else
			if not ComboPoints then
				return ComboPoints; 
			end
		end;
	else
		ComboPoints = true;
	end
	-------------------------
	local Cooldown;
	if data["Cooldown"]["checked"] then
		Cooldown ,con = ST.Unit_SpellsRun_2_Cooldown(data,unit);
		if not con then checkedok=true;end;
		--print("Cooldown",Cooldown)
		if data["Cooldown"]["not"] then
			Cooldown = not Cooldown;
		end
		if Relationship then 
			if Cooldown then
				return Cooldown; 
			end
		else
			if not Cooldown then
				return Cooldown;
			end
		end;
	else
		Cooldown = true
	end
	-------------------------
	local Distance;
	if data["Distance"]["checked"] then
		Distance ,con = ST.Unit_SpellsRun_2_Distance(data,unit);
		if not con then checkedok = true;end;
		--print("Distance",Distance)
		if data["Distance"]["not"] then
			Distance = not Distance;
		end
		if Relationship then
			if Distance then
				return Distance;
			end
		else
			if not Distance then
				return Distance;
			end
		end;
	else
		Distance = true
	end
	-------------------------
	local Energy;
	if data["Energy"]["checked"] then
		Energy ,con = ST.Unit_SpellsRun_2_Energy(data,unit);
		if not con then checkedok=true;end;
		--print("Energy",Energy)
		if data["Energy"]["not"] then
			Energy = not Energy;
		end
		if Relationship then 
			if Energy then
				return Energy; 
			end
		else
			if not Energy then
				return Energy;
			end
		end;
	else
		Energy = true;
	end
	-------------------------
	local SpecialEnergy;
	if data["SpecialEnergy"] and data["SpecialEnergy"]["checked"] then
		SpecialEnergy ,con = ST.Unit_SpellsRun_2_SpecialEnergy(data,unit);
		if not con then checkedok=true;end;
		--print("SpecialEnergy",SpecialEnergy)
		if data["SpecialEnergy"]["not"] then
			SpecialEnergy = not SpecialEnergy;
		end
		if Relationship then
			if SpecialEnergy then
				return SpecialEnergy; 
			end
		else
			if not SpecialEnergy then
				return SpecialEnergy;
			end
		end;
	else
		SpecialEnergy = true;
	end
	-------------------------
	local IsTarget;
	if data["IsTarget"]["checked"] then
		IsTarget ,con = ST.Unit_SpellsRun_2_IsTarget(data,unit);
		if not con then checkedok=true;end;
		--print("IsTarget",IsTarget)
		if data["IsTarget"]["not"] then
			IsTarget = not IsTarget;
		end
		if Relationship then 
			if IsTarget then
				return IsTarget;
			end
		else
			if not IsTarget then
				return IsTarget; 
			end
		end;
	else
		IsTarget = true;
	end
	-------------------------
	local Rune;
	if data["Rune"]["checked"] then
		Rune ,con = ST.Unit_SpellsRun_2_Rune(data,unit);
		if not con then checkedok=true;end;
		--print("Rune",Rune)
		if data["Rune"]["not"] then
			Rune = not Rune;
		end
		if Relationship then
			if Rune then
				return Rune; 
			end
		else
			if not Rune then
				return Rune;
			end
		end;
	else
		Rune = true;
	end
	-------------------------
	local Totem;
	if data["Totem"]["checked"] then
		Totem ,con = ST.Unit_SpellsRun_2_Totem(data,unit);
		if not con then checkedok=true;end;
		--print("Totem",Totem)
		if data["Totem"]["not"] then
			Totem = not Totem;
		end
		if Relationship then
			if Totem then
				return Totem;
			end
		else
			if not Totem then
				return Totem;
			end
		end;
	else
		Totem = true;
	end
	local RangeCheck;
	if data["RangeCheck"] and data["RangeCheck"]["checked"] then
		RangeCheck ,con = ST.Unit_SpellsRun_2_RangeCheck(data,unit);
		if not con then checkedok=true;end;
		--print("RangeCheck",RangeCheck)
		if data["RangeCheck"]["not"] then
			RangeCheck = not RangeCheck;
		end
		if Relationship then
			if RangeCheck then
				return RangeCheck;
			end
		else
			if not RangeCheck then
				return RangeCheck;
			end
		end;
	else
		RangeCheck = true;
	end
	--print(data["PlayerRangeCheckAngle"] , data["PlayerRangeCheckAngle"]["checked"])
	local PlayerRangeCheckAngle
	if data["PlayerRangeCheckAngle"] and data["PlayerRangeCheckAngle"]["checked"] then
		PlayerRangeCheckAngle ,con = ST.Unit_SpellsRun_2_PlayerRangeCheckAngle(data,unit)
		if not con then checkedok=true;end;
		--print("PlayerRangeCheckAngle",PlayerRangeCheckAngle)
		if data["PlayerRangeCheckAngle"]["not"] then
			PlayerRangeCheckAngle = not PlayerRangeCheckAngle;
		end
		if Relationship then 
			if PlayerRangeCheckAngle then
				return PlayerRangeCheckAngle;
			end
		else
			if not PlayerRangeCheckAngle then
				return PlayerRangeCheckAngle; 
			end
		end;
	else
		PlayerRangeCheckAngle = true;
	end
	if not checkedok then
		return true;
	end
	return ApiDbf and Blood and Buff and CastSpell and Class and ComboPoints and playerrange and Cooldown and Distance and Energy and SpecialEnergy and IsTarget and Rune and Totem and RangeCheck and PlayerRangeCheckAngle
end

function ST.Unit_SpellsRun_2_ApiDbf(data,unit) ---ApiDbf 函数处理
	local ApiDbf = data["ApiDbf"];
	local r ;
	local vr ={};
	local checkedok=false;
	local index=0;
	for i, v in pairs(ApiDbf) do
		if v["checked"] then
			index= index+1;
			checkedok = true;
			vr[i]=ST.Unit_SpellsRun_2_ApiDbf_1(v,unit);
			if v["not"] then
				vr[i]= not vr[i];
			end
			if data["and/or"] then
				if i ==1 then
					r = vr[i];
				else
					r = r or vr[i];
				end
				if r then
					return true,not checkedok;
				end
			else
				if index ==1 then
					r = vr[i];
				else
					r = r and vr[i];
				end
				if not r then
					return false,not checkedok;
				end
			end
		end
	end
	if not checkedok then
		return false,not checkedok;
	end
	return r , not checkedok;
end

function ST.Unit_SpellsRun_Run_ApiDbf(v,unit) ---ApiDbf 执行函数处理
	local r ;
	local vr ={};
	local i =1;
	vr[i]=ST.Unit_SpellsRun_2_ApiDbf_1(v,unit);
	if v["not"] then
		vr[i]= not vr[i];
	end
	if v["and/or"] then
		if i ==1 then
			r = vr[i];
		else
			r = r or vr[i];
		end
		if r then
			return true;
		end
	else
		if i ==1 then
			r = vr[i];
		else
			r = r and vr[i];
		end
		if not r then
			return false;
		end
	end
	return r;
end

function ST.Unit_SpellsRun_2_ApiDbf_1(ApiDbf,unit) ---自定义函数求值
	if ApiDbf["func"] then
		--return ApiDbf:func(unit);
	end
	local apiinf = SuperTreatment["Api"][ApiDbf["id"]] ;
	local ACounts = apiinf["Arguments"]["Counts"];
	local RCounts = apiinf["Returns"]["Counts"];
	local va ={};
	local vr ={};
	local Astr ;
	local Rstr ;
	local apiname = ApiDbf["id"];
	for i=1 , ACounts do
		local D = ApiDbf["Arguments"][i];
		if D and D["value"] then
			if  apiinf["Arguments"][i]["type"] == "String"  then
				va[i] = '"' .. D["value"] .. '"';
			else
				va[i] = tostring(D["value"]);
			end
			if Astr then
				Astr =  Astr .. ',' .. va[i];
			else
				Astr =  va[i];
			end
		end
	end
	for i=1 , RCounts do
		local t = apiinf["Returns"][i]["type"];
		local v = ApiDbf["Returns"][i];
		if v and v["checked"] then
			if t == "Number" then
				vr[i] = ST.Unit_SpellsRun_2_ApiDbf_1_Number(ApiDbf,unit,v,i)
			elseif t == "Boolean" then
				vr[i] = ST.Unit_SpellsRun_2_ApiDbf_1_Boolean(ApiDbf,unit,v,i);
			elseif t == "String" then
				vr[i] = ST.Unit_SpellsRun_2_ApiDbf_1_String(ApiDbf,unit,v,i);
			end
			if Rstr then
				Rstr= Rstr .. ' and ' .. vr[i];
			else
				Rstr= vr[i];
			end
		end
	end
	if not Rstr then
		return false;
	end
	Rstr = 'return ' .. Rstr .. '; end;';
	if not Astr then
		Astr="";
	end
	Astr = 'local v = {' .. apiname .. '(' .. Astr .. ')};';
	local funcstr = 'function SuperTreatment_temp(unit) ' .. Astr .. Rstr;
		RunScript(funcstr);
		ApiDbf["func"]=SuperTreatment_temp;
		SuperTreatment_temp=nil;
		--print(funcstr)
		return ApiDbf.func(unit);
	end
	
	function ST.Unit_SpellsRun_2_ApiDbf_1_Number(ApiDbf,unit,v,i)---数值返回值的求值表达式
		local apiinf = SuperTreatment["Api"][ApiDbf["id"]];
		local str;
		local Failure = apiinf["Returns"][i]["Failure"];
		local vx;
		--print(Failure)
		if Failure == nil then
			vx = "v[" .. i .. "]";
		else
			if type(Failure) == "string" then
				vx = "(v[" .. i .. "] or '" .. Failure .. "')" ;
			elseif type(Failure) == "number" then
				vx = "(v[" .. i .. "] or " .. tostring(Failure) .. ")" ;
			elseif type(Failure) == "boolean" then
				vx = "(v[" .. i .. "] or " .. tostring(Failure)  .. ")";
			else
				vx = "v[" .. i .. "]";
			end
		end
		if v["="]["checked"] then
			str = vx .. '==' .. tostring(v["="]["Value"]);
		else
			if v["<"]["checked"] then
				str = vx .. " <= " .. tostring(v["<"]["Value"]);
			end
			if v[">"]["checked"] then
				if str then
					str = str .. " and " .. vx .. " > " .. tostring(v[">"]["Value"]);
				else
					str = vx .. " >= " .. tostring(v[">"]["Value"]);
				end
			end
		end
		if str then
			return str;
		else
			return "false";
		end
	end
	
	function ST.Unit_SpellsRun_2_ApiDbf_1_Boolean(ApiDbf,unit,v,i)---布尔值返回值的求值表达式
		local apiinf = SuperTreatment["Api"][ApiDbf["id"]];
		local str;
		local Failure = apiinf["Returns"][i]["Failure"];
		local vx;
		if Failure == nil then
			vx = "v[" .. i .. "]";
		else
			if type(Failure) == "string" then
				vx = "(v[" .. i .. "] or '" .. Failure .. "')" ;
			elseif type(Failure) == "number" then
				vx = "(v[" .. i .. "] or " .. tostring(Failure) .. ")" ;
			elseif type(Failure) == "boolean" then
				vx = "(v[" .. i .. "] or " .. tostring(Failure)  .. ")";
			else
				vx = "v[" .. i .. "]";
			end
		end
		--local str;
		--local vx = "v[" .. i .. "]";
		if v["checked"] then
			str = "amtoboolean(" ..vx ..") == " .. tostring(amtoboolean(v["value"]));
		end
		return str;
	end
	
	function ST.Unit_SpellsRun_2_ApiDbf_1_String(ApiDbf,unit,v,i)---字符串返回值的求值表达式
		--local str;
		local Select = v["Select"];
		local strlist;
		local isRadio = v["isRadio"];
		--local vx = "v[" .. i .. "]";
		local apiinf = SuperTreatment["Api"][ApiDbf["id"]];
		local str;
		local Failure = apiinf["Returns"][i]["Failure"];
		local vx;
		if Failure == nil then
			vx = "v[" .. i .. "]";
		else
			if type(Failure) == "string" then
				vx = "(v[" .. i .. "] or '" .. Failure .. "')" ;
			elseif type(Failure) == "number" then
				vx = "(v[" .. i .. "] or " .. tostring(Failure) .. ")" ;
			elseif type(Failure) == "boolean" then
				vx = "(v[" .. i .. "] or " .. tostring(Failure)  .. ")";
			else
				vx = "v[" .. i .. "]";
			end
		end
		for k, d in pairs(Select) do
			if strlist then
				strlist = strlist .. "," .. d;
			else
				strlist =  d;
			end
		end
		if v["checked"] and strlist then
			if "Contains" == isRadio then
				str = 'amfind(' .. vx .. ',"' .. strlist .. '",0)';
			elseif "NoContains" == isRadio then
				str = 'not amfind(' .. vx .. ',"' .. strlist .. '",0)';
			elseif "FuzzyContains" == isRadio then
				str = 'amfind(' .. vx .. ',"' .. strlist .. '",-1)';
			elseif "FuzzyNoContains" == isRadio then
				str = 'not amfind(' .. vx .. ',"' .. strlist .. '",-1)';
			end
		end
		if not str or not strlist then
			return "false";
		else
			return str;
		end
	end
	
	function ST.Unit_SpellsRun_2_Blood(data,unit)
		local tbl = data["Blood"];
		local Percentage = tbl["Percentage"];
		local Lack = tbl["Lack"];
		local str;
		local a,b;
		if Lack then
			Lack =1;
		else
			Lack=0;
		end
		if Percentage then
			Percentage ="%";
		else
			Percentage=false;
		end
		if tbl["<"]["checked"] then
			a = aml(unit,Percentage,Lack) <=  tbl["<"]["Value"];
		else
			a = true;
		end
		if tbl[">"]["checked"] then
			b = aml(unit,Percentage,Lack) >=  tbl[">"]["Value"];
		else
			b = true;
		end
		return a and b and (tbl[">"]["checked"] or tbl["<"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_Buff(data,unit)
		return ST.mminimumFast_SpellsRun_buff(unit,data["NewBuff"]["buffs"],nil,data["NewBuff"]);
	end
	function ST.Unit_SpellsRun_2_Buff_old(data,unit)
		local IsBuff = false;
		local Time = false;
		local Layer = false;
		local Buff = data["Buff"];
		local OwnChecked = Buff["OwnChecked"];
		if Buff["IsBuff"]["checked"] then
			local NoBuffChecked = Buff["IsBuff"]["NoBuffChecked"];
			local BuffName = Buff["IsBuff"]["BuffName"];
			local strlist={};
			local v= Buff["IsBuff"];
			local TextureTbl={};
			local SpellIdTbl={};
			local NameTbl={};
			local Name,Texture;
			local v1,v2,v3={},{},{};
			for k, d in pairs(BuffName) do
				Name,_,Texture=GetSpellInfo(d.SpellId);
				if d["IsTexture"] then
					table.insert(TextureTbl,Texture)
				elseif d["IsSpellId"] then
					table.insert(SpellIdTbl,d.SpellId)
				else
					table.insert(NameTbl,Name)
				end
			end
			if #NameTbl>0 or #TextureTbl>0 or #SpellIdTbl>0 then
				if OwnChecked then
					table.insert(v1,"player")
					table.insert(v2,false)
					table.insert(v3,false)
				end
				table.insert(v1,"name")
				table.insert(v2,NameTbl)
				table.insert(v3,0)
				if #TextureTbl>0 then
					table.insert(v1,"icon")
					table.insert(v2,TextureTbl)
					table.insert(v3,false)
				end
				if #SpellIdTbl>0 then
					table.insert(v1,"id")
					table.insert(v2,SpellIdTbl)
					table.insert(v3,false)
				end
				local N = #ambufflist(unit,v1,v2,v3);
				IsBuff = N >0;
				if NoBuffChecked then
					IsBuff = not IsBuff;
				end
			end
		else
			IsBuff=true;
		end
		if Buff["Time"]["checked"] then
			local Start = Buff["Time"]["Start"]["checked"] or Buff["Time"]["Start"]["Maxchecked"];
			local Remaining = Buff["Time"]["Remaining"]["checked"] or Buff["Time"]["Remaining"]["Maxchecked"];
			local strlist;
			local BuffName = Buff["Time"]["BuffName"];
			local isStart= true;
			local isRemaining= true;
			if Remaining then
				--print("Remaining")
				isRemaining =false;
				local v= Buff["Time"]["Remaining"];
				local TextureTbl={};
				local SpellIdTbl={};
				local NameTbl={};
				local Name,Texture;
				local v1,v2,v3={},{},{};
				for k, d in pairs(BuffName) do
					Name,_,Texture=GetSpellInfo(d.SpellId);
					if d["IsTexture"] then
						table.insert(TextureTbl,Texture)
					end
					if d["IsSpellId"] then
						table.insert(SpellIdTbl,d.SpellId)
					end
					table.insert(NameTbl,Name)
				end
				if #NameTbl>0 then
					if OwnChecked then
						table.insert(v1,"name")
						table.insert(v2,NameTbl)
						table.insert(v3,0)
						table.insert(v1,"player")
						table.insert(v2,false)
						table.insert(v3,false)
					else
						table.insert(v1,"name")
						table.insert(v2,NameTbl)
						table.insert(v3,0)
					end
					if #TextureTbl>0 then
						table.insert(v1,"icon")
						table.insert(v2,TextureTbl)
						table.insert(v3,false)
					end
					if #SpellIdTbl>0 then
						table.insert(v1,"id")
						table.insert(v2,SpellIdTbl)
						table.insert(v3,false)
					end
					local N = #ambufflist(unit,v1,v2,v3);
					v1,v2,v3={},{},{};
					if N>0 then
						if #NameTbl>0 then
							if OwnChecked then
								if v["checked"] and not v["Maxchecked"] then
									v1={"player","time"};
									v2={false,false};
									v3={false,v["Value"]};
								elseif not v["checked"] and v["Maxchecked"] then
									v1={"player","time"};
									v2={false,v["MaxValue"]};
									v3={false,false};
								elseif v["checked"] and v["Maxchecked"] then
									v1={"player","time"};
									v2={false,v["Value"]};
									v3={false,v["MaxValue"]};
								end
							else
								if v["checked"] and not v["Maxchecked"] then
									v1={"time"};
									v2={false};
									v3={v["Value"]};
								elseif not v["checked"] and v["Maxchecked"] then
									v1={"time"};
									v2={v["MaxValue"]};
									v3={false};
								elseif v["checked"] and v["Maxchecked"] then
									v1={"time"};
									v2={v["Value"]};
									v3={v["MaxValue"]};
								end
							end
							if v1 and #v1>0 then
								if #TextureTbl>0 then
									table.insert(v1,"icon")
									table.insert(v2,TextureTbl)
									table.insert(v3,false)
								end
								if #SpellIdTbl>0 then
									table.insert(v1,"id")
									table.insert(v2,SpellIdTbl)
									table.insert(v3,false)
								end
								table.insert(v1,"name")
								table.insert(v2,NameTbl)
								table.insert(v3,0)
								if #ambufflist(unit,v1,v2,v3)>0 then
									isRemaining = true;
								end
								--[[
									amv={}
									amv[1]=v1
									amv[2]=v2
									amv[3]=v3--]]
							end
						end
					else
						if v["checked"] and not v["Maxchecked"] then
							isRemaining =  0 <= v["Value"]
						elseif not v["checked"] and v["Maxchecked"] then
							isRemaining = 0 >= v["MaxValue"]
						elseif v["checked"] and v["Maxchecked"] then
							isRemaining =  0 <= v["Value"] and 0 >= v["MaxValue"];
						end
					end
				end
			end
			if Start then
				isStart =false;
				local v= Buff["Time"]["Start"];
				local TextureTbl={};
				local SpellIdTbl={};
				local NameTbl={};
				local Name,Texture;
				local v1,v2,v3;
				for k, d in pairs(BuffName) do
					Name,_,Texture=GetSpellInfo(d.SpellId);
					if d["IsTexture"] then
						table.insert(TextureTbl,Texture)
					end
					if d["IsSpellId"] then
						table.insert(SpellIdTbl,d.SpellId)
					end
					table.insert(NameTbl,Name)
				end
				if #NameTbl>0 then
					if OwnChecked then
						if v["checked"] and not v["Maxchecked"] then
							v1={"player","passingtime"};
							v2={false,v["Value"]};
							v3={false,false};
						elseif not v["checked"] and v["Maxchecked"] then
							v1={"player","passingtime"};
							v2={false,false};
							v3={false,v["MaxValue"]};
						elseif v["checked"] and v["Maxchecked"] then
							v1={"player","passingtime"};
							v2={false,v["Value"]};
							v3={false,v["MaxValue"]};
						end
					else
						if v["checked"] and not v["Maxchecked"] then
							v1={"passingtime"};
							v2={v["Value"]};
							v3={false};
						elseif not v["checked"] and v["Maxchecked"] then
							v1={"passingtime"};
							v2={false};
							v3={v["MaxValue"]};
						elseif v["checked"] and v["Maxchecked"] then
							v1={"passingtime"};
							v2={v["Value"]};
							v3={v["MaxValue"]};
						end
					end
					if v1 and #v1>0 then
						if #TextureTbl>0 then
							table.insert(v1,"icon")
							table.insert(v2,TextureTbl)
							table.insert(v3,false)
						end
						if #SpellIdTbl>0 then
							table.insert(v1,"id")
							table.insert(v2,SpellIdTbl)
							table.insert(v3,false)
						end
						table.insert(v1,"name")
						table.insert(v2,NameTbl)
						table.insert(v3,0)
						if #ambufflist(unit,v1,v2,v3)>0 then
							isStart = true;
						end
						--[[amv={}
						amv[1]=v1
						amv[2]=v2
						amv[3]=v3--]]
					end
				end
			end
			if Start or Remaining then
				Time = isStart and isRemaining;
			end
			--[[
			if Start or Remaining then
				for k, d in pairs(BuffName) do
					local v = d["Name"];
					local name,duration,expirationTime,TOTime;
					local unitCaster,tn;
					if OwnChecked then
						tn,_,_,_,_,unitCaster,duration,expirationTime = amaura(v,unit,0,0);
					else
						tn,_,_,_,_,unitCaster,duration,expirationTime = amaura(v,unit,2,0);
					end
					if tn > 0 then
						name = v;
					else
						name = false;
					end
					local n;
					if name then
						n = expirationTime - GetTime();
						TOTime = duration - (expirationTime - GetTime());
					else
						n = 0 ;
						TOTime = 0;
					end
					if Remaining then
						Time = n <= Buff["Time"]["Remaining"]["Value"] ;
					end
					if Start then
						if Remaining then
							Time = Time and TOTime >= Buff["Time"]["Start"]["Value"] ;
						else
							Time = TOTime >= Buff["Time"]["Start"]["Value"] ;
						end
					end
					if Time then
						break;
					end
				end
			end--]]
			if not Time then
				return false;
			end
		else
			Time=true;
		end
		if Buff["Layer"]["checked"] then
			local MaxChecked = Buff["Layer"]["<"]["checked"]
			local MinChecked = Buff["Layer"][">"]["checked"];
			local strlist;
			local BuffName = Buff["Layer"]["BuffName"];
			local i=0;
			local v= Buff["Layer"];
			local TextureTbl={};
			local SpellIdTbl={};
			local NameTbl={};
			local Name,Texture;
			local v1,v2,v3={},{},{};
			for k, d in pairs(BuffName) do
				Name,_,Texture=GetSpellInfo(d.SpellId);
				if d["IsTexture"] then
					table.insert(TextureTbl,Texture)
				end
				if d["IsSpellId"] then
					table.insert(SpellIdTbl,d.SpellId)
				end
				table.insert(NameTbl,Name)
			end
			if #NameTbl>0 then
				if OwnChecked then
					table.insert(v1,"name")
					table.insert(v2,NameTbl)
					table.insert(v3,0)
					table.insert(v1,"player")
					table.insert(v2,false)
					table.insert(v3,false)
				else
					table.insert(v1,"name")
					table.insert(v2,NameTbl)
					table.insert(v3,0)
				end
				if #TextureTbl>0 then
					table.insert(v1,"icon")
					table.insert(v2,TextureTbl)
					table.insert(v3,false)
				end
				if #SpellIdTbl>0 then
					table.insert(v1,"id")
					table.insert(v2,SpellIdTbl)
					table.insert(v3,false)
				end
				local N = #ambufflist(unit,v1,v2,v3);
				v1,v2,v3={},{},{};
				if N>0 then
					if OwnChecked then
						table.insert(v1,"player")
						table.insert(v2,false)
						table.insert(v3,false)
					end
					if MinChecked and not MaxChecked then
						table.insert(v1,"count")
						table.insert(v2,v[">"]["Value"])
						table.insert(v3,false)
					elseif not MinChecked and MaxChecked then
						table.insert(v1,"count")
						table.insert(v2,false)
						table.insert(v3,v["<"]["Value"])
					elseif MinChecked and MaxChecked then
						table.insert(v1,"count")
						table.insert(v2,v[">"]["Value"])
						table.insert(v3,v["<"]["Value"])
					end
					if v1 and #v1>0 then
						if #TextureTbl>0 then
							table.insert(v1,"icon")
							table.insert(v2,TextureTbl)
							table.insert(v3,false)
						end
						if #SpellIdTbl>0 then
							table.insert(v1,"id")
							table.insert(v2,SpellIdTbl)
							table.insert(v3,false)
						end
						table.insert(v1,"name")
						table.insert(v2,NameTbl)
						table.insert(v3,0)
						if #ambufflist(unit,v1,v2,v3)>0 then
							Layer = true;
						end
						--[[
						amv={}
						amv[1]=v1
						amv[2]=v2
						amv[3]=v3--]]
					end
				else
					if MinChecked and not MaxChecked then
						Layer =  0 >= v[">"]["Value"]
					elseif not MinChecked and MaxChecked then
						Layer = 0 <= v["<"]["Value"]
					elseif MinChecked and MaxChecked then
						Layer =  0 <= v["<"]["Value"] and 0 >= v[">"]["Value"];
					end
				end
			end
		else
			Layer=true;
		end
		return IsBuff and Time and Layer and (Buff["IsBuff"]["checked"] or Buff["Time"]["checked"] or Buff["Layer"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_CastSpell(data,unit) ---读条技能 函数处理
		return ST.mminimumFast_SpellsRun_spell(unit,data);
	end
	
	function ST.Unit_SpellsRun_2_CastSpell_old(data,unit) ---读条技能 函数处理
		local tbl = data["CastSpell"];
		local spell, _, _, startTime, endTime,_,_,Interrupt , spellId= UnitCastingInfo(unit)
		if not spell then
			spell, _, _, startTime, endTime,_,Interrupt = UnitChannelInfo(unit)
		end
		if not spell then
			return false;
		end
		if tbl["InterruptChecked"] and Interrupt then
			return false;
		end
		local AllInterruptChecked = tbl["AllInterruptChecked"];
		local Spells = tbl["Spells"];
		local name;
		local Isvalue,IsPoorvalue;
		local GTime =GetTime() - (startTime/1000);
		local LTime = (endTime/1000) - GetTime() ;
		if AllInterruptChecked then
			if tbl["Remaining"]["checked"] then
				IsPoorvalue =  LTime <= tbl["Remaining"]["Value"] ;
			else
				IsPoorvalue = true;
			end
			if tbl["Start"]["checked"] then
				Isvalue =  GTime >= tbl["Start"]["Value"] ;
			else
				Isvalue = true;
			end
			return IsPoorvalue and Isvalue 
		else
			for k, d in pairs(Spells) do
				if d["Name"] == spell then
					name = spell
					break;
				end
			end
			if not name then return false; end;
			if tbl["Remaining"]["checked"] then
				IsPoorvalue =  LTime <= tbl["Remaining"]["Value"] ;
			else
				IsPoorvalue = true;
			end
			if tbl["Start"]["checked"] then
				Isvalue =  GTime >= tbl["Start"]["Value"] ;
			else
				Isvalue = true;
			end
			return IsPoorvalue and Isvalue ;
		end
		return false;
	end
	
	function ST.Unit_SpellsRun_2_Class(data,unit) ---职业 函数处理
		local tbl = data["Class"]["Excluded"];
		local localizedClass, englishClass = UnitClass(unit);
		return not tbl[englishClass];
	end
	
	function ST.Unit_SpellsRun_2_ComboPoints(data,unit) ---职业 函数处理
		local tbl = data["ComboPoints"];
		local v = UnitPower(unit,4);
		local a,b;
		if tbl["<"]["checked"] then
			a = v <= tbl["<"]["Value"];
		else
			a = true;
		end
		if tbl[">"]["checked"] then
			b = v >= tbl[">"]["Value"] ;
		else
			b = true;
		end
		return a and b and (tbl[">"]["checked"] or tbl["<"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_RangeCheck(data,unit) ---职业 函数处理
		local tblR = data["RangeCheck"]["Range"];
		local tblC = data["RangeCheck"]["Count"];
		local dots;
		if ST.RangeCheck.dots and GetTime() - ST.RangeCheck.UpTime <0.01 then
			dots = ST.RangeCheck.dots;
		else
			dots = ST.RangeCheck.Radar(unit,1000);
		end
		if not dots then
			return false;
		end
		local Count = 0;
		local A,B;
		for k, v in pairs(dots) do
			if not UnitIsUnit(v.uId, unit) then
				local x = v.x
				local y = v.y
				local range = (x*x + y*y) ^ 0.5
				if tblR["<"]["checked"] then
					A = range <= 1.10 * tblR["<"]["Value"];
				else
					A = true;
				end
				if tblR[">"]["checked"] then
					B = range >= tblR[">"]["Value"];
				else
					B = true;
				end
				if A and B and (tblR[">"]["checked"] or tblR["<"]["checked"]) then
					Count = Count +1;
				end
			end
		end
		--print("Count",Count)
		local a,b;
		if tblC["<"]["checked"] then
			a = Count <= tblC["<"]["Value"];
		else
			a = true;
		end
		if tblC[">"]["checked"] then
			b = Count >= tblC[">"]["Value"];
		else
			b = true;
		end
		--print("c",tblC["<"]["checked"],tblC[">"]["checked"])
		--print(a,b)
		return a and b and (tblC[">"]["checked"] or tblC["<"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_PlayerRangeCheckAngle(data,unit) ---职业 函数处理
		local tbl = data["PlayerRangeCheckAngle"];
		if not (tbl["Range"][">"]["checked"] or tbl["Range"]["<"]["checked"]) or not(UnitInRaid(unit) or UnitInParty(unit))  then
			return false;
		end
		if tbl["AngleChecked"] and not UnitIsUnit(unit, "player") and tbl["AngleValue"] <=0 and not tbl["ContainChecked"] then
			return false;
		end
		local IsRange = false;
		local IsCount = true;
		local IsBuff = true;
		local IsHealth = true;
		local IsAngle = true;
		local tblR = tbl["Range"];
		local tblC = tbl["Count"];
		local dots;
		local ContainChecked = tbl["ContainChecked"];
		local AngleChecked = tbl["AngleChecked"]
		dots = ST.RangeCheck.Radar(unit,1000);
		if not dots then
			return false;
		end
		if true then
			local Count = 0;
			local A,B;
			for k, v in pairs(dots) do
				v.IsRange = false;
				v.ok = false;
				if ContainChecked or (not ContainChecked and not UnitIsUnit(v.uId, unit)) then
					local x = v.x
					local y = v.y
					local range = (x*x + y*y) ^ 0.5
					if tblR["<"]["checked"] then
						A = range <= 1.10 * tblR["<"]["Value"];
					else
						A = true;
					end
					if tblR[">"]["checked"] then
						B = range >= tblR[">"]["Value"];
					else
						B = true;
					end
					if A and B and (tblR[">"]["checked"] or tblR["<"]["checked"]) then
						Count = Count +1;
						v.IsRange = true;
						v.ok = true;
					end
				end
			end
			if Count<=0 then
				return false;
			else
				IsRange=true;
			end
		end
		if AngleChecked then
			IsAngle = false;
			local Count = 0;
			local AngleMin = tbl["AngleValue"]/2 * -1;
			local AngleMax = tbl["AngleValue"]/2;
			for k, v in pairs(dots) do
				v.IsAngle = false;
				if v.ok then
					if v.Angle >= AngleMin and v.Angle <= AngleMax then
						v.IsAngle = true;
						Count = Count +1 ;
						v.ok = true;
					else
						v.ok = false;
					end
				end
			end
			IsAngle = Count > 0;
		end
		for k, v in pairs(dots) do
			if v.ok then
				local Group = ST["UnitId"][v.uId]["subgroup"];
				local name = ST["UnitId"][v.uId]["name"];
				if tbl["ExcludedTarget"]["checked"] then
					local IsExcludedTarget = true;
					local IsExcludedGroup = true;
					if tbl["ExcludedTarget"]["TargetCount"]>0 then
						IsExcludedTarget = not tbl["ExcludedTarget"]["Target"][name];
					end
					if tbl["ExcludedTarget"]["GroupCount"]>0 then
						IsExcludedGroup = not tbl["ExcludedTarget"]["Group"][Group];
					end
					if IsExcludedGroup and IsExcludedTarget then
						v.ok = true;
					else
						v.ok = false;
					end
				else
					--v.ok =  ExcludedTargetGroup(name);
				end
				if tbl["ExcludedClass"]["checked"] and v.ok then
					if tbl["ExcludedClass"]["ClassCount"]>0 then
						local Class = ST["UnitId"][v.uId]["englishClass"];
						v.ok = not tbl["ExcludedClass"]["Class"][Class];
					end
				end
			end
		end
		if tbl["Health"][">"]["checked"] or tbl["Health"]["<"]["checked"] then
			IsHealth = false;
			local Percentage,Lack
			local Count = 0;
			if tbl.HealthPercentageChecked then
				Percentage = "%";
			else
				Percentage = "1";
			end
			if tbl.LackHealthChecked then
				Lack = 1;
			else
				Lack = 0;
			end
			for k, v in pairs(dots) do
				v.IsHealth = false;
				if v.ok then
					local A,B;
					local Health = aml(v.uId,Percentage,Lack);
					if tbl["Health"]["<"]["checked"] then
						A = Health <= tbl["Health"]["<"]["Value"];
					else
						A = true;
					end
					if tbl["Health"][">"]["checked"] then
						B = Health >= tbl["Health"][">"]["Value"];
					else
						B = true;
					end
					if A and B then
						Count = Count +1;
						v.IsHealth = true;
						v.ok = true;
					else
						v.ok = false;
					end
				end
			end
			IsHealth = Count >0;
		end
		if tbl["NewBuff"]["checked"] then
			for k, v in pairs(dots) do
				if v.ok then
					v.ok= ST.mminimumFast_SpellsRun_buff(unit,tbl["NewBuff"]["buffs"],nil,tbl["NewBuff"]);
					v.IsBuff=v.ok;
				end
			end
		end
		if tbl["Count"][">"]["checked"] or tbl["Count"]["<"]["checked"] then
			local a,b;
			local Count = 0;
			IsCount = false
			for k, v in pairs(dots) do
				v.IsCount = false;
				if v.ok then
					Count = Count +1;
				end
			end
			if tblC["<"]["checked"] then
				a = Count <= tblC["<"]["Value"];
			else
				a = true;
			end
			if tblC[">"]["checked"] then
				b = Count >= tblC[">"]["Value"];
			else
				b = true;
			end
			if not tblC[">"]["checked"] and not tblC["<"]["checked"] then
				IsCount = true;
			else
				IsCount = a and b;
			end
		end
		--print(IsRange , IsCount , IsBuff , IsHealth , IsAngle)
		return IsCount;
	end
	
	function ST.Unit_SpellsRun_2_Cooldown(data,unit) ---技能冷却 函数处理
		local tbl = data["Cooldown"];
		if not (tbl[">"]["checked"] or tbl["<"]["checked"]) then
			return false;
		end
		local Spells = tbl["name"];
		for k, d in pairs(Spells) do
			local v = amcd(d["Name"]);
			if v ~= -1 then
				local a,b;
				if tbl["<"]["checked"] then
					a = v <= tbl["<"]["Value"];
				else
					a = true;
				end
				if tbl[">"]["checked"] then
					b = v >= tbl[">"]["Value"] ;
				else
					b = true;
				end
				return a and b;
			end
		end
		return false;
	end
	
	function ST.Unit_SpellsRun_2_SpecialEnergy(data,unit) ---特殊能量
		local tbl = data["SpecialEnergy"];
		local v = amrs();
		local a,b;
		if tbl["<"]["checked"] then
			a = v <= tbl["<"]["Value"];
		else
			a = true;
		end
		if tbl[">"]["checked"] then
			b = v >= tbl[">"]["Value"] ;
		else
			b = true;
		end
		return a and b and (tbl[">"]["checked"] or tbl["<"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_Distance(data,unit) ---距离 函数处理
		local tbl = data["Distance"];
		local v = amjl(unit);
		local a,b;
		if tbl["<"]["checked"] then
			a = v <= tbl["<"]["Value"];
		else
			a = true;
		end
		if tbl[">"]["checked"] then
			-------------------------------------------------------------------------------
			b = v >= tbl[">"]["Value"] ;
		else
			b = true;
		end
		return a and b and (tbl[">"]["checked"] or tbl["<"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_Energy(data,unit) ---能量 函数处理
		local tbl = data["Energy"];
		local Percentage = tbl["Percentage"];
		local Lack = tbl["Lack"];
		local str;
		local a,b;
		if Lack then
			Lack =1;
		else
			Lack=0;
		end
		if Percentage then
			Percentage ="%";
		else
			Percentage=false;
		end
		if tbl["<"]["checked"] then
			a = amr(unit,Percentage,Lack) <=  tbl["<"]["Value"];
		else
			a = true;
		end
		if tbl[">"]["checked"] then
			b = amr(unit,Percentage,Lack) >=  tbl[">"]["Value"];
		else
			b = true;
		end
		return a and b and (tbl[">"]["checked"] or tbl["<"]["checked"]);
	end
	
	function ST.Unit_SpellsRun_2_IsTarget(data,unit) ---目标函数处理
		local checkedOK =false;
		local tbl = data["IsTarget"]["IsCustomizeTargetToPlayer"];
		local Targets = tbl["Targets"];
		local playerGuid = UnitGUID("player");
		local IsCustomizeTargetToPlayer;
		if tbl["checked"] then
			checkedOK=true;
			for k, d in pairs(Targets) do
				local id = UnitGUID(k .. "-target");
				if id then
					if id == playerGuid then
						IsCustomizeTargetToPlayer = k;
						if tbl["not"] then
							IsCustomizeTargetToPlayer = not IsCustomizeTargetToPlayer;
						end
						break;
					end
				end
			end
			if not IsCustomizeTargetToPlayer then
				return false;
			end
		else
			IsCustomizeTargetToPlayer = true;
		end
		--------------------------------------
		local tbl = data["IsTarget"]["IsDefaultTargetToPlayer"];
		local playerGuid = UnitGUID("player");
		local IsDefaultTargetToPlayer;
		if tbl["checked"] then
			checkedOK=true;
			local id = UnitGUID(unit .. "-target");
			if id then
				if id == playerGuid then
					IsDefaultTargetToPlayer = true;
					if tbl["not"] then
						IsDefaultTargetToPlayer = not IsDefaultTargetToPlayer;
					end
				end
			end
			if not IsDefaultTargetToPlayer then
				return false;
			end
		else
			IsDefaultTargetToPlayer = true;
		end
		--------------------------------------
		local tbl = data["IsTarget"]["IsFocusTargetToPlayer"];
		local playerGuid = UnitGUID("player");
		local IsFocusTargetToPlayer;
		if tbl["checked"] then
			checkedOK=true;
			local id = UnitGUID("focustarget");
			if id then
				if id == playerGuid then
					IsFocusTargetToPlayer = true;
					if tbl["not"] then
						IsFocusTargetToPlayer = not IsFocusTargetToPlayer;
					end
				end
			end
			if not IsFocusTargetToPlayer then
				return false;
			end
		else
			IsFocusTargetToPlayer = true;
		end
		--------------------------------------
		local tbl = data["IsTarget"]["IsMouseoverTargetToPlayer"];
		local playerGuid = UnitGUID("player");
		local IsMouseoverTargetToPlayer;
		if tbl["checked"] then
			checkedOK=true;
			local id = UnitGUID("mouseovertarget");
			if id then
				if id == playerGuid then
					IsMouseoverTargetToPlayer = true;
					if tbl["not"] then
						IsMouseoverTargetToPlayer = not IsMouseoverTargetToPlayer;
					end
				end
			end
			if not IsMouseoverTargetToPlayer then
				return false;
			end
		else
			IsMouseoverTargetToPlayer = true;
		end
		----------------------------
		local tbl = data["IsTarget"]["IsTarget"];
		local Targets = tbl["Targets"];
		local unitname = amGetUnitName(unit,true);
		local IsTarget;
		if tbl["checked"] then
			checkedOK=true;
			if not playerGuid then return false;end;
			for k, d in pairs(Targets) do
				if tbl["Contains"] then
					if k == unitname then
						IsTarget = false;
						break;
					end
				else
					if k == unitname then
						IsTarget = k;
						break;
					end
				end
			end
			if IsTarget == nil then
				return false;
			end
			if tbl["not"] then
				IsTarget = not IsTarget;
			end
			if not IsTarget then
				return false;
			end
		else
			IsTarget = true;
		end
		--------------------------------------
		local tbl = data["IsTarget"]["IsTargetTargetToPlayer"];
		local playerGuid = UnitGUID("player");
		local IsTargetTargetToPlayer;
		if tbl["checked"] then
			checkedOK=true;
			local id = UnitGUID("targettarget");
			if id then
				if id == playerGuid then
					IsTargetTargetToPlayer = true;
					if tbl["not"] then
						IsTargetTargetToPlayer = not IsTargetTargetToPlayer;
					end
				end
			end
			if not IsTargetTargetToPlayer then
				return false;
			end
		else
			IsTargetTargetToPlayer = true;
		end
		return IsCustomizeTargetToPlayer and IsDefaultTargetToPlayer and IsFocusTargetToPlayer and IsMouseoverTargetToPlayer and IsTarget and IsTargetTargetToPlayer and checkedOK;
	end
	
	function ST.Unit_SpellsRun_2_Rune(data,unit) ---符文函数处理
		local checkedok = false;
		local tbl = data["Rune"]["RuneCooldown"];
		local RuneCooldown;
		if tbl["checked"] then
			checkedok = true;
			local checked = false;
			local rune={};
			local rs = tbl[1];
			local cd = amecd(1);
			local v1,v2,v3;
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true;
			end
			if rs[">"]["checked"] then
				checked = true;
				v2 = cd >= rs[">"]["Value"];
			else
				v2 = true;
			end
			if rs["="]["checked"] then
				checked = true;
				v3 = cd == rs["="]["Value"];
			else
				v3 = true;
			end
			rune[1] = v1 and v2 and v3;
			---------------------------------------
			local rs = tbl[2];
			local cd = amecd(2);
			local v1,v2,v3;
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true;
			end
			if rs[">"]["checked"] then
				checked = true;
				v2 = cd >= rs[">"]["Value"];
			else
				v2 = true;
			end
			if rs["="]["checked"] then
				checked = true;
				v3 = cd == rs["="]["Value"];
			else
				v3 = true;
			end
			rune[2] = v1 and v2 and v3;
			-----------------------------------------
			local rs = tbl[3];
			local cd = amecd(3);
			local v1,v2,v3;
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true
			end
			if rs[">"]["checked"] then
				checked = true
				v2 = cd >= rs[">"]["Value"]
			else
				v2 = true
			end
			if rs["="]["checked"] then
				checked = true
				v3 = cd == rs["="]["Value"]
			else
				v3 = true
			end
			rune[3] = v1 and v2 and v3
			----------------------------------
			local rs = tbl[4]
			local cd = amecd(4)
			local v1,v2,v3
			if cd < 0 then cd=0;end;
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true;
			end
			if rs[">"]["checked"] then
				checked = true
				v2 = cd >= rs[">"]["Value"];
			else
				v2 = true
			end
			if rs["="]["checked"] then
				checked = true
				v3 = cd == rs["="]["Value"]
			else
				v3 = true
			end
			rune[4] = v1 and v2 and v3
			RuneCooldown = rune[1] and rune[2] and rune[3] and rune[4] and checked
		else
			RuneCooldown = true
		end
		if checkedok and not RuneCooldown then return false;end;
		----------------------------------------------------------
		local tbl = data["Rune"]["RuneCount"];
		local RuneCount;
		if tbl["checked"] then
			checkedok = true;
			local checked = false;
			local rune={};
			local rs = tbl[1];
			local cd = amen(1);
			local v1,v2,v3;
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true;
			end
			if rs[">"]["checked"] then
				checked = true;
				v2 = cd >= rs[">"]["Value"]
			else
				v2 = true
			end
			if rs["="]["checked"] then
				checked = true
				v3 = cd == rs["="]["Value"]
			else
				v3 = true
			end
			rune[1] = v1 and v2 and v3
			---------------------------------------
			local rs = tbl[2]
			local cd = amen(2)
			local v1,v2,v3
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true
			end
			if rs[">"]["checked"] then
				checked = true
				v2 = cd >= rs[">"]["Value"];
			else
				v2 = true;
			end
			if rs["="]["checked"] then
				checked = true;
				v3 = cd == rs["="]["Value"];
			else
				v3 = true
			end
			rune[2] = v1 and v2 and v3
			-----------------------------------------
			local rs = tbl[3]
			local cd = amen(3)
			local v1,v2,v3
			if rs["<"]["checked"] then
				checked = true
				v1 = cd <= rs["<"]["Value"]
			else
				v1 = true
			end
			if rs[">"]["checked"] then
				checked = true
				v2 = cd >= rs[">"]["Value"]
			else
				v2 = true
			end
			if rs["="]["checked"] then
				checked = true
				v3 = cd == rs["="]["Value"]
			else
				v3 = true
			end
			rune[3] = v1 and v2 and v3
			----------------------------------
			local rs = tbl[4]
			local cd = amen(4)
			local v1,v2,v3
			if cd < 0 then cd=0;end;
			if rs["<"]["checked"] then
				checked = true;
				v1 = cd <= rs["<"]["Value"];
			else
				v1 = true;
			end
			if rs[">"]["checked"] then
				checked = true;
				v2 = cd >= rs[">"]["Value"];
			else
				v2 = true;
			end
			if rs["="]["checked"] then
				checked = true
				v3 = cd == rs["="]["Value"]
			else
				v3 = true
			end
			rune[4] = v1 and v2 and v3
			RuneCount = rune[1] and rune[2] and rune[3] and rune[4] and checked
		else
			RuneCount = true
		end
		return checkedok and RuneCooldown and RuneCount 
	end
	
	function ST.Unit_SpellsRun_2_Totem(data,unit) ---图腾函数处理
		local rs = data["Totem"];
		local v1,v2;
		local checked = false;
		local cd = amtotem(rs["name"]);
		if rs["<"]["checked"] then
			checked = true;
			v1 = cd <= rs["<"]["Value"];
		else
			v1 = true
		end
		if rs[">"]["checked"] then
			checked = true
			v2 = cd >= rs[">"]["Value"]
		else
			v2 = true
		end
		return v1 and v2 and checked;
	end
	
	function amClassToColor(unit) ---图腾函数处理
		
		local color,tc;
		local playerClass, englishClass = UnitClass(unit)
		if englishClass then
			color = RAID_CLASS_COLORS[englishClass]
			tc = CLASS_BUTTONS[englishClass]
			return color,tc;
		end
		return color,tc;
	end
	
	function ST.showruninf(text,unit)
		if text and unit then
			local name = amGetUnitName(unit,true);
			if not name then
				name =unit;
			end
			ST.gospellname=text;
			ST.GospellnameButtontext:SetText(ST.gospellname .. "\n|cffff0000(|cffffff00".. amsubgroup(name) .. "|cffff0000)|r" .. name .. " |cffff0000"..format("%.0f",aml(unit,"%")).."%");
			if WowStHelperFrame then
				WowStHelperFrame.ProjectTitle.Labe2:SetText(ST.gospellname .. "\n|cffff0000(|cffffff00".. amsubgroup(name) .. "|cffff0000)|r" .. name .. " |cffff0000"..format("%.0f",aml(unit,"%")).."%");
			end
			local Color = amClassToColor(unit);
			if Color then
				ST.GospellnameButtontext:SetTextColor(Color.r, Color.g, Color.b);
				if WowStHelperFrame then
					WowStHelperFrame.ProjectTitle.Labe2:SetTextColor(Color.r, Color.g, Color.b);
				end
			end
			ST.gospellnameTime = GetTime();
		end
	end
	
	function ST.mminimumFast_SpellsRun_ApiDbf(data,unit)
		local ApiDbf,con = ST.Unit_SpellsRun_2_ApiDbf(data,unit);
		if con then
			return false;
		end
		if not ApiDbf then
			return ApiDbf;
		end
		return ApiDbf 
	end
	
	function ST.Unit_SpellsRun_2_ApiDbf_Count(data)
		local index=0
		for i, v in pairs(data["ApiDbf"]) do
			if v["checked"] then
				index= index+1;
			end
		end
		return index;
	end
	
	IsLoad_runspell=true;
	print("晋升堡垒加载完成");
	RunScript("print('|cffff0000[晋升堡垒]|r - 启用中...');unitfr=1; function amerr() return 1; end;amUpSpellTbl = am0st;amSpellEmpowerment=amseo;isSuperTreatmentload=true;v_ApiDbfEx=true;v_isok=true;v_nobuff=true;playerrange=true;am_index[3]=100;amIsConnection=true")
	RunScript("")
end

local function LoadClassSpecifitScript()
	RunScript("")
end

function UnlockerInitialize()
	LoadCommonScript()
	LoadClassSpecifitScript()
end