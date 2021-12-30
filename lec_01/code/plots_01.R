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

# 1-17. naive season forecast 2 years
train = filter(marr_rf, date < ymd('2020-01-01'))
test =  filter(marr_rf, date >= ymd('2020-01-01'))

model_table = model(train, snaive = SNAIVE(total))
model_table

fcst = forecast(model_table, h = '2 years')
fcst %>% autoplot(marr_rf) + labs(title = "Сезонный наивный прогноз числа свадеб", y = "Число свадеб, тыс.", x = NULL) +
  theme_light()
ggsave("../pictures/om_ts_01-017.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

# 1-25. близость рядов
marr_features_acf = features(marriages, total,
                             feat_acf)
glimpse(marr_features_acf)
ggplot(marr_features_acf, aes(x = acf1,
                              y = diff1_acf1,
                              label = name)) +
  geom_point() + geom_text_repel() +
  labs(title = "Близость регионов России по динамике числа свадеб",
       y = "ACF(1) для приращения ряда", x = "ACF(1) для исходного ряда") +
  theme_light()
ggsave("../pictures/om_ts_01-025.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

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
  ggplot(aes(x = date, y = total)) +
  geom_line(na.rm = TRUE) +
  theme_light() +
  facet_grid(vars(component), scales = "free_y") +
  labs(title = "STL разложение числа свадеб в России",
       subtitle = "Число свадеб = тренд + сезонность + остаток",
       y = NULL, x = NULL)
ggsave("../pictures/om_ts_01-041.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

# 1-74. копия 1-41
components(stl_model) %>%
  pivot_longer(cols = total:remainder, names_to = "component", values_to = "total") %>%
  mutate(component = factor(component, levels = c("total", "trend", "season_year", "remainder"), labels = c("число свадеб, тыс.", "тренд", "сезонность", "остаток"))) %>%
  ggplot(aes(x = date, y = total)) +
  geom_line(na.rm = TRUE) +
  theme_light() +
  facet_grid(vars(component), scales = "free_y") +
  labs(title = "STL разложение числа свадеб в России",
       subtitle = "Число свадеб = тренд + сезонность + остаток",
       y = NULL, x = NULL)
ggsave("../pictures/om_ts_01-074.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

# 1-120. ACF
p1 <- marr_rf %>% ggplot(aes(x = date, y = total)) +
  geom_line(na.rm = TRUE) +
  theme_light() +
  labs(y = "Число свадеб, тыс.", x = NULL)

p2 <- ACF(marr_rf, total) %>% autoplot() + labs(y = "ACF", x = NULL) + theme_light()
(p1 + p2) + plot_annotation(title = "График числа свадеб в России и ACF")
ggsave("../pictures/om_ts_01-120.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

# 1-127. pacf
p3 <- PACF(marr_rf, total) %>% autoplot() + labs(y = "PACF", x = NULL)  + theme_light()
(p1 + p2) + plot_annotation(title = "График числа свадеб в России и PACF")
ggsave("../pictures/om_ts_01-127.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 1-138, похож на 1-25, только другие feat
marr_features_stl = features(marriages, total,
                         feat_stl) # feat_stl
glimpse(marr_features_stl)
ggplot(marr_features_stl, aes(x = trend_strength,
                          y = seasonal_strength_year,
                          label = name)) +
  geom_point() + geom_text_repel() +
  labs(title = "Близость регионов России по динамике числа свадеб",
       y = "Выраженность сезонности", x = "Выраженность тренда")  + theme_light()
ggsave("../pictures/om_ts_01-138.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

# 1-157 два прогноза
train = filter(marr_rf, date < ymd('2020-01-01'))
test =  filter(marr_rf, date >= ymd('2020-01-01'))

model_table = model(train, naive = NAIVE(total),
                    indep = TSLM(total ~ 1))
model_table

fcst = forecast(model_table, h = '2 years')
p1 = filter(fcst, .model == 'naive') %>% autoplot(marr_rf) + labs(title = "Случайное блуждание", y = "Число свадеб", x = NULL) +
  theme_light() + theme(legend.position = "none")
p1
p2 = filter(fcst, .model == 'indep') %>% autoplot(marr_rf) + labs(title = "Модель независимых наблюдений", y = "Число свадеб", x = NULL) +
  theme_light() + theme(legend.position = "none")
p2
(p1 | p2)
ggsave("../pictures/om_ts_01-157.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')



# 1-162. наивный сезонный
train = filter(marr_rf, date < ymd('2020-01-01'))
test =  filter(marr_rf, date >= ymd('2020-01-01'))

model_table = model(train, snaive = SNAIVE(total))
model_table

fcst = forecast(model_table, h = '2 years')
fcst %>% autoplot(marr_rf) + labs(title = "Сезонный наивный прогноз числа свадеб", y = "Число свадеб, тыс.", x = NULL) +
  theme_light()
ggsave("../pictures/om_ts_01-162.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')

