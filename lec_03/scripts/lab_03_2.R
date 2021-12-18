# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 3. Скрипт 2.
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

rf_train = filter(rf, date < ymd('2019-09-01'))

gg_tsdisplay(rf, total)


mods = model(rf_train,
             snaive = SNAIVE(total),
             theta = THETA(total),
             cpmst = decomposition_model(
               STL(total ~ season(window = Inf)),
               ETS(season_adjust ~ error('A') + trend('Ad') + season('N')),
               SNAIVE(season_year))
             )

mods
report(mods$theta[[1]])
report(mods$cpmst[[1]])



fcst = forecast(mods, h = '2 years')
accuracy(fcst, rf)

