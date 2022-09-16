library(fpp3) # пакеты для работы с временными рядами

plot_height = 15
plot_width = 20

# 9-006
bank_calls
bc = filter(bank_calls, DateTime < '2003-03-23')
autoplot(bc) + labs(x = NULL, y = NULL, title = NULL)

ggsave("../pictures/om_ts_09-006.png", dpi = 300, width = plot_width, height = plot_height, unit = 'cm')
