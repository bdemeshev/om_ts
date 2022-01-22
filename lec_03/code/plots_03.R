library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(ggrepel) # симпатичные подписи
library(patchwork) # расположение графиков

# theme_set('light') fails with gg_tsdisplay
plot_height = 15
plot_width = 20

# session - set work directory
# to source file location now (!)
# then use relative path with ..
# it will work on all computers ;)

m = import('../../data/marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marriages = mutate(marriages, total = total / 1000)

marr_rf = filter(marriages, code == 643)



# 3-33
aus = filter(aus_production, Quarter < yearquarter('1981Q1'))
autoplot(aus, Electricity/1000) +
  labs(title = 'Производство электроэнергии в Австралии',
       x = '', y = 'Энергия, терават-часы') +
  theme_light()
ggsave("../pictures/om_ts_03-033.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 3-60
last = filter(marr_rf, date > yearmonth('2011-01'))
autoplot(last, total) + theme_light() +
  labs(title = "Динамика числа свадеб в России", y = "Число свадеб, тыс.", x = NULL)

ggsave("../pictures/om_ts_03-060.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')
