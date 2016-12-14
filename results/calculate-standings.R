library(tibble)
library(readr)

races.count = 9
races.year = 2016
races.1 = read_tsv(paste0('results/',races.year,'/race-',1,'_','M','.tsv'), skip = 1,
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
races.1$Swim <-col_time(parse_time(paste0(0,races.1$Swim), format = '%M:%S'))
