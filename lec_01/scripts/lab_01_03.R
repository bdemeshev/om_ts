# Esli russkie bukvi prevratilitis v krakozyabry, to...
# File - Reopen with encoding... - UTF-8 - Set as default - OK

# Временные ряды. Неделя 1. Скрипт 3.
# STL.

library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(ggrepel)

d = import('marriages_2.csv')
head(d)
glimpse(d)
d = mutate(d, date = yearmonth(date))
marr = as_tsibble(d, index = date, key = c('code', 'name'))
marr

marr_rf = filter(marr, code == 643)
marr_rf %>% gg_tsdisplay(marriages, plot_type = 'season')
stl_model = model(marr_rf, STL(marriages ~ trend(window = 7)
                               + season(window = 1000)))

components(stl_model)

components(stl_model) %>% autoplot()


marr_rf = filter(marr_rf, date < ymd("2021-10-01"))
marr_rf %>% tail()


marr_features = marriage 
%>% features(marriages, 
feat_stl)
marr_features

glimpse(marr_features)

??gg_repel

ggplot(marr_features, aes(x = trend_strength,
                          y = seasonal_strength_year,
                          label = name)) +
  geom_point() + geom_text_repel()


