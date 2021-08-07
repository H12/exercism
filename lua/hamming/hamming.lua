local Hamming = {}

function Hamming.compute(a,b)
	if string.len(a) ~= string.len(b) then return -1 end

	local count = 0

	for i=1,string.len(a) do
		if string.sub(a, i, i) ~= string.sub(b, i, i) then
			count = count + 1
		end
	end

	return count
end

return Hamming
