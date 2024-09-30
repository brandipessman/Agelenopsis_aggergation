get_predictions <- function(mm) {
  predict(mm, newdata = predictions, re.form = ~0, type = "response")
}