# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 3. Скрипт 1.
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


rf = filter(marriages, code == 643)

gg_tsdisplay(rf, total)

tail(rf)

rf_train = filter(rf, date < ymd('2019-09-01'))
tail(rf_train)

mods = model(rf_train,
      snaive = SNAIVE(total),
      ana = ETS(total ~ error('A') + trend('N') + season('A')),
      aada = ETS(total ~ error('A') + trend('Ad') + season('A')),
      zzz = ETS(total),
      azz = ETS(total ~ error('A')),
      theta = THETA(total)
)
mods


report(mods$zzz[[1]])
report(mods$theta[[1]])


fcst = forecast(mods, h = 24)

accuracy(fcst, rf)


