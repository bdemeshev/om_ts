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

train = filter(marr_rf, date < yearmonth('2020-10-01'))
test =  filter(marr_rf, date >= yearmonth('2020-10-01'))


# 4-28 Случайное блуждание и случайная выборка
n = 108
data = tsibble(date = yearmonth(ymd('2013-01-01') + months(0:(n - 1))),
               iid = rnorm(n, mean = 10, sd = 4), # модель с независимыми наблюдениями y_t = mu + eps_t
               rwalk = 15 + cumsum(rnorm(n, mean = 0, sd = 2)), # модель случайного блуждания
               index = date)
data

p1 = autoplot(data, rwalk) + labs(x = NULL, y = NULL, title = 'Случайное блуждание')
p2 = autoplot(data, iid) + labs(x = NULL, NULL, title = 'Независимые наблюдения')

p1 + p2  # + plot_annotation(title = "Процесс случайного блуждания и процесс с независимыми наблюдениями")
ggsave("../pictures/om_ts_04-028.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 4-52 обычная и частная корреляции (два угла на графике)


# 4-94 Прогнозы для MA(2)
mod_ma2 = model(train,
                ma2 = ARIMA(total ~ 1 + pdq(0, 0, 2) + PDQ(0, 0, 0)))
mod_ma2

fcst4 = forecast(mod_ma2, h = 12)
fcst4 %>% autoplot(filter(marr_rf, date >= yearmonth('2015-01'))) +
  labs(title = "Прогноз числа свадеб по MA(2)", y = "Число свадеб, тыс.", x = NULL) +
  theme_light()
ggsave("../pictures/om_ts_04-094.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

