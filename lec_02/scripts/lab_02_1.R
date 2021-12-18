# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 2. Скрипт 1.
# Первые модели!

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marr_rf = filter(marriages, code == 643)

marr_rf %>% gg_tsdisplay(total)

train = filter(marr_rf, date < ymd('2020-01-01'))
test =  filter(marr_rf, date >= ymd('2020-01-01'))

model_table = model(train,
  snaive = SNAIVE(total),
  ets_aaa = ETS(total ~ error('A') + trend('A') + season('A')),
  ets_ana = ETS(total ~ error('A') + trend('N') + season('A')))


model_table

report(select(model_table, ets_aaa))


fcst = forecast(model_table, h = '2 years')
fcst


marr_rf_vis = filter(marr_rf, date >= ymd('2015-01-01'))

fcst_sub = filter(fcst, .model %in% c('snaive', 'ets_aaa'))

autoplot(fcst_sub, marr_rf_vis)




