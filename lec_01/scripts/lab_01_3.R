# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 3.
# STL.

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

m_rf = filter(marriages, code == 643)
gg_tsdisplay(m_rf, total, plot_type = 'season')

head(m_rf)
tail(m_rf)

m_rf_full = filter(m_rf, date < ymd('2021-10-01'))
tail(m_rf_full)

stl_model = model(m_rf_full,
            decomp = STL(total ~ trend(window = 100) +
                         season(window = 5)))
components(stl_model)

components(stl_model) %>% autoplot()


