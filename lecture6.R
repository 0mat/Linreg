library(dbplyr)
library(readr)

library(dplyr)
library(DBI)

starwars <- read_csv("starwars.csv")
starwars

db <- src_sqlite("star.sqlite", create = TRUE)
copy_to(db, starwars, temporary = FALSE)
db

# Read data (connect to DB)

db <- src_sqlite("star.sqlite", create = FALSE)
starwars_db <- tbl(db, "starwars")

# `dplyr` use lazy evaluation and delays data pulling and processing as much as possible:
starwars_db

# Subset of rows

starwars_db %>% 
  filter(species == "Droid")

starwars_db %>% 
  filter(species == "Droid") %>% 
  show_query()

# Definition of new variable

starwars_db %>% 
  mutate(
    name,
    bmi = mass/((height /100)*(height /100)) # no built-in power function in SQLite
  )

starwars_db %>% 
  mutate(
    name,
    bmi = mass/((height /100)*(height /100)) # no built-in power function in SQLite
  ) %>% 
  show_query()

# Subset of columns

starwars_db %>% 
  select(name, ends_with("color"))

starwars_db %>% 
  select(name, ends_with("color")) %>% 
  show_query()

# Reordering observations

starwars_db %>% 
  arrange(desc(mass))

starwars_db %>% 
  arrange(desc(mass)) %>% 
  show_query()

# Summary statistics by group

starwars_db %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1)

starwars_db %>%
  group_by(species) %>%
  summarise(
    n = n(),
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1) %>% 
  show_query()
