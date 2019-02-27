-- RotationGeneral
-- Addon for World of Warcraft 3.3.5
-- Written by Geoffrey Balshaw

-- this is the only object the user should change
local priorityList = { -- initially populated with ret spells because I don't know other classes
	"JudgementOfWisdom", -- judgement of wisdom
	"DivineStorm", -- divine storm
	"CrusaderStrike", -- crusader strike
	"HammerofWrath", -- hammer of wrath
	"Consecration", -- consecration
	"Exorcism", -- exorcism
	"DivinePlea", -- divine plea
	
}


function getGCD();
	-- get gcd
	gcdStart, gcdDuration = GetSpellCooldown(Spells.DivinePlea.name) -- uses cleanse as an instant cast to get gcd info
	-- if you're playing a caster class, gcd will be reduced via haste
	-- so change the spell in this argument to some instant cast spell your class has


	if gcdStart > 0 then
		gcd = gcdStart + gcdDuration - ctime
	else
		gcd = 0
	end
end






-- USER SHOULD NOT CHANGE ANYTHING PAST THIS 

local RotationGeneral = LibStub( "AceAddon-3.0" ):NewAddon( "RotationGeneral", "AceConsole-3.0", "AceEvent-3.0" );
local queue = {};

local Spells = { -- this is gonna have to be updated with every single spell in the game which is gonna SUCK
	Stormstrike = {id = 17364, name = GetSpellInfo(17364)},
	LavaLash = {id = 60103, name = GetSpellInfo(60103)},
	EarthShock = {id = 25454, name = GetSpellInfo(25454)},
	MaelstromWeapon = {id = 51532, name = GetSpellInfo(51532)},
	WindfuryWeapon = {id = 25505, name = GetSpellInfo(58804)},
	FlametongueWeapon = {id = 25489, name = GetSpellInfo(58790)},
	LightningBolt = {id = 25449, name = GetSpellInfo(25449)},
	LightningShield = {id = 25472, name = GetSpellInfo(25472)},
	ShamanisticRage = {id = 30823, name = GetSpellInfo(30823)},
	FireElemental = {id = 51533, name = GetSpellInfo(51533)},
	FlameShock = {id = 8050, name = GetSpellInfo(8050)},
	MagmaTotem = {id = 58734, name = GetSpellInfo(58734)},
	FireNova = {id = 61654, name = GetSpellInfo(61654)},
	JudgementOfWisdom = {id = 53408, name = GetSpellInfo(53408)},
	DivineStorm = {id = 53385, name = GetSpellInfo(53385)},
	CrusaderStrike = {id = 35395, name = GetSpellInfo(35395)},
	HammerofWrath = {id = 48806, name = GetSpellInfo(48806)},
	Consecration = {id = 48819, name = GetSpellInfo(48819)},
	Exorcism = {id = 48801, name = GetSpellInfo(48801)},
	DivinePlea = {id = 54428, name = GetSpellInfo(54428)},
}


-- add a spell to the queue
function addToQueue(spell)
	queue[#queue+1] = spell;
end


-- TODO: this assumes you only ever want to cast instants, which is not how most classes work
function isCastable(spellName)
	-- check if you can cast that spell in one gcd
	local _, GCD = gcd
	local _, duration = GetSpellCooldown(spellName);
	return duration == GCD;
end