const HOURS_IN_DAY = 8;
const BILLABLE_DAYS_IN_FULL_MONTH = 22;

/**
 * The day rate, given a rate per hour
 *
 * @param {number} ratePerHour
 * @returns {number} the rate per day
 */
export function dayRate(ratePerHour) {
  return ratePerHour * HOURS_IN_DAY;
}

/**
 * Calculates the number of days in a budget, rounded down
 *
 * @param {number} budget: the total budget
 * @param {number} ratePerHour: the rate per hour
 * @returns {number} the number of days
 */
export function daysInBudget(budget, ratePerHour) {
  return Math.floor(budget / dayRate(ratePerHour));
}

/**
 * Calculates the discounted rate for large projects, rounded up
 *
 * @param {number} ratePerHour
 * @param {number} numDays: number of days the project spans
 * @param {number} discount: for example 20% written as 0.2
 * @returns {number} the rounded up discounted rate
 */
export function priceWithMonthlyDiscount(ratePerHour, numDays, discount) {
  const fullMonths = Math.floor(numDays / BILLABLE_DAYS_IN_FULL_MONTH);
  const numFullPriceDays = numDays % BILLABLE_DAYS_IN_FULL_MONTH;
  const numDiscountedDays = fullMonths * BILLABLE_DAYS_IN_FULL_MONTH;
  const discountedRatePerHour = ratePerHour * (1 - discount);
  const discountedDayRate = dayRate(discountedRatePerHour);
  const fullDayRate = dayRate(ratePerHour);
  const fullPrice = fullDayRate * numFullPriceDays;
  const discountedPrice = discountedDayRate * numDiscountedDays;
  const totalPrice = Math.ceil(fullPrice + discountedPrice);
  return totalPrice;
}
