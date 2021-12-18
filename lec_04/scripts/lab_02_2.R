# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 2. Скрипт 2.
# Больше моделей!

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
                    ets_ana = ETS(total ~ error('A') + trend('N') + season('A')),
                    ets_aaa_ln = ETS(log(total) ~ error('A') + trend('A') + season('A')),
                    ets_ana_ln = ETS(log(total) ~ error('A') + trend('N') + season('A'))
                    )

model_table



fcst = forecast(model_table, h = '2 years')
fcst

accuracy(fcst, marr_rf)

model_table2 = mutate(model_table,
              top2 = (snaive + ets_aaa_ln) / 2,
              top3 = (snaive + ets_aaa_ln + ets_aaa) / 3)

fcst = forecast(model_table2, h = '2 years')
fcst

accuracy(fcst, marr_rf)


