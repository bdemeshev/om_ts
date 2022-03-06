library(tidyverse) # обработка данных
library(fpp3) # куча плюшек для рядов
library(rio) # импорт данных
library(ggrepel) # симпатичные подписи
library(patchwork) # расположение графиков
library(latex2exp)

# theme_set('light') fails with gg_tsdisplay
plot_height = 15
plot_width = 20

# 27 - четыре небольших графика на одном слайде
n_obs = 100
t = 1:n_obs
mu = 5 + 0.2*t

set.seed(999)

data = tsibble(date = yearmonth(ymd('2015-01-01') + months(0:(n_obs - 1))),
               x = rnorm(n_obs, mean = 10, sd = 4),
               y = 15 + cumsum(rnorm(n_obs, mean = 0, sd = 2)),
               z = mu + rnorm(n_obs, mean = 0, sd = 2),
               w = 2 + cumsum(rnorm(n_obs, mean = 0, sd = 5)),
               index = date)

p1 = autoplot(data,x) + labs(x = " ")
p2 = autoplot(data,y) + labs(x = " ")
p3 = autoplot(data,z) + labs(x = " ")
p4 = autoplot(data,w) + labs(x = " ")
(p1 + p2) / (p3 + p4)

ggsave("../pictures/om_ts_06-027.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 46 - ADF с константой
set.seed(999)

data2 = tibble(h0 = mu + cumsum(arima.sim(n = n_obs, model = list(ar = c(0.1)))),
               ha = 2 + arima.sim(n = n_obs, model = list(ar = c(0.1, 0.2)))
)
data2$date = yearmonth( ymd('2010-01-01') + months(0:(n_obs-1)))
data2 = as_tsibble(data2, index = date)

pic1 = data2 %>%
  autoplot(h0) + labs(x = latex2exp::TeX("$H_0$"), y = "")

pic2 = data2 %>%
  autoplot(ha) + labs(x = latex2exp::TeX("$H_a$"), y = "")

pic1 + pic2 + plot_annotation("ADF с константой")
ggsave("../pictures/om_ts_06-046.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 55 - ADF без константы
set.seed(999)

data3 = tibble(h0 = 2 + cumsum(arima.sim(n = n_obs, model = list(ar = c(0.1)))),
               ha = arima.sim(n = n_obs, model = list(ar = c(0.1, 0.2)))
)
data3$date = yearmonth( ymd('2010-01-01') + months(0:(n_obs-1)))
data3 = as_tsibble(data3, index = date)

pic11 = data3 %>%
  autoplot(h0) + labs(x = latex2exp::TeX("$H_0$"), y = "")

pic22 = data3 %>%
  autoplot(ha) + labs(x = latex2exp::TeX("$H_a$"), y = "")

pic11 + pic22 + plot_annotation("ADF без константы")
ggsave("../pictures/om_ts_06-055.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 60 - ADF с трендом
set.seed(999)
mu0 = 3 + 0.01*t + 0.004*t^2
mua = 0.2 + 0.05*t
data4 = tibble(h0 = mu0 + cumsum(arima.sim(n = n_obs, model = list(ar = c(0.1)))),
               ha = mua + arima.sim(n = n_obs, model = list(ar = c(0.1, 0.2)))
)
data4$date = yearmonth(ymd('2010-01-01') + months(0:(n_obs-1)))
data4 = as_tsibble(data4, index = date)

pic111 = data4 %>%
  autoplot(h0) + labs(x = latex2exp::TeX("$H_0$"), y = "")

pic222 = data4 %>%
  autoplot(ha) + labs(x = latex2exp::TeX("$H_a$"), y = "")

pic111 + pic222 + plot_annotation("ADF с трендом")
ggsave("../pictures/om_ts_06-060.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 77 - KPSS с константой
set.seed(999)

data5 = tibble(h0 = 2 + rnorm(n_obs, mean = 0, sd = 4),
               ha = 2 + rnorm(n_obs, mean = 0, sd = 4) + cumsum(rnorm(n_obs, mean = 0, sd = 2)))
data5$date = yearmonth(ymd('2010-01-01') + months(0:(n_obs-1)))
data5 = as_tsibble(data5, index = date)

g1 = data5 %>%
  autoplot(h0) + labs(x = latex2exp::TeX("$H_0$"), y = "")

g2 = data5 %>%
  autoplot(ha) + labs(x = latex2exp::TeX("$H_a$"), y = "")

g1 + g2 + plot_annotation("KPSS с константой")
ggsave("../pictures/om_ts_06-077.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 86 - KPSS с трендом
set.seed(999)

mu0 = 3 + 0.2*t
data6 = tibble(h0 = mu0 + rnorm(n_obs, mean = 0, sd = 4),
               ha = mu0 + rnorm(n_obs, mean = 0, sd = 4) + cumsum(rnorm(n_obs, mean = 0, sd = 2)))
data6$date = yearmonth(ymd('2010-01-01') + months(0:(n_obs-1)))
data6 = as_tsibble(data6, index = date)

g11 = data6 %>%
  autoplot(h0) + labs(x = latex2exp::TeX("$H_0$"), y = "")

g22 = data6 %>%
  autoplot(ha) + labs(x = latex2exp::TeX("$H_a$"), y = "")

g11 + g22 + plot_annotation("KPSS с трендом")
ggsave("../pictures/om_ts_06-086.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')
