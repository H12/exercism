package twofer

// ShareWith returns the string "One for you, one for me.", replacing "you" with an optional `name` argument
func ShareWith(name string) string {
	if (len(name) == 0) {
		name = "you"
	}

	return "One for " + name + ", one for me."
}
