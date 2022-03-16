library(fpp3)
library(bsts)
library(CausalImpact)
library(rio)

url = 'https://github.com/akarlinsky/world_mortality/raw/main/world_mortality.csv'

world_mort = import(url)
world_mort

rm = dplyr::filter(world_mort, 
            country_name == 'Russia')
glimpse(rm)
rm2 = mutate(rm, 
      date = ymd(paste0(year, '-', time, '-01')))
glimpse(rm2)

rm3 = dplyr::select(rm2, deaths, date)
rm3

qplot(data = rm3, x = date, y = deaths, 
      geom = 'line')

start = 61
impact = CausalImpact(
  data = rm3$deaths, 
  pre.period = c(1, start - 1),
  post.period = c(start, nrow(rm3)))


impact

plot(impact)
summary(impact, 'report')

