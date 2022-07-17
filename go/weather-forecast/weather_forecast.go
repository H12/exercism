// Package weather provides helpful weather-related functions.
package weather

// CurrentCondition represents the current weather condition.
var CurrentCondition string
// CurrentLocation represents the location in which CurrentCondition applies.
var CurrentLocation string

// Forecast provides a human-readable weather forecast when provided a city and
// the current weather condition.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
