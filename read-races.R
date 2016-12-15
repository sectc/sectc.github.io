races.count = 9
races.year = 2016

read_race.result <- function(race.year, race.num, female){
  races.x = read_tsv(paste0('results/',race.year,'/race-',race.num,'_',if(female){'F'}else{'M'},'.tsv'), skip = 1,
                     col_names = c('Place',	'Bib',	'Name',	'College',	'Swim.Rank',	'Swim',	
                                   'T1.Rank',	'T1',	'Bike.Rank',
                                   'Bike',	'T2.Rank',	'T2',	'Run.Rank',	'Run',	'Penalty',	'Time',	'DQ'),
                     col_types = cols(
                       'Place' = "n",
                       'Bib'   = "i",
                       'Swim.Rank' = "i",
                       #'Swim'  = col_time(format = '%M:%S'),
                       'T1.Rank' = "i",
                       #'T1' = col_time(format = '%M:%S'),
                       'Bike.Rank' = "i",
                       'Bike' = col_time(format = '%M:%S'),
                       'T2.Rank' = "i",
                       #'T2' = col_time(format = '%M:%S'),
                       'Run.Rank' = "i",
                       'Run' = col_time(format = '%M:%S'),
                       #'Time' = col_time(format = '%T'),
                       .default = "c")
                       )
  #Parse into time
  #
  races.x$Swim <- parse_time(paste0(0,races.x$Swim), format = '%M:%S')
  races.x$T1 <-   parse_time(paste0(0,races.x$T1), format = '%M:%S')
  races.x$T2 <-   parse_time(paste0(0,races.x$T2), format = '%M:%S')
  races.x$Time <- parse_time(str_replace(races.x$Time,'^(\\d\\d:\\d\\d)', '0:\\1'), format = '%T')
  races.x <- races.x %>%
    add_column("Name.First" = str_extract(races.x$Name, '(^\\w+\\b)'), .before = "Name") %>%
    add_column("Name.Last" = str_extract(races.x$Name, '(\\w+\\b$)'), .before = "Name")
  races.x <- within(races.x, rm(Name))
  return(races.x)
}

# Race 1 -----
races.1.M <- read_race.result(2016, 1, F)
# Race 2 ----
races.2.M <- read_race.result(2016, 2, F)
# Race 3_1 Early Bird (x.5) ---- 
races.3_1.M <- read_race.result(2016, '3_1', F)
# Race 3_2 Columbia Downtown Sprint (x.5) ----
races.3_2.M <- read_race.result(2016, '3_2', F) #special
# Race 4 Rocketman ----
races.4.M <- read_tsv(paste0('results/',2016,'/race-',4,'_','M','.tsv'), skip = 1,
                      col_names = c('Place',	'Sexplc', 	'Name',	'Age', 'Swim.Rank',	'Swim',	
                                    'T1',	'Bike.Rank', 'Bike',	'Bike.Pace',
                                    'T2',	'Run.Rank',	'Run',	'Run.Pace',
                                    'Time',		'College', 'Time.Clock',	'Bib', 'Link'),
                      col_types = cols(
                        'Place' = "n",
                        'Bib'   = "i",
                        'Swim.Rank' = "i",
                        'Swim'  = col_time(format = '%M:%S'),
                        #'T1' = col_timeformat = '%M:%S'),
                        'Bike.Rank' = "i",
                        'Bike' = col_time(format = '%T'),
                        #'T2' = col_timeformat = '%M:%S'),
                        'Run.Rank' = "i",
                        #'Run' = col_time(format = '%M:%S'),
                        #'Time' = col_timeformat = '%T'),
                        .default = "c")
                        )
races.4.M$T1 <-   parse_time(paste0(0,races.4.M$T1), format = '%M:%S')
races.4.M$T2 <-   parse_time(paste0(0,races.4.M$T2), format = '%M:%S')
races.4.M$Time <- parse_time(str_replace(races.4.M$Time,'^(\\d\\d:\\d\\d)', '0:\\1'), format = '%T')
races.4.M <- races.4.M %>%
  add_column("Name.First" = str_extract(races.4.M$Name, '(^\\w+\\b)'), .before = "Name") %>%
  add_column("Name.Last" = str_extract(races.4.M$Name, '(\\w+\\b$)'), .before = "Name")
races.4.M <- within(races.4.M, rm(Name))

names_to_ignore <- names(races.1.M) %in% c('T1.Rank', 'T2.Rank', 'Penalty', 'DQ')
races.4.M <- races.4.M[,colnames(races.1.M[,!names_to_ignore])]

# Race 5 Hot Dam ----

# Race 6 Lake Lanier ----

# Race 7 Finale (x2) ----