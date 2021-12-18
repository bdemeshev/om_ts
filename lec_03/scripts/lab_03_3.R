# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 3. Скрипт 3.
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

m_train = filter(marriages, date < ymd('2019-09-01'))
tail(m_train)


progressr::handlers(global = TRUE)

mods = model(m_train,
             snaive = SNAIVE(total),
             zzz = ETS(log(total)),
             theta = THETA(total))

mods


fcst = forecast(mods, h = '2 years')

acc = accuracy(fcst, marriages)
acc

acc %>% group_by(.model) %>%
  summarize(av_mae = mean(MAE, na.rm = TRUE))


