library(fpp3)
library(bsts)
library(CausalImpact)
library(rio)
library(changepoint)



# bsts 

plot(AirPassengers)
air = log(AirPassengers)

air = log(AirPassengers)

model = list()
model = AddLocalLinearTrend(model, y = air)
# model = AddLocalLevel(model, y = air)
# model = AddSeasonal(model, y = air, nseasons = 12)
model = AddTrig(model, y = air, period = 12, frequencies = 1:2)

posterior = bsts(air, state.specification = model, niter = 200)

plot(posterior, 'components')

fcst = predict(posterior, horizon = 24, burn = 100, quantiles = c(.05, .95))
fcst$mean
plot(fcst)



# causal 

url = 'https://github.com/akarlinsky/world_mortality/raw/main/world_mortality.csv'


mortality = import(url)
glimpse(mortality)

rm = filter(mortality, country_name == 'Russia')
rm2 = mutate(rm, date = yearmonth(paste0(year, '-', time)))
rm3 = dplyr::select(rm2, deaths, date)
rm3
rm_tsibble = as_tsibble(rm3, index = date)
rm_ts = as.ts(rm_tsibble)

rm_tsibble

glimpse(rm_tsibble)
gg_tsdisplay(rm4, deaths)

tail(rm_tsibble, 25)


world_mort

rm = dplyr::filter(world_mort, country_name == 'Russia')
rm
rm2 = mutate(rm, date = ymd(paste0(year, '-', time, '-01')))
rm2

rm3 = dplyr::select(rm2, deaths, date)
rm3

the_date = 61
rm_ts[61]

impact = CausalImpact(data = as.vector(rm_ts), pre.period = c(1, the_date - 1), 
                      post.period = c(the_date, nrow(rm_tsibble)))

plot(impact) 
summary(impact)
summary(impact, 'report')  
 

# strucchange 


plot(rm_ts)


one_break = cpt.mean(rm_ts, method = "AMOC")
one_break
plot(one_break)

rm_tsibble[69, ]

all_breaks = cpt.mean(rm_ts, method = 'BinSeg', Q = 3)
all_breaks

plot(all_breaks)



# anomaly

library(tibbletime)
library(anomalize)


AirPassengers
air = tibble(pass = AirPassengers)
air


air
plot(air)
air_mod = air
air_mod[30] = 6
air_mod[110] = 5
plot(air_mod)


air2 = as_tsibble(air_mod)
air2

air3 = mutate(air2, date = as_date(index))
air3 = as_tibble(air3)
air3 = dplyr::select(air3, -index)


air3 = tibble(value = as.vector(AirPassengers), date = ymd('1949-01-01') + months(0:143))
air3
decomp = time_decompose(air3, target = value)
decomp

anom = anomalize(decomp, target = remainder)
plot_anomalies(anom)

air_recomp = time_recompose(anom)

air_recomp

air_new = clean_anomalies(air_recomp)
anom
plot_anomalies(air_recomp)

plot_anomaly_decomposition(anom)
?time_recompose

glimpse(air_new)
qplot(data = air_new, x = date, y = observed_cleaned)
