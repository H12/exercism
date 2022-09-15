package birdwatcher

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	count := 0

	for _, num := range birdsPerDay {
		count += num
	}

	return count
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int {
	upperBound := week * 7
	lowerBound := (week - 1) * 7

	count := 0
	for i, num := range birdsPerDay {
		if i >= lowerBound && i < upperBound {
			count += num
		}
	}

	return count
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	for i := range birdsPerDay {
		if i % 2 == 0 {
			birdsPerDay[i] += 1
		}
	}

	return birdsPerDay
}
