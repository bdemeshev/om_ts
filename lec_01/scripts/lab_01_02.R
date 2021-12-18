# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 2.
# Чистим реальные данные.

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

d = import('marriages_original.xls')
head(d)

d = import('marriages_original.xls', skip = 2)
colnames(d)[1:3] = c('region', 'unit', 'period')
glimpse(d)

d2 = select(d, -unit)
d3 = filter(d2, nchar(period) < 13)

d3$period %>% unique()

month_dict = tibble(period = unique(d3$period))
month_dict$month = 1:12
month_dict

# join...
# -period

d4 = left_join(d3, month_dict, by = 'period')
glimpse(d4)
?left_join

d5 = pivot_longer(d4, cols = `2006`:`2021`,
                  names_to = 'year',
                  values_to = 'marriages')
glimpse(d5)



d6 = mutate(d5, date = yearmonth(paste0(year, '-', month)))

d6
d7 = select(d6, -period, -month, -year)

d7



d8 = separate(d7,
                 region,
                 into = c('code', 'name'),
                 sep = ' ',
                 extra = 'merge')
d8


marriage = as_tsibble(d8, key = c('code', 'name'), index = date)

group_by_key(marriage) %>% index_by(id = ~ year(.)) %>%
  summarize(n_obs = n())

a = group_by_key(marriage) %>% index_by(id = ~ 1) %>%
  summarize(n_obs = n())

marriage_rf = filter(marriage, code == '643')

autoplot(marriage_rf, marriages)


marr_exp = mutate(as_tibble(marriage), date = as.Date(date))
marr_exp %>% glimpse()
as_tibble(marriage)

export(marr_exp, 'marriages_2.csv')

