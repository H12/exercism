package hamming

import (
	"errors"
	"unicode/utf8"
)

func Distance(a, b string) (int, error) {
	len1 := utf8.RuneCountInString(a)
	len2 := utf8.RuneCountInString(b)

	if len1 != len2 {
		return 0, errors.New("provided strings do not have same length")
	}

	count := 0

	for i := 0; i < len1; i++ {
		if a[i] != b[i] {
			count++
		}
	}

	return count, nil
}
