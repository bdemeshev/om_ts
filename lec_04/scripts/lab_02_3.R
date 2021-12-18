# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 2. Скрипт 3.
# Кросс-валидация

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


nrow(marr_rf)
tail(marr_rf)

marr_stretch = stretch_tsibble(marr_rf,
                .init = 170, .step = 1)

marr_stretch


model_table = model(marr_stretch,
                    snaive = SNAIVE(total),
                    ets_aaa = ETS(total ~ error('A') + trend('A') + season('A')),
                    ets_ana = ETS(total ~ error('A') + trend('N') + season('A')),
                    ets_aaa_ln = ETS(log(total) ~ error('A') + trend('A') + season('A')),
                    ets_ana_ln = ETS(log(total) ~ error('A') + trend('N') + season('A'))
)

model_table

fcst = forecast(model_table, h = 1)

accuracy(fcst, marr_rf)

model_table2 = mutate(model_table,
                      top2 = (ets_aaa_ln + ets_ana_ln) / 2)

fcst = forecast(model_table2, h = 1)

accuracy(fcst, marr_rf)



