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


# 3-19
library(rvest)
url = 'http://sophist.hse.ru/hse/1/tables/POPNUM_Y.htm'
xml_tree = read_html(url)
p1 = html_table(xml_tree)[[1]]
colnames(p1) = c('year', 'total')
p2 = tail(p1, -2)
p3 = head(p2, -4)
p4 = mutate(p3, year = as.numeric(year), total = as.numeric(total) / 1000)
popnum = as_tsibble(p4, index = 'year')
autoplot(popnum, total)

mods = model(popnum,
        aadn = ETS(total ~ error('A') + trend('Ad') + season('N')))
fcst = forecast(mods, h = '12 years')
autoplot(fcst, popnum) + theme_light() + labs(x = NULL, y = 'Население, млн. человек', title = 'ETS(AAdN): прогноз численности населения России')
ggsave("../pictures/om_ts_03-019.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 3-33
aus = filter(aus_production, Quarter < yearquarter('1981Q1'))
autoplot(aus, Electricity/1000) +
  labs(title = 'Производство электроэнергии в Австралии',
       x = '', y = 'Энергия, терават-часы') +
  theme_light()
ggsave("../pictures/om_ts_03-033.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')


# 3-47

aus = filter(aus_production, Quarter < yearquarter('1981Q1'))
aus = mutate(aus, Electricity = Electricity / 1000)
aus_left = filter(aus, Quarter < yearquarter('1968Q1'))
m_left = model(aus_left,
               mnm = ETS(Electricity ~ error('M') + trend('N') + season('M')))
m_full = model(aus,
               mnm = ETS(Electricity ~ error('M') + trend('N') + season('M')))
f_left = forecast(m_left, h = '5 years')
f_full = forecast(m_full, h = '5 years')

autoplot(f_left, aus)

autoplot(f_full, aus) + autoplot(f_left, aus)
f_left
f_full

f_mid = tibble(.model = 'mnm', Electricity = NA, .mean = NA,
               Quarter = yearquarter(ymd('1973-1-1') + months(seq(0, 83, by = 3))))


f_join = bind_rows(as_tsibble(f_left), f_mid, as_tibble(f_full))
f_join = as_tsibble(f_join, index = Quarter, key = .model)
f_join = as_fable(f_join, distribution = 'Electricity', response = 'Electricity')
f_join


autoplot(f_join, aus) +
  labs(title = 'ETS(MNM): производство электроэнергии в Австралии',
       x = '', y = 'Энергия, терават-часы') +
  theme_light() + theme(legend.position = "none")

ggsave("../pictures/om_ts_03-047.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')



# 3-60
last = filter(marr_rf, date > yearmonth('2011-01'))
autoplot(last, total) + theme_light() +
  labs(title = "Динамика числа свадеб в России", y = "Число свадеб, тыс.", x = NULL)

ggsave("../pictures/om_ts_03-060.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')
