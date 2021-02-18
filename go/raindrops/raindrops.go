package raindrops

import "strconv"

func Convert(num int) string {
	output := ""

	if num % 3 == 0 {
		output += "Pling"
	}

	if num % 5 == 0 {
		output += "Plang"
	}

	if num % 7 == 0 {
		output += "Plong"
	}

	if output == "" {
		return strconv.Itoa(num)
	}

	return output
}
