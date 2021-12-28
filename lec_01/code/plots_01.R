library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(ggrepel) # симпатичные подписи
library(patchwork) # расположение графиков

m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marr_features = features(marriages, total,
                feat_acf) # feat_stl,
glimpse(marr_features)


# 1-17. naive season forecast 2 years

# 1-25. близость рядов

# ! взять другие фичи кроме feat_stl

ggplot(marr_features, aes(x = stl_e_acf1,
              y = seasonal_strength_year,
              label = name)) +
  geom_point() + geom_text_repel()

# 1-41. stl разложение
m_rf = filter(marriages, code == 643)
gg_tsdisplay(m_rf, total, plot_type = 'season')

head(m_rf)
tail(m_rf)

m_rf_full = filter(m_rf, date < ymd('2021-10-01'))
tail(m_rf_full)

stl_model = model(m_rf_full,
                  decomp = STL(total ~ trend(window = 100) +
                                 season(window = 5)))
components(stl_model)

components(stl_model) %>% autoplot()

# 1-74. копия 1-41

# 1-120. ACF

ACF(marr_rf, marriages) %>% autoplot()
autoplot(marr_rf, marriages)

gg_tsdisplay(marr_rf, marriages, plot_type = 'partial')


# p1 = график ряда
# p2 = график acf
# p1 | p2 в пнг!

# 1-127. pacf

# как acf


# 1-138, похож на 1-25, только другие feat
ggplot(marr_features, aes(x = trend_strength,
                          y = seasonal_strength_year,
                          label = name)) +
  geom_point() + geom_text_repel()



# 1-162. наивный сезонный


