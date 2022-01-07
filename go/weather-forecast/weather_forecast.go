// Package weather contains weather functionality.
package weather

// CurrentCondition variable is a string that holds the current weather condition.
var CurrentCondition string
// CurrentLocation variable is a string that holds the current location.
var CurrentLocation string

// Forecast functin is a function that takes the city and the condition and returns a forecast string.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
