return {
	decode = function(c1, c2, c3)
		local color_to_number = function(color)
			if color == 'black'  then return 0 end
			if color == 'brown'  then return 1 end
			if color == 'red'    then return 2 end
			if color == 'orange' then return 3 end
			if color == 'yellow' then return 4 end
			if color == 'green'  then return 5 end
			if color == 'blue'   then return 6 end
			if color == 'violet' then return 7 end
			if color == 'grey'   then return 8 end
			if color == 'white'  then return 9 end
		end

		local number_to_ohms = function(num)
			if num > 1000 then return num / 1000, "kiloohms" end

			return num, "ohms"
		end

		local n1 = color_to_number(c1)
		local n2 = color_to_number(c2)
		local n3 = color_to_number(c3)

		local ohm_value = (n1 * 10 + n2) * (10^n3)

		return number_to_ohms(ohm_value)
	end,
}
