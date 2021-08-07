return {
	decode = function(c1, c2, c3)
		local color_map = {
			black  = 0,
			brown  = 1,
			red    = 2,
			orange = 3,
			yellow = 4,
			green  = 5,
			blue   = 6,
			violet = 7,
			grey   = 8,
			white  = 9
		}

		local ohm_value = (color_map[c1] * 10 + color_map[c2]) * 10^color_map[c3]

		if ohm_value > 1000 then
			return ohm_value / 1000, "kiloohms"
		end

		return ohm_value, "ohms"
	end,
}
