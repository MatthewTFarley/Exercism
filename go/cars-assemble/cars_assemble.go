package cars

// CalculateWorkingCarsPerHour calculates how many working cars are
// produced by the assembly line every hour
func CalculateWorkingCarsPerHour(productionRate int, successRate float64) float64 {
	return float64(productionRate) * (successRate / 100)
}

// CalculateWorkingCarsPerMinute calculates how many working cars are
// produced by the assembly line every minute
func CalculateWorkingCarsPerMinute(productionRate int, successRate float64) int {
	carsPerHour := CalculateWorkingCarsPerHour(productionRate, successRate)
	return int(carsPerHour / minutesPerHour)
}

// CalculateCost works out the cost of producing the given number of cars
func CalculateCost(carsCount int) uint {
	batches, singles := carsCount / batchSize, carsCount % batchSize
	batchesCost := batches * batchCost
	singlesCost := singles * carCost
	return uint(batchesCost + singlesCost)
}

const minutesPerHour = 60
const batchSize = 10
const carCost = 10_000
const batchCost = 95_000
