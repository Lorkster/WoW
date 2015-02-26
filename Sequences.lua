local _, Sequences = ... -- Don't touch this

----
-- Rename this file to Sequences.lua before you get started, it uses a different file name so as not to overwrite your existing file with a future update.
-- Every entry in the Sequences table defines a single sequence of macros which behave similarly to /castsequence.
-- Sequence names must be unique and contain no more than 16 characters.
-- To use a macro sequence, create a blank macro in-game with the same name you picked for the sequence here and it will overwrite it.
----

----
-- Here's a large demonstration sequence documenting the format:
Sequences["GnomeExample1"] = {
	-- StepFunction optionally defines how the step is incremented when pressing the button.
	-- This example increments the step in the following order: 1 12 123 1234 etc. until it reaches the end and starts over
	-- DO NOT DEFINE A STEP FUNCTION UNLESS YOU THINK YOU KNOW WHAT YOU'RE DOING
	StepFunction = [[
		limit = limit or 1
		if step == limit then
			limit = limit % #macros + 1
			step = 1
		else
			step = step % #macros + 1
		end
	]],
	
	-- PreMacro is optional macro text that you want executed before every single button press.
	-- This is if you want to add something like /startattack or /stopcasting before all of the macros in the sequence.
	PreMacro = [[
/run print("-- PreMacro Script --")
/startattack	
	]],
	
	-- PostMacro is optional macro text that you want executed after every single button press.
	-- I don't know what you would need this for, but it's here anyway.
	PostMacro = [[
/run print("-- PostMacro Script --")
	]],
	
	-- Macro 1
	[[
/run print("Executing macro 1!")
/cast SpellName1
	]],
	
	-- Macro 2
	[[
/run print("Executing macro 2!")
/cast SpellName2
	]],
	
	-- Macro 3
	[[
/run print("Executing macro 3!")
/cast SpellName3
	]],
}

----
-- Here is a short example which is what most sequences will look like
Sequences["GnomeExample2"] = {	
	-- Macro 1
	[[
/run print("Executing macro 1!")
/cast SpellName1
	]],
	
	-- Macro 2
	[[
/run print("Executing macro 2!")
/cast SpellName2
	]],
	
	-- Macro 3
	[[
/run print("Executing macro 3!")
/cast SpellName3
	]],
}

-- Druid Restoration
Sequences['RestoHeal'] = {
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
]],
	'/castsequence [@focus] reset=15/combat Rejuvenation,Lifebloom,Rejuvenation,Regrowth,Swiftmend',
	'/castsequence Wrath,Wrath,Wrath,Wrath,Wrath,Wrath',
	PostMacro = [[
/cast [@mouseover] Rejuvenation
/cast [combat]Nature's Swiftness
/cast [@focus]Ironbark
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
]],
}

-- Druid Balance
Sequences['Boomy'] = { 
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
/use [noform]!Moonkin Form
]],
"/castsequence reset=25/target Moonfire",
"/castsequence reset=25/target Sunfire",
"/castsequence reset=10 Force of Nature",
"/cast Starsurge",
"/cast Starfire",
"/cast [nochanneling] Wrath",
"/cast Celestial Alignment",
PostMacro = [[
/startattack
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
]],
}

-- Warrior Gladiator
Sequences['GWSTT'] = { 
PreMacro = [[
/console Sound_EnableSFX 0
/cast [harm] Charge; [help] Intervene
/cast [combat] Berserker Rage
/cast [combat] Blood Fury
/cast [combat] Bloodbath
/cast [combat] Demoralizing Shout
/castsequence reset=10 Shield Charge,heroic strike
/cast heroic strike
]],
	'/cast Heroic Strike',
	'/cast Shield Slam',	
	'/cast Revenge',
	'/cast Devastate',
PostMacro = [[
/startattack
/use [combat]13
/use [combat]14
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
]],
}
-- Mage Frost
Sequences['FrostDPS'] = { 
	StepFunction = [[
	 order = newtable(1, 5, 6, 7, 1, 2, 1, 1, 1, 1, 1, 2, 2, 4, 3, 3, 3)
	 
	 newstep = (newstep and (newstep % #order + 1)) or 2
	 step = order[newstep]
	]],

	PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
/cast [nopet] summon water elemental
/petattack [@target,harm]
	]],
	PostMacro = [[
/startattack
/use [combat,nochanneling]13
/use [combat,nochanneling]14
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
	]],
	-- Macro 1 - Main Single Target Sequence For Frostmage
	[[
/castsequence reset=combat/target frostbolt, Frostbolt, Frostbolt, Ice lance, Ice Lance, Ice Lance, Frostfire Bolt',
	]],
	-- Macro 2 - Frostbolt
	[[
/cast Frostbolt
	]],
	-- Macro 3 - Ice Lance
	[[
/cast Ice Lance
	]],
	-- Macro 4 - Frostfire Bolt
	[[
/cast Frostfire Bolt
	]],
	-- Macro 5 - Ice Barrier
	[[
/cast !Ice Barrier
	]],
	-- Macro 6 - Icy Veins
	[[
/cast !Icy Veins
	]],
	-- Macro 7 - Deep Freeze
	[[
/cast Deep Freeze
	]],
}

-- Monk WindWalker
Sequences['wwmonk'] = {
StepFunction = [[
	limit = limit or 1
	if step == limit then
		limit = limit % #macros + 1
		step = 1
	else
		step = step % #macros + 1
	end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
/startattack
]],
	'/castsequence reset=10 [combat] Fists of Fury',
	'/castsequence reset=10 [combat,nochanneling] Chi Wave,Tiger Palm,Rising Sun Kick,Blackout Kick,Jab,Blackout Kick,Jab,Blackout Kick',
	'/cast [combat,nochanneling] Jab',
	'/cast [combat,nochanneling] Blackout Kick',
	'/cast [combat,nochanneling] Rising Sun Kick',
	'/cast [combat,nochanneling] Energizing Brew',
PostMacro = [[
/cast [combat,nochanneling] Invoke Xuen, the White Tiger
/cast [combat,nochanneling] Touch of Death
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
]],
}

Sequences['BrewST'] = {
StepFunction = [[
	limit = limit or 1
	if step == limit then
		limit = limit % #macros + 1
		step = 1
	else
		step = step % #macros + 1
	end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
/startattack
]],
	'/castsequence reset=8 !keg smash,expel harm,jab,jab',
	'/castsequence Blackout Kick, purifying brew, blackout kick,Breath of Fire,blackout kick',
	'/castsequence reset=22 !keg smash,Elusive Brew',
	'/cast tiger palm',
	'/cast !keg smash',
	'/cast Guard',
	'/cast Chi Wave',
	'/cast Jab',
	'/cast Blackout Kick',	
	'/cast Touch of Death',
	[[/cast Invoke Xuen, the White Tiger
]],
PostMacro = [[
/startattack
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
]],
}

-- Paladin Retribution
Sequences['RETPVEST'] = {
StepFunction = [[
limit = limit or 1
if step == limit then
limit = limit % #macros + 1
step = 1
else
step = step % #macros + 1
end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
]],
'/cast Hammer of Wrath',
'/cast Crusader Strike',
'/castsequence [stance: 1] Judgment, seal of righteousness',
'/castsequence [stance: 2] Judgment, seal of truth',
'/cast [stance: 3/4] Judgment',
'/cast Exorcism',
'/cast Execution Sentence',

PostMacro = [[
/cast Templar's Verdict
/cast [combat]Avenging Wrath
/use [combat]13
/use [combat]14
/startattack
/script UIErrorsFrame:Hide();
/console Sound_EnableSFX 1
]],
}

Sequences['RETPVEAE'] = {
StepFunction = [[
limit = limit or 1
if step == limit then
limit = limit % #macros + 1
step = 1
else
step = step % #macros + 1
end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
]],
'/cast Hammer of Wrath',
'/cast Hammer of the Righteous',
'/castsequence [stance: 1] Judgment, seal of righteousness',
'/castsequence [stance: 2] Judgment, seal of truth',
'/cast [stance: 3/4] Judgment',
'/cast Exorcism',
'/cast Execution Sentence',
PostMacro = [[
/cast Divine Storm
/cast [combat]Avenging Wrath
/use [combat]13
/use [combat]14
/startattck
/script UIErrorsFrame:Hide();
/console Sound_EnableSFX 1
]],
}

-- Priest Shadow
Sequences['shadow'] = {
StepFunction = [[
	limit = limit or 1
	if step == limit then
		limit = limit % #macros + 1
		step = 1
	else
		step = step % #macros + 1
	end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
/cast [noform] !Shadowform
]],
	'/castsequence [nochanneling]reset=combat Shadow Word: Pain,Vampiric Touch,Mind Flay,Mind Flay,Mind Flay',
    '/castsequence [nochanneling]reset=combat Mind Blast,Mind Blast,Mind Blast,Devouring Plague,Mind Flay,Mind Flay',
	'/cast [combat,nochanneling]Devouring Plague',
	'/cast [combat,nochanneling]Mind Blast',
	'/cast [combat,nochanneling]Shadowfiend',
	'/cast [combat,nochanneling]Shadow Word: Death',
    '/castsequence [@target] reset=25 cascade',
    '/use [combat,nochanneling] Fade',
PostMacro = [[
/startattack
/use [combat]13
/use [combat]14
/script UIErrorsFrame:Hide();
/console Sound_EnableSFX 1
]],
}

-- Priest Discipline
Sequences['DSTH'] = {
StepFunction = [[
	limit = limit or 1
	if step == limit then
		limit = limit % #macros + 1
		step = 1
	else
		step = step % #macros + 1
	end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/target mouseover
]],
	'/castsequence [nochanneling]Flash Heal, Prayer of Mending, Flash Heal, Flash Heal, Flash Heal, Flash Heal',
	'/cast [@target] Penance',
        '/cast [@target][nochanneling]Power Word: Shield',
	'/cast [nochanneling]!Fade',
	'/cast [nochanneling]Cascade',
PostMacro = [[
/use [combat]13
/use [combat]14
/script UIErrorsFrame:Hide();
/console Sound_EnableSFX 1
]],
}

Sequences['CastAoE'] = {
StepFunction = [[
	limit = limit or 1
	if step == limit then
		limit = limit % #macros + 1
		step = 1
	else
		step = step % #macros + 1
	end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/target mouseover
]],
	'/castsequence [nochanneling]Prayer of Healing, Prayer of Mending, Prayer of Healing, Prayer of Healing, Prayer of Healing',
	'/cast [@target][nochanneling]Power Word: Shield',
	'/cast [nochanneling]Cascade',
	'/cast [nochanneling]Fade',
PostMacro = [[
/use [combat]13
/use [combat]14
/script UIErrorsFrame:Hide();
/console Sound_EnableSFX 1
]],
}

-- Warlock Destruction
Sequences['LockDPS'] = {
PreMacro = [[
#showtooltip Immolate
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
/castsequence [mod:ctrl,combat] Dark Soul: Instability, Blood Fury
/cast [mod:shift,combat] Chaos Bolt
]],
'/castsequence [nomod]reset=target Immolate,Incinerate,Incinerate,Incinerate,Incinerate,Incinerate',
'/cast Conflagrate',
PostMacro = [[
/startattack
/petattack [@target,harm]
/use [combat]13
/use [combat]14
/run UIErrorsFrame:Clear();
/console Sound_EnableSFX 1
]],
}

Sequences['DESTRLOCKPVE'] = {
StepFunction = [[
limit = limit or 1
if step == limit then
limit = limit % #macros + 1
step = 1
else
step = step % #macros + 1
end
]],
PreMacro = [[
/console Sound_EnableSFX 0
/targetenemy [noharm][dead]
]],
'/cast Shadowburn',
'/cast Conflagrate',
'/castsequence reset=target Immolate, Incinerate, Incinerate, Incinerate, Incinerate',

PostMacro = [[
/cast Chaos Bolt
/cast [combat] Dark Soul: Instability
/use [combat]13
/use [combat]14
/script UIErrorsFrame:Hide();
/console Sound_EnableSFX 1
]],
}
