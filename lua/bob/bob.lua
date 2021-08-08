local bob = {}

function bob.hey(say)
	if say == '' then
		return 'Fine, be that way.'
	end

	local is_yelling  = say == say:upper()
	local is_question = say:sub(#say, #say) == '?'

	if is_question and is_yelling then
		return 'Calm down, I know what I\'m doing!'
	end

	if is_question then
		return 'Sure'
	end

	if is_yelling then
		return 'Whoa, chill out!'
	end

	return 'Whatever'
end

return bob
