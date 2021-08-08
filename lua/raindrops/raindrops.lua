return function(n)
	local raindrop = ''

	if n % 3 == 0 then
		raindrop = raindrop..'Pling'
	end

	if n % 5 == 0 then
		raindrop = raindrop..'Plang'
	end

	if n % 7 == 0 then
		raindrop = raindrop..'Plong'
	end

	if raindrop == '' then
		return tostring(n)
	end

	return raindrop
end
