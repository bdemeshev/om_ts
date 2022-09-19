library(tidyverse) # data manipulations
library(rio) # import/export
library(fpp3) # forecasting
aus_production
autoplot(aus_production, Electricity)
aus_train = filter(aus_production, Quarter <= yearquarter('1980Q1'))
autoplot(aus_train, Electricity)
mods = model(aus_train,
ets_aaa = ETS(Electricity ~ error('A') + trend('A') + season('A')),
ets_ana = ETS(Electricity ~ error('A') + trend('N') + season('A')),
snaive = SNAIVE(Electricity),
auto_arima = ARIMA(Electricity),
ets_azz = ETS(Electricity ~ error('A')), # trend = A, Ad, M, Md, N; season = A, M, N
auto_ets = ETS(Electricity),
ets_log = ETS(log(Electricity)))
# github.com/bdemeshev/icef_r4finance_2022
report(mods$ets_aaa[[1]])
fcsts = forecast(mods, h = '4 years')
fcsts
aaa_fcsts = filter(fcsts, .model == 'ets_aaa')
autoplot(aaa_fcsts)
autoplot(aaa_fcsts, aus_train)
report(mods$auto_ets[[1]])
mam_fcsts = filter(fcsts, .model == 'auto_ets')
autoplot(mam_fcsts, aus_train)
aaa_cmpnts = components(mods$ets_aaa[[1]])
aaa_cmpnts
autoplot(aaa_cmpnts)
?decomposition_model
dec_formula = Electricity ~ error('M') + error('A') + season('M')
dec_formula
components(mods$auto_ets[[1]])
mods2 = model(aus_train,
snaive = SNAIVE(Electricity),
dec_model = decomposition_model(ETS(dec_formula),
ARIMA(remainder ~ 0 + pdq(1, 0, 1) + PDQ(0, 0, 0)),
SNAIVE(season),
ETS(level ~ error('M') + trend('A') + season('N')))
)
dec_formula = Electricity ~ error('M') + trend('A') + season('M')
dec_formula
mods2 = model(aus_train,
snaive = SNAIVE(Electricity),
dec_model = decomposition_model(ETS(dec_formula),
ARIMA(remainder ~ 0 + pdq(1, 0, 1) + PDQ(0, 0, 0)),
SNAIVE(season),
ETS(level ~ error('M') + trend('A') + season('N')))
)
mods2 = model(aus_train,
snaive = SNAIVE(Electricity),
dec_model = decomposition_model(ETS(dec_formula)
#      ARIMA(remainder ~ 0 + pdq(1, 0, 1) + PDQ(0, 0, 0)),
#      SNAIVE(season),
#      ETS(level ~ error('M') + trend('A') + season('N'))
))
components(mods$auto_ets[[1]])
mods2 = model(aus_train,
mods2
mods2 = model(aus_train,
snaive = SNAIVE(Electricity),
dec_model = decomposition_model(
STL(Electricity ~ season(window = 10)),
ETS(season_adjust ~ error('M') + trend('A') + season('N')),
SNAIVE(season_year)
))
mods2
report(mods2$dec_model[[1]])
fcst2 = forecast(mods2, h = '4 years')
accuracy(fcsts, aus_production)
accuracy(fcsts, aus_production) %>% arrange(MASE)
accuracy(fcst2, aus_production)
library(tidyverse)
library(rio)
HSAUR::heptathlon
install.packages("HSAUR")
HSAUR::heptathlon
h = HSAUR::heptathlon
glimpse(h)
h
# Handbook of Stat Analysis using R
?HSAUR::heptathlon
cor(h)
library(tidyverse) # data manipulation
library(rio) # data import/export
library(cluster) # :)
library(factoextra) # visualizations for pca, cluster...
library(corrplot) # visualize correlations
corrplot(h)
cor_mat = cor(h) # correlation
corrplot(cor_mat)
corrplot(cor_mat, order = 'hclust')
corrplot(cor_mat, order = 'hclust', addrect = 3)
?corrplot
corrplot(cor_mat, order = 'hclust', addrect = 3)
str(h)
h7 = select(h, -score)
h7
?prcomp
comps = prcomp(h7, scale. = TRUE)
comps
comps$x
fviz_pca_ind(comps)
fviz_pca_ind(comps, repel = TRUE)
fviz_pca_biplot(comps, repel = TRUE)
comps$rotation
corrplot(cor_mat, order = 'hclust', addrect = 3)
fviz_eig(comps)
fviz_eig(comps, addlabels = TRUE)
fviz_contrib(comps, axes = 1, choice = 'var')
# the main plot
fviz_pca_biplot(comps, repel = TRUE)
fviz_contrib(comps, axes = 1, choice = 'var')
# weights of every original variable in principal components
comps$rotation
fviz_eig(comps, addlabels = TRUE)
fviz_contrib(comps, axes = 1, choice = 'var')
fviz_contrib(comps, axes = 1, choice = 'ind')
glimpse(h7)
?kmeans
?mutate
?across
h7scaled = mutate(h7, across(hurdles:run800m), ~ x - mean(x))
h7scaled = mutate(h7, across(hurdles:run800m), ~ . - mean(.))
h7scaled = mutate(h7, across(hurdles:run800m), ~ .x - mean(.x))
h7scaled = mutate(h7, across(hurdles:run800m, ~ .x - mean(.x)))
h7scaled
h7scaled = mutate(h7, across(hurdles:run800m,
~ (.x - mean(.x)) / sd(.x)))
h7scaled
h7scaled
h7_kmeans = kmeans(h7scaled, centers = 3)
h7_kmeans
h7_kmeans
h7_kmeans$cluster
h7_augmented = mutate(h7, cluster = h7_kmeans$cluster)
h7_augmented
fviz_cluster(h7_kmeans)
fviz_cluster(h7_kmeans, data = h7)
fviz_cluster(h7_kmeans, data = h7_scaled)
fviz_cluster(h7_kmeans, data = h7scaled)
fviz_nbclust(h7scaled, kmeans, method = 'wss')
h7dist = dist(h7scaled, method = 'euclidean')
h7dist
fviz_dist(h7dist)
h7hier = hcut(h7dist, k = 4)
h7hier
summary(h7hier)
h7hier$labels
h7hier$cluster
h7_augmented2 = mutate(h7, cluster = h7hier$cluster)
h7_augmented2
fviz_dend(h7hier)
install.packages("xaringan")
library(modeltime)
library(fpp3)
AirPassengers
air = as_tsibble(AirPassengers)
air
air$t = 1:nrow(air)
air
air$ln_pass = log(air$value)
air
?fourfoldplot
gg_tsdisplay(air, ln_pass)
?forecast::fourier
fs = fourier(AirPassengers, K=2)
fs = forecast::fourier(AirPassengers, K=2)
fs
air = bind_cols(air, fs)
air
?add_row
add_row(air)
tibble::add_row(air)
air_more = append_row(air, n = 12)
air_more
air_more %>% tail()
library(xgboost)
library(tidymodels)
library(modeltime)
library(tidyverse)
library(lubridate)
library(timetk)
?plot_time_series
air
plot_time_series(air, index, ln_pass)
air3 = mutate(air, index = ymd(index))
air3 = mutate(air, index = as_date(index))
air3
plot_time_series(air3, index, ln_pass)
plot_time_series(air3, index, ln_pass, .interactive = False)
plot_time_series(air3, index, ln_pass, .interactive = FALSE)
plot_time_series(air3, index, ln_pass, .interactive = TRUE)
plot_time_series(air3, index, ln_pass, .interactive = TRUE, browser= 'FireFox')
plot_time_series(air3, index, ln_pass, .interactive = FALSE)
air_split  = initial_time_split(air3, prop = 0.9)
air_split
[200~model_fit_lm <- linear_reg() %>%
    set_engine("lm") %>%
    fit(value ~ as.numeric(date) + factor(month(date, label = TRUE), ordered = FALSE),
        data = training(air_split
a
lm_fit = linear_reg() %>% set_engine('lm') %>% fit(ln_pass ~ t + `S1-12`+ `C1-12` + `S2-12` + `C2-12`, data = training(air_split))
lm_fit
library(caret)
library(caret)
grid = expan.grid(.mtry = c(2, 4), .min.node.size = c(2, 5))
grid = expand.grid(.mtry = c(2, 4), .min.node.size = c(2, 5))
grid
library(ranger)
install.packages('ranger')
colnames(air)
colnames(air) = c('index', 'value', 't', 'ln_pass', 's1', 'c1', 's2', 'c2')
air
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = gird)
grid
control = trainControl(method = 'cv', number = 5)
?trainControl
control = trainControl(method = 'cv', number = 10)
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = grid, trControl = control)
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = grid, trControl = control, data = air)
grid = expand.grid(mtry=c(2,4), splitrule='rss', min.node.size=c(5, 10))
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = grid, trControl = control, data = air)
air %>% tail()
warnings()
grid = expand.grid(mtry=c(2,4), splitrule='variance', min.node.size=c(5, 10))
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = grid, trControl = control, data = air)
rf
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = grid, trControl = control, data = air, num.trees=1000)
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'ranger', tuneGrid = grid, trControl = control, data = air, num.trees=10000)
fcst = predict(rf, air)
fcst
lm = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'lm', trControl = control, data = air)
lm
install.package('catboost')
install.packages('catboost')
xtree = train(ln_pass ~ t + s1 + c1 + s2 + c2, method = 'xgbTree', trControl = control, data = air)
xtree
fcst = predict(xtree, air)
fcst
air_more
fcst = predict(xtree, air_more)
colnames(air_more)
library(tsibble)
library(tsibbledata)
h = vic_elec
h
h2 = mutate(h, time2 = floor_date(Time, unit = 'day'), time3 = day(Time))
h2
h3 = group_by(h2, time2) %>% summarise(dem = mean(Demand), temp = mean(Temperature), .groups = 'keep')
h3
mutate(h, ddd = as_date(Time))

h4 = mutate(h, ddd = as_date(Time))
h4
h5 = index_by(h, Date) %>% summarise(dem = mean(demand))
h5 = index_by(h, Date) %>% summarise(dem = mean(Demand))
h5
h5
?model
mt = model(arm = ARIMA(dem), data=h5)
?model
mt = model(h5, arm = ARIMA(dem))
?ARIMA
mt = model(h5, arm = ARIMA(dem ~ fourier(2) + PDQ(0, 0, 0))
)
mt = model(h5, arm = ARIMA(dem ~ fourier(K=2) + PDQ(0, 0, 0))
)
mt
mt$arm[[1]]
report(mt$arm[[1]])
mt %>% forecast(h = 24)
tail(h5)
fcsts = mt %>% forecast(h = 24)
autoplot(fcsts)
autoplot(fcsts, h5)
autoplot(fcsts, tail(h5,20))
autoplot(fcsts, tail(h5,100))
autoplot(fcsts, tail(h5,200))
library(ARDL)
install.packages('ARDL')
savehistory('~/Documents/sss.R')
