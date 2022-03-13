library(fpp3)
library(caret)
library(ranger)

str(AirPassengers)

air = as_tsibble(AirPassengers)
air
gg_tsdisplay(air)

air2 = mutate(air, 
    ln_pass = log(value),
    t = 1:nrow(air))
air2

fourier_x = 
  forecast::fourier(AirPassengers, K = 2)

fourier_x
# sin(2pi t/12) cos(2pi t/12)  
# sin(2pi t/12 *2) cos(2pi t/12 *2)
colnames(fourier_x) = c('s1', 'c1', 's2', 'c2')

air3 = bind_cols(air2, fourier_x)
air3

tail(air3)

air3test = tail(air3, 24)
air3train = head(air3, -24)

cv_params = trainControl(method = 'cv',
                         number = 5)
ols = train(ln_pass ~ t + s1 + c1 + s2 + c2, 
            data = air3train,
            trControl = cv_params,
            method = 'lm')
rf = train(ln_pass ~ t + s1 + c1 + s2 + c2, 
            data = air3train,
            trControl = cv_params,
            method = 'ranger',
           num.trees = 10000)
gb = train(ln_pass ~ t + s1 + c1 + s2 + c2, 
           data = air3train,
           trControl = cv_params,
           method = 'xgbTree')
ols_fcst = predict(ols, air3test)
rf_fcst = predict(rf, air3test)
gb_fcst = predict(gb, air3test)

air4test = mutate(air3test, 
                  ols = ols_fcst, 
                  rf = rf_fcst,
                  gb = gb_fcst)
glimpse(air4test)

