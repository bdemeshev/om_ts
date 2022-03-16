library(tidyverse) # манипуляции с данными
library(tibbletime) # таблички с рядами
library(anomalize) # выявление аномалий
library(lubridate) # работа с датами
library(changepoint) # выявление структурного сдвига
library(rio)

url = 'https://github.com/akarlinsky/world_mortality/raw/main/world_mortality.csv'

world_mort = import(url)
world_mort

rm = dplyr::filter(world_mort, country_name == 'Russia')
rm
rm2 = mutate(rm, date = ymd(paste0(year, '-', time, '-01')))
rm2

rm3 = dplyr::select(rm2, deaths, date)
rm3

qplot(data = rm3, x = date, y = deaths,
      geom = 'line')

rm4 = as_tbl_time(rm3, index = date)
decomp = time_decompose(rm4, target = deaths)
decomp

rm4$deaths

one_break = cpt.mean(rm4$deaths, 
                     method = 'AMOC')
one_break

decomp[69, ]

plot(one_break)

all_breaks = cpt.mean(rm4$deaths,
                      method = 'BinSeg',
                      Q = 3)
all_breaks

plot(all_breaks)



glimpse(decomp)

one_break_rem = cpt.mean(decomp$remainder, 
                     method = 'AMOC')
one_break_rem

decomp[69, ]

plot(one_break_rem)


