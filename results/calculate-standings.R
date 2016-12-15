library(tibble)
library(readr)
library(dplyr)
standings.M <- subset(races.1, select = c("Name.First", "Name.Last", "College")) %>%
  add_column("Race 1" = 101-races.1$Place, .after = "College")

races.1.M.Place <- races.1.M %>%
  select(Name.First,Name.Last, College, Place) %>%
  add_column("Name" = paste0(races.1.M$Name.First,".",races.1.M$Name.Last))
races.2.M.Place <- races.2.M %>%
  select(Name.First,Name.Last, College, Place) %>%
  add_column("Name" = paste0(races.2.M$Name.First,".",races.2.M$Name.Last))

x1 <- full_join(races.1.M.Place,races.2.M.Place, by = "Name")
namesNA <- is.na(x1$Name.First.x)
x1$Name.First.x[namesNA] <- x1$Name.First.y[namesNA]
x1$Name.Last.x[namesNA] <- x1$Name.Last.y[namesNA]
x1$College.x[namesNA] <- x1$College.y[namesNA]

x1.M <- select(x1, -(Name.First.y:College.y)) %>%
      rename(Name.First = Name.First.x,
             Name.Last = Name.Last.x,
             College = College.x,
             Race.1 = Place.x,
             Race.2 = Place.y
             )





x1.M <- select(x1.M, Name, everything())

x1.M <- mutate(x1.M,
               Race.1.Pts = 101-Race.1,
               Race.2.Pts = 101-Race.2)

x1.M <- x1.M %>%
  rowwise() %>%
  mutate(Race.Sum.Pts = sum(Race.1.Pts,Race.2.Pts, na.rm = TRUE))
