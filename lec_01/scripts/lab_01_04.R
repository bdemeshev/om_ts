# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 4.
# Создание признаков!

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(ggrepel) # симпатичные подписи

m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marr_features = features(marriages, total,
                feat_stl)
glimpse(marr_features)

ggplot(marr_features, aes(x = trend_strength,
              y = seasonal_strength_year,
              label = name)) +
  geom_point() + geom_text_repel()

