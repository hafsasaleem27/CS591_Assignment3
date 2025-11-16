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

customer_store <- merge(customer, store, by = "store_id")[,
  .(customer_name = paste(first_name, last_name), store_id)]
print(customer_store)

payment_details <- merge(payment, staff, by = "staff_id")[,
  .(payment_id, amount, payment_date, staff_name = paste(first_name, last_name))]
print(payment_details)

rented_film_ids <- unique(merge(inventory, rental, by = "inventory_id")$film_id)
not_rented_films <- film[!film_id %in% rented_film_ids]
print(not_rented_films)

windows()  # open a new graphics device
print(
  ggplot(avg_rental_rate, aes(x = factor(rating), y = avg_rental_rate)) +
    geom_bar(stat = "identity", fill = "skyblue")
)


