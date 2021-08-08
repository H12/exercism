local house = {}

house.house = {
	premodifier = 'that lay in',
	noun        = 'the house that Jack built',
}

house.malt = {
	premodifier = 'that ate',
	noun        = 'the malt',
}

house.rat = {
	premodifier = 'that killed',
	noun        = 'the rat',
}

house.cat = {
	premodifier = 'that worried',
	noun        = 'the cat',
}

house.dog = {
	premodifier = 'that tossed',
	noun        = 'the dog',
}

house.cow = {
	premodifier = 'that milked',
	noun        = 'the cow with the crumpled horn',
}

house.maiden = {
	premodifier = 'that kissed',
	noun        = 'the maiden all forlorn',
}

house.man = {
	premodifier = 'that married',
	noun        = 'the man all tattered and torn',
}

house.priest = {
	premodifier = 'that woke',
	noun        = 'the priest all shaven and shorn',
}

house.rooster = {
	premodifier = 'that kept',
	noun        = 'the rooster that crowed in the morn',
}

house.farmer = {
	premodifier = 'that belonged to',
	noun        = 'the farmer sowing his corn',
}

house.horse = {
	premodifier = '',
	noun        = 'the horse and the hound and the horn',
}

house.lines = {
	house.horse,
	house.farmer,
	house.rooster,
	house.priest,
	house.man,
	house.maiden,
	house.cow,
	house.dog,
	house.cat,
	house.rat,
	house.malt,
	house.house,
}

house.verse = function(which)
	local verse = ""

	local start_index = #house.lines - which + 1

	for i=start_index,#house.lines do
		if which > #house.lines then break end

		local line = house.lines[i]

		if i == start_index then
			verse = verse.."This is "..line.noun
		else
			verse = verse..line.premodifier.." "..line.noun
		end

		if i == #house.lines then
			verse = verse.."."
		else
			verse = verse.."\n"
		end
	end

	return verse
end

house.recite = function()
	local poem = ""

	for i=1,#house.lines do
		if i == 1 then
			poem = poem..house.verse(i)
		else
			poem = poem.."\n"..house.verse(i)
		end
	end

	return poem
end

return house
