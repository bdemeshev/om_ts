# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 4. Скрипт 1.
# MA процессы

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

set.seed(777)
data = tibble(y = arima.sim(n = 24, model = list(ma = 0.9)))
data
data$date = yearmonth(ymd('2000-12-01') + months(1:24))
data

data = as_tsibble(data, index = date)

data


gg_tsdisplay(data, y)


ACF(data, y)
ACF(data, y) %>% autoplot()


PACF(data, y)
PACF(data, y) %>% autoplot()


