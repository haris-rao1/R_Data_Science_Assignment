install.packages("RMariaDB")
install.packages("data.table", dependencies = TRUE)

library(DBI)
library(RMariaDB)
library(data.table)


#  Connect to  MySQL Workbench database
con <- dbConnect(
  drv = MariaDB(),
  host = "localhost", # same as Workbench
  port = 3306,
  user = "root", # or your MySQL username
  password = "haris", # enter your MySQL password here
  dbname = "sakila" # replace with your schema/database name
)


# Question 1:
film <- as.data.table(dbReadTable(con, "film"))
  
film[(rating=="PG" & rental_duration > 5)]


# Question 2:

film[,.(average_rental_rate=mean(rental_rate)),by=rating]

#Question 3:
film[, .(total_films = .N), by = language_id]

# Question 4
customer <- as.data.table(dbReadTable(con, "customer"))

customer[, .(first_name, last_name, store_id)]

#Question 5
payment <- as.data.table(dbReadTable(con, "payment"))
staff   <- as.data.table(dbReadTable(con, "staff"))

# Join payment with staff using staff_id
result <- payment[
  staff, 
  on = "staff_id", 
  .(amount, payment_date, staff_name = paste(first_name, last_name))
]

result


film <- as.data.table(dbReadTable(con,"film"))
inventory  <- as.data.table(dbReadTable(con,"inventory"))
rental <- as.data.table(dbReadTable(con,"rental"))

# Step 1: film LEFT JOIN inventory
film_inv <- inventory[film, on = .(film_id)]

# Step 2: LEFT JOIN with rental
result <- rental[film_inv, on = .(inventory_id)]


not_rented <- result[is.na(rental_id), .(film_id, title)]

not_rented
