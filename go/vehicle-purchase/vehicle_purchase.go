package purchase

import (
	"fmt"
	"strings"
)

// NeedsLicense determines whether a license is needed to drive a type of vehicle. Only "car" and "truck" require a license.
func NeedsLicense(kind string) bool {
	return kind == "car" || kind == "truck"
}

// ChooseVehicle recommends a vehicle for selection. It always recommends the vehicle that comes first in dictionary order.
func ChooseVehicle(option1, option2 string) string {
	comparisonResult := strings.Compare(option1, option2)
	var choice string
	if comparisonResult == 1 {
		choice = option2
	} else {
		choice = option1
	}
	return fmt.Sprintf("%s is clearly the better choice.", choice)
}

// CalculateResellPrice calculates how much a vehicle can resell for at a certain age.
func CalculateResellPrice(originalPrice, age float64) float64 {
	var discountRate float64
	if age > 9 {
		discountRate = 0.5
	} else if age > 3 {
		discountRate = 0.7
	} else {
		discountRate = 0.8
	}
	return originalPrice * discountRate
}
