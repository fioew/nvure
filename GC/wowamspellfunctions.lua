local spellinf = wowam.spell.Info;
local Spell = {};
local Buff = {};

local IsSpell = {};  
local RaidSpell={};
local SpellId={};

local GetSpellInfo = C_Spell.GetSpellInfo
--���������⼼��̎��

Spell["Ѹ������"] = 	GetSpellInfo(18562);
Spell["����"] = 	GetSpellInfo(8936);
Buff["����"] = 	GetSpellInfo(8936);
Spell["�ش��g"] = 	GetSpellInfo(774);
Buff["�ش��g"] = 	GetSpellInfo(774);

IsSpell[Spell["Ѹ������"]]=1;
IsSpell[Spell["����"]]=1;
IsSpell[Spell["�ش��g"]]=1;
Spell["�����g����"] = 	GetSpellInfo(17);

SpellId["�}���g:�l"] = 88625;
SpellId["�}���g:��"] = 88682;
SpellId["�}���g:��"] = 88685;
SpellId["�}���g:��"] = 88684;

Spell["�}���g:�l"] = GetSpellInfo(88625);
Spell["�}���g:��"] = GetSpellInfo(88682);
Spell["�}���g:��"] = GetSpellInfo(88685);
Spell["�}���g:��"] = GetSpellInfo(88684);

Buff["�}݆�\�D:�֏�"] = GetSpellInfo(81207);
Buff["�}݆�\�D:�ί��\��"] = GetSpellInfo(81206);
Buff["�}݆�\�D:�ί��g"] = GetSpellInfo(81208);

SpellId["�ͳ�"] = 6572;
SpellId["����"] = 7384;




wowam.SpecialSpellIsTarge={};
--�C�����⼼��̎��
wowam.SpecialSpellIsTarge[GetSpellInfo(34026)] = 1	;  --��¾����

--ʩ��Ŀ�����ͣ���/��/���ˣ��ļ��� ��=3,��=2,����=1
RaidSpell[Spell["�����g����"]]=3;


--������Ҫ�����ж�
IsPowerCost[Spell["����������"]]=true;


function amSpellIsPowerCost(spell)
	return IsPowerCost[spell];
end


function amSpellSpecial(name,unit,gcd)
	--name = GetSpellInfo(name);
	name = wowam.spell.Property[name]["spellname"] ;
	if not IsSpell[name] then
		return nil;
	end
	
	if name == Spell["Ѹ������"] then
		return amQuickcure(name,unit,gcd);
	end
end

function amQuickcure(name,unit,gcd)
	if (amaura(Buff["�ش��g"],unit)>0 or amaura(Buff["����"],unit)>0) then
		--local _, _, _, powerCost = GetSpellInfo(name);
		powerCost = wowam.spell.Property[name]["powerCost"] ;
		if amr("player") >= powerCost  then
			return name;
		end
	end
end

function amIsRaidSpell(spell)
	return RaidSpell[spell];
end
