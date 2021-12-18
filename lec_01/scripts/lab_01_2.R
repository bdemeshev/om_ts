# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 2.
# Чистим реальные данные.

# https://fedstat.ru/indicator/33553

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных

d = import('marriages_original.xls')
head(d)

d2 = import('marriages_original.xls', skip = 2)
head(d2)


glimpse(d2)
colnames(d2)[1:3] = c('region', 'unit', 'period')
glimpse(d2)

nchar(unique(d2$period))
nchar()

d3 = filter(d2, nchar(period) < 13)
unique(d3$period)

month_dict = tibble(period = unique(d3$period),
                    month_no = 1:12)
month_dict

d4 = left_join(d3, month_dict, by = 'period')
head(d4)period

d5 = select(d4, -unit, -period)
glimpse(d5)

d6 = pivot_longer(d5, cols = `2006`:`2021`,
                  names_to = 'year',
                  values_to = 'total')
glimpse(d6)


d7 = mutate(d6, date = yearmonth(paste0(year, '-', month_no)))
glimpse(d7)

d8 = separate(d7,
              region,
              into = c('code', 'name'),
              sep = ' ',
              extra = 'merge')
glimpse(d8)

d9 = select(d8, -month_no, -year)

marriages = as_tsibble(d9, index = date, key = c('code', 'name'))

marr_rf = filter(marriages, code == '643')
autoplot(marr_rf)

export(marriages, 'attempt_1.csv')

attempt_1 = import('attempt_1.csv')
glimpse(attempt_1)


marriages_save = mutate(marriages,
                        date = as.Date(date))
marriages_save
export(marriages_save, 'marriages.csv')

