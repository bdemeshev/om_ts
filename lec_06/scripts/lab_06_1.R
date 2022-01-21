# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 6. Скрипт 1.
# KPSS и ADF тесты

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(urca) # тесты


m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marr_rf = filter(marriages, code == 643)

gg_tsdisplay(marr_rf, total)

res_kpss = ur.kpss(marr_rf$total, type = 'mu')
summary(res_kpss)
# H0: ts = mu + stat
# Ha: ts = mu + stat + rw

# H0 is rejected

res_adf = ur.df(marr_rf$total, type = 'drift',
            selectlags = 'AIC')
summary(res_adf)

# H0: ts = ARIMA(p, 1, q) + trend
# Ha: ts = ARIMA(p, 0, q) + const

# H0 is rejected




