library(fpp3) # пакеты для работы с временными рядами

bank_calls
autoplot(bank_calls)

calls_with_t = mutate(bank_calls, 
              t = row_number())
calls_with_t
calls_tsibble = as_tsibble(calls_with_t, 
              index = t)

calls_tsibble
model = model(calls_tsibble, 
      stl_decom = STL(
        Calls ~ season(period = 169) +
          season(period = 169 * 5)
      ))

cmpts = components(model)

autoplot(cmpts)


