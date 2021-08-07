local Hamming = {}

function Hamming.compute(a,b)
	if a:len() ~= b:len() then return -1 end

	local dist = 0
	for i=1,a:len() do
		if a:sub(i, i) ~= b:sub(i, i) then
			dist = dist + 1
		end
	end

	return dist
end

return Hamming
