# онлайн магистратура - курс по временным рядам

## план 8 недель

### Неделя 1

1. Задачи и данные. 
Упоминания различных задач и обзор курса.

Задачи для одного ряда
    * Прогнозирование рядов
    * Обнаружение разладки
    * Разложение ряда на составляющие
Задачи для множества рядов
    * Кластеризация

2. Компоненты и слова

Терминология: тренд, сезонность, цикличность.
3. STL

4. acf pacf

STL характеристики ряда. 

ACF, PACF — как коэффициенты в регрессиях

5. белый шум + наивные модели

R: * переводим в tsibble строим графики (отдельно?)
R: * раскладываем на состовляющие
R: * находим характеристики рядов и изображаем их на графике
R: * оцениваем наивные модели


### Неделя 2. ETS

1. ETS(ANN)

2. ETS(AAN)

3. ETS(AAA)

4. Усреднение и преобразование

5. Сравнение, кросс-валидация


* Обучающая, тестовая и валидационная выборка
* Кросс-валидация


### Неделя 3. ETS глубже и дальше 

1. Дампированный тренд ETS(AAdN)

2. Мультипликативные эффекты ETS(MNM)

3. Комбинирование эффектов. ETS(MAM)

4. Тета-метод.

R1. Несколько разных ETS, автоматический выбор.

R2. Композитная модель для компонент ряда. STL(ETS(ANN) + SNAIVE)

R3. Оценка моделей для пачки рядов. 

D1. Выбор модели по AIC исходя из RSS. 

D2. Считаем Var(y_t) для ETS(ANN), Cov(y_t, y_{t+1}) для него же. 
E(y_t)
### Неделя 4. Стационарность + MA 

1. Стационарный и нестационарный процесс. 
Сразу Определение автоковариационной функции!
!полностью характеризует процесс, если величины нормально распределены
Rwalk проверяем
Модель независимых наблюдений

2. ACF и PACF
* Теоретическая ACF для стационарного
* Напоминание о двух вариантах оценивания 
* Частная корреляция 
* Теоретическая PACF для стационарного 
* Напоминание о двух вариантах оценивания 

3. MA(k) процесс. 
Запись с лагами. 
Стационарность проверяем
Неоднозначность представления (!)
Предъявляем два примера с конкретными цифрами. 

4. MA(inf) процесс 
Когда существуют бесконечные суммы?
Стационарность 
Неединственность записи!

5. Условие обратимости уравнения
Зачем? единственность записи при оценивании
Почему именно такое?
Это условие к форме записи (!)
Детали оценивания?


D1. Проверяем стационарность, белошумность и независимость ряда
y_i = x_i * (k_i + k_{i-1})

D2. Считаем ACF для MA(1) и МА(2) процесса. 

D3. Считаем общую концепцию pCorr(L, R, S)

D4. Считаем PACF для MA(1) процесса. 

R1. Генерируем машки, смотрим ACF-PACF

R2. STL (MA по AIC + SNAIVE)

### Неделя 5. AR 

1. Большая путаница!
Наблюдаемые ряды и единороги! 

Пример:
Y_t = u_t
Y_t = (-1)^t u_t
Y_t = 2 u_t

обозначаем по-разному!
противоречие исчезло

Источник путаницы:
один ряд — несколько разных уравнений!
одно уравнение — несколько разных решений!
y_t - y_{t-1} = u_t - u_{t-1}

y_t = u_t (б шум)
y_t = u_t + u_{t-1} (ma(1))
y_t = u_t + u_{t-1} + u_{t-2} (ma(2))



2. AR(p) уравнение и множество решений. 
Сколько стационарных решений?
Сколько нестационарных решений?
Какой вид имеют стационарные решения?

3. AR(p) процесс (модель).
Если его можно (можно!) записать в виде

4. ARMA-уравнение, ARMA-модель.

5. Вариативность определения у разных авторов. 

D1. Считаем ACF для AR(2) модели. 

D2. Считаем PACF для AR(2) модели. 



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