library(fpp3) # пакеты для работы с временными рядами

# install.package('devtools')
# devtools::install_github('https://github.com/PedroBSB/mlRFinance')
library(mlRFinance)

n_obs = 100
err_a = rnorm(n_obs, mean = 0, sd = 1)
err_b = rnorm(n_obs, mean = 0.02, sd = 0.5)

?forecast::dm.test

forecast::dm.test(err_a, err_b)

bench = runif(n_obs)
D = matrix(runif(10 * n_obs), ncol = 10)
D

hansen.spa(D, bench, B = 1000)

hansen.spa

