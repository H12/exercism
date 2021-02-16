package hamming

import (
	"errors"
)

func minDiff(a, b int) (int, int) {
	if a < b {
		return a, b - a
	}
	return b, a - b
}

func Distance(a, b string) (int, error) {
	min, diff := minDiff(len(a), len(b))

	if diff != 0 {
		return 0, errors.New("error")
	}

	for i := 0; i < min; i++ {
		if a[i] != b[i] {
			diff = diff + 1
		}
	}

	return diff, nil
}
