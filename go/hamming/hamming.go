package hamming

import "errors"

func Distance(a, b string) (int, error) {
	rune1 := []rune(a)
	rune2 := []rune(b)

	if len(rune1) != len(rune2) {
		return 0, errors.New("provided strings do not have same length")
	}

	count := 0

	for i := 0; i < len(rune2); i++ {
		if rune1[i] != rune2[i] {
			count++
		}
	}

	return count, nil
}
