# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 1.
# Создаём ряд и строим графики.

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов

# создаём ряд с нуля!
n_obs = 120
set.seed(777) # зерно на удачу
two = tsibble(date = yearmonth(ymd('2010-01-01') + months(0:(n_obs - 1))),
              iid = rnorm(n_obs, mean = 10, sd = 4),
              rwalk = 10 + cumsum(rnorm(n_obs, mean = 0, sd = 1)),
              index = date)
two
autoplot(two, iid)
autoplot(two, rwalk)

gg_season(two, rwalk)
gg_subseries(two, rwalk)

# зависимость текущего значени от лагированных
gg_lag(two, rwalk)
gg_lag(two, iid)

# несколько графиков сразу
gg_tsdisplay(two, rwalk, plot_type = 'season')

# встроенный набор данных по уровню воды в озере Гурон
LakeHuron

# переводим из формата ts в формат tsibble
lake = as_tsibble(LakeHuron)
lake

# переводим из формата tsibble в формат ts
two_old_ts = as.ts(two)
two_old_ts
str(two_old_ts)
