library(tidyverse) # манипуляции с данными
library(tibbletime) # таблички с рядами
library(anomalize) # выявление аномалий
library(lubridate)

AirPassengers

air = tibble(pass = AirPassengers)
air

n = nrow(air)
air2 = mutate(air, date = ymd('1949-01-01') +
                months(0:(n - 1)))
air2

qplot(data = air2, x = date, y = pass, geom = 'line')

air3 = mutate(air2, ln_pass = log(pass))
air3

qplot(data = air3, x = date, y = ln_pass, geom = 'line')

air4 = mutate(air3, ln_pass_an = ln_pass)
air4$ln_pass_an[30] = 6
air4$ln_pass_an[110] = 5.3

qplot(data = air4, x = date, y = ln_pass_an, geom = 'line')

decomp = time_decompose(air4, target = ln_pass_an)

decomp

decomp2 = anomalize(decomp, target = remainder)

glimpse(decomp2)

plot_anomalies(decomp2)

decomp3 = time_recompose(decomp2)
glimpse(decomp3)

plot_anomaly_decomposition(decomp2)

decomp4 = clean_anomalies(decomp3)

glimpse(decomp4)

qplot(data = decomp4, x = date, 
  y = observed_cleaned, geom = 'line')
