# онлайн магистратура - курс по временным рядам

## план 8 недель

### Неделя 1

* Задачи и данные. 
* Компоненты и слова
* STL
для каждого ряда получим интенсивность
* acf pacf
* белый шум + наивные модели

R: * переводим в tsibble строим графики (отдельно?)
R: * раскладываем на состовляющие
R: * находим характеристики рядов и изображаем их на графике
R: * оцениваем наивные модели

Задачи для одного ряда:Упоминания различных задач и обзор курса:
    * Прогнозирование рядов
    * Обнаружение разладки
    * Кластеризация
    * Разложение ряда на составляющие
* Терминология: тренд, сезонность, цикличность.
* Визуализации

* STL

Характеристики ряда. 

* ACF, PACF — как коэффициенты в регрессиях

Код: нет доски
### Неделя 2. Первые модели

* наивная
* Белый шум
* ETS(ANN)
* ETS(AAN)
* Усреднение моделей
* Точечный и интервальный прогноз
* Обучающая, тестовая и валидационная выборка
* Кросс-валидация




Код: нет доски
### Неделя 3. ETS глубже и дальше 

* Метод максимального правдоподобия.
* на примере наивной модели
* ETS-модель модель без сезонности

### Неделя 4. ETS с сезонностью 

* сезонная наивная модель
* сезонная декомпозиция с помощью ETS
* выбор модели по AIC

### Неделя 5. ARIMA. ARMA модель.

* MA-модель 
* Критерий обратимости уравнения.
* AR-модель 
* Стационарность 

* Подсчёт теоретических ACF/PACF.
* Обратимость

* Правильная теорема о стационарных решениях. 
### Неделя 6. ARIMA. I + сезонность.

* буковка I
* KPSS + ADF
* сезонная ARIMA

### Неделя 7. ARIMA с предикторами.

* Регрессия с ошибками ARIMA
* Тригонометрическая сезонность
* ARDL
### Неделя 8. Автоматизация, комбинирование моделей. 

* Процедура Хандакара Хиндмана. 
* Комбинирование моделей для составляющих ряда.
 
### В этот курс не входят:

* Модели прогнозирования волатильности
* Коинтеграцию
* VAR/SVAR
* нейронные сети

## Источники мудрости:


по R:

https://robjhyndman.com/teaching/

https://otexts.com/fpp3/

https://github.com/rstudio-conf-2020/time-series-forecasting

* Анализ временных рядов с помощью R, Мастицкий С. Э.

Из моделей: bsts, prophet, выделение аномалий, DTW:

https://ranalytics.github.io/tsa-with-r/


Блог Мастицкого:

https://r-analytics.blogspot.com/search/label/%D0%B0%D0%BD%D0%B0%D0%BB%D0%B8%D0%B7%20%D0%B2%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%BD%D1%8B%D1%85%20%D1%80%D1%8F%D0%B4%D0%BE%D0%B2

https://r-analytics.blogspot.com/search/label/Prophet


* Karpov Courses, prophet:

https://www.youtube.com/watch?v=JQXCHE0H46U


это про графики, но оч круто!
https://github.com/rstudio-conf-2020/dataviz


tensorflow probability sts
https://juanitorduz.github.io/intro_sts_tfp/


python:

https://medium.com/tensorflow/structural-time-series-modeling-in-tensorflow-probability-344edac24083

Causal Impact

https://github.com/tcassou/causal_impact


https://www.unofficialgoogledatascience.com/2017/07/fitting-bayesian-structural-time-series.html




Variational Inference, Review for statisticians:
https://arxiv.org/pdf/1601.00670.pdf


Куча ноутбуков по рядам:

https://github.com/ChadFulton/tsa-notebooks



Мёртвый пакет по структурным моделям:
https://github.com/kyleclo/structural



https://towardsdatascience.com/time-series-forecasting-with-statistical-models-in-python-code-da457a46d68a


http://multithreaded.stitchfix.com/blog/2016/04/21/forget-arima/


https://towardsdatascience.com/structural-time-series-forecasting-with-tensorflow-probability-iron-ore-mine-production-897d2334c72b


http://num.pyro.ai/en/latest/tutorials/time_series_forecasting.html
https://cran.r-project.org/web/packages/Rlgt/index.html


https://medium.com/@zhuofanecon/forecast-nonlinear-linear-time-series-in-numpyro-bsgt-example-2c3a0ea7afd2


http://www.stats.uwo.ca/faculty/aim/tsar/tsar.pdf


https://cran.r-project.org/web/packages/dlm/index.html

http://rsta.royalsocietypublishing.org/content/371/1984/20110550.short

https://www.quora.com/How-can-I-learn-Bayesian-time-series-analysis



https://github.com/uber/orbit



https://ocw.mit.edu/courses/economics/14-384-time-series-analysis-fall-2013/lecture-notes/


https://cran.r-project.org/web/packages/forecastML/vignettes/package_overview.html

https://business-science.github.io/modeltime/


https://github.com/awslabs/gluon-ts/


RNN прогнозирование получасового спроса на электричество в R:
https://blogs.rstudio.com/ai/index.html#category:Time_Series



https://github.com/asael697/bayesforecast

https://github.com/asael697/varstan


https://github.com/business-science/modeltime.gluonts


данные с большим количеством нулей: intermittent demand with zeroes
https://stats.stackexchange.com/questions/373689

тест Диболда-Мариано
http://www.phdeconomics.sssup.it/documents/Lesson19.pdf


новый пакет для обработки дат
https://cran.r-project.org/web/packages/clock/vignettes/clock.html

* Посмотреть как реализована сдача домашек через stepik на
"Python для извлечения и обработки данных"
"R для лингвистов: программирование и анализ данных"