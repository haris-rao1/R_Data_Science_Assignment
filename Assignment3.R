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
