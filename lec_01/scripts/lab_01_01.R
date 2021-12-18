# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 1.
# Создаём ряд и строим графики.

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов

# создаём ряд с нуля!
n_obs = 120
two_ts = tsibble(date = yearmonth(ymd('2010-04-01') + months(0:(n_obs - 1))),
                 iid = rnorm(n_obs, mean = 10, sd = 2),
                 rwalk = 10 + cumsum(rnorm(n_obs, mean = 0, sd = 1)),
                 index = date)
two_ts
autoplot(two_ts, iid)
autoplot(two_ts, rwalk) + labs(title = 'Случайное блуждание', x = '', y = 'М1 (млрд. тугриков)')

gg_lag(two_ts, iid, period = 1)
gg_lag(two_ts, rwalk, period = 12)


gg_season(two_ts, iid)
gg_season(two_ts, rwalk)

gg_subseries(two_ts, iid)

gg_tsdisplay(two_ts, rwalk, plot_type = 'partial')
gg_tsdisplay(two_ts, rwalk, plot_type = 'season')
gg_tsdisplay(two_ts, rwalk, plot_type = 'scatter')



?yearmonth

# конвертируем из ts в tsibble
LakeHuron
str(LakeHuron)
lake = as_tsibble(LakeHuron)
lake

autoplot(lake, value)

# конвертируем из tsibble в ts

as.ts(two_ts)
