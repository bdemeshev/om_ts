library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(ggrepel) # симпатичные подписи
library(patchwork) # расположение графиков

setwd("/Users/polinapogorelova/Documents/GitHub/om_ts/data")

m = import('marriages.csv')
glimpse(m)

m2 = mutate(m, date = yearmonth(date))
glimpse(m2)

marriages = as_tsibble(m2, index = date,
                       key = c('code', 'name'))
marriages

marr_rf = filter(marriages, code == 643)

# 1-17. naive season forecast 2 years
train = filter(marr_rf, date < ymd('2020-01-01'))
test =  filter(marr_rf, date >= ymd('2020-01-01'))

model_table = model(train, snaive = SNAIVE(total))
model_table

fcst = forecast(model_table, h = '2 years')
fcst %>% autoplot(marr_rf) + labs(title = "Сезонный наивный прогноз числа свадеб на 2 года", y = "число свадеб", x = NULL)
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-17.png")

# 1-25. близость рядов
marr_features_acf = features(marriages, total,
                             feat_acf)
glimpse(marr_features_acf)
ggplot(marr_features_acf, aes(x = acf1,
                              y = diff1_acf1,
                              label = name)) +
  geom_point() + geom_text_repel() +
  labs(title = "Взаиморасположение регионов России",
       y = "ACF(1) для приращения ряда", x = "ACF(1) для исходного ряда")
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-25.png")

# 1-41. stl разложение
marr_rf = filter(marriages, code == 643)
gg_tsdisplay(marr_rf, total, plot_type = 'season')

head(m_rf)
tail(m_rf)

marr_rf_full = filter(marr_rf, date < ymd('2021-10-01'))
tail(marr_rf_full)

stl_model = model(marr_rf_full,
                  decomp = STL(total ~ trend(window = 100) +
                                 season(window = 5)))
components(stl_model)

components(stl_model) %>%
  pivot_longer(cols = total:remainder, names_to = "component", values_to = "total") %>%
  mutate(component = factor(component, levels = c("total", "trend", "season_year", "remainder"), labels = c("число свадеб, тыс.", "тренд", "сезонность", "остаток"))) %>%
  ggplot(aes(x = date, y = total/1000)) +
  geom_line(na.rm = TRUE) +
  theme_light() +
  facet_grid(vars(component), scales = "free_y") +
  labs(title = "STL разложение числа свадеб в России",
       subtitle = "Число свадеб = тренд + сезонность + остаток",
       y = NULL, x = NULL)
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-41.png")

# 1-74. копия 1-41
components(stl_model) %>%
  pivot_longer(cols = total:remainder, names_to = "component", values_to = "total") %>%
  mutate(component = factor(component, levels = c("total", "trend", "season_year", "remainder"), labels = c("число свадеб, тыс.", "тренд", "сезонность", "остаток"))) %>%
  ggplot(aes(x = date, y = total/1000)) +
  geom_line(na.rm = TRUE) +
  theme_light() +
  facet_grid(vars(component), scales = "free_y") +
  labs(title = "STL разложение числа свадеб в России",
       subtitle = "Число свадеб = тренд + сезонность + остаток",
       y = NULL, x = NULL)
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-74.png")

# 1-120. ACF
p1 <- marr_rf %>% ggplot(aes(x = date, y = total/1000)) +
  geom_line(na.rm = TRUE) +
  theme_light() +
  labs(y = "число свадеб, тыс.", x = NULL)

p2 <- ACF(marr_rf, total) %>% autoplot() + labs(y = "АКФ", x = NULL)
(p1 + p2) + plot_annotation(title = "График числа свадьб в России и АКФ")
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-120.png")

# 1-127. pacf
p3 <- PACF(marr_rf, total) %>% autoplot() + labs(y = "ЧАКФ", x = NULL)
(p1 + p2) + plot_annotation(title = "График числа свадьб в России и ЧАКФ")
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-127.png")


# 1-138, похож на 1-25, только другие feat
marr_features_stl = features(marriages, total,
                         feat_stl) # feat_stl
glimpse(marr_features_stl)
ggplot(marr_features_stl, aes(x = trend_strength,
                          y = seasonal_strength_year,
                          label = name)) +
  geom_point() + geom_text_repel() +
  labs(title = "Взаиморасположение регионов России",
       y = "выраженность сезонности", x = "выраженность тренда")
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-138.png")


# 1-162. наивный сезонный
train = filter(marr_rf, date < ymd('2020-01-01'))
test =  filter(marr_rf, date >= ymd('2020-01-01'))

model_table = model(train, snaive = SNAIVE(total))
model_table

fcst = forecast(model_table, h = '2 years')
fcst %>% autoplot(marr_rf) + labs(title = "Сезонный наивный прогноз числа свадеб на 2 года", y = "число свадеб", x = NULL)
ggsave("/Users/polinapogorelova/Documents/GitHub/om_ts/pictures/1-162.png")

