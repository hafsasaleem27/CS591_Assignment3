install.packages("data.table")
library(data.table)

film <- fread("data/film.csv")
language <- fread("data/language.csv")
customer <- fread("data/customer.csv")
store <- fread("data/store.csv")
staff <- fread("data/staff.csv")
rental <- fread("data/rental.csv")
inventory <- fread("data/inventory.csv")
payment <- fread("data/payment.csv")

pg_films <- film[rating == "PG" & rental_duration > 5]
print(pg_films)

avg_rental_rate <- film[, .(avg_rental_rate = mean(rental_rate, na.rm = TRUE)), by = rating]
print(avg_rental_rate)

film_language_count <- merge(film, language, by.x = "language_id", by.y = "language_id")[,
  .(total_films = .N), by = name]
print(film_language_count)


