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

D1. Вывод MaxLik оценки для наивной модели и расчёт AIC.

R1: разница форматов, графики
R2: причёсываем ряд свадеб
R3: STL разложение
R4: изображение множества рядов на плоскости


### Неделя 2. ETS

1. ETS(ANN)

2. ETS(AAN)

D1. Разложение ряда на составляющие по заданной ETS (табличка)

D2. Выписываем функцию правдоподобия ETS как функцию от сигма2

3. ETS(AAA)

4. Усреднение и преобразование

5. Сравнение, кросс-валидация

D3. Кросс валидация для блуждания и независимых. 

R1. Оцениваем сезонную наивную, ETS. 

R2. Усреднение моделей и логарифмирование.

R3. Кросс-валидация растущим окном. 


todo:
отправить слайды 130-138


### Неделя 3. ETS глубже и дальше 

1. Дампированный тренд ETS(AAdN)


2. Мультипликативные эффекты ETS(MNM)

3. Комбинирование эффектов. ETS(MAM)

D2. Считаем Var(y_t) для ETS(ANN), Cov(y_t, y_{t+1}) для него же. 
E(y_t)

D1. Выбор модели по AIC исходя из RSS. 

4. Тета-метод.

R1. Несколько разных ETS, автоматический выбор.

R2. Композитная модель для компонент ряда. STL(ETS(ANN) + SNAIVE)

R3. Оценка моделей для пачки рядов. 



### Неделя 4. Стационарность + MA 

1. Стационарный и нестационарный процесс. 
Сразу Определение автоковариационной функции!
!полностью характеризует процесс, если величины нормально распределены
Rwalk проверяем
Модель независимых наблюдений

D1. Проверяем стационарность, белошумность и независимость ряда
y_i = x_i * (k_i + k_{i-1})


2. ACF и PACF
* Теоретическая ACF для стационарного
* Напоминание о двух вариантах оценивания 
* Частная корреляция 
* Теоретическая PACF для стационарного 
* Напоминание о двух вариантах оценивания 



D3. Считаем общую концепцию pCorr(L, R, S)

3. MA(k) процесс. 
Запись с лагами. 
Стационарность проверяем
Неоднозначность представления (!)
Предъявляем два примера с конкретными цифрами. 


D2. Считаем ACF для MA(1) и МА(2) процесса. 

D4. Считаем PACF для MA(1) процесса. 

4. MA(inf) процесс 
Когда существуют бесконечные суммы?
Стационарность 
Неединственность записи!

5. Условие обратимости уравнения
Зачем? единственность записи при оценивании
Почему именно такое?
Это условие к форме записи (!)
Детали оценивания?



R1. Генерируем машки, смотрим ACF-PACF

R2. STL (MA по AIC + SNAIVE)



### Неделя 5. AR и ARMA

1. ARMA уравнение и критерий несократимости 

Пробуем решить проблему МА(oo): бесконечное число параметров. 

Помним также о проблеме МА "один ряд описывается разными уравнениями".

Добавляем лаги игрека. 

Новая путаница: одно уравнение много решений. 
y_t - y_{t-1} = u_t - u_{t-1}

y_t = u_t + 7 (б шум)

D3. Выписываем лаговый многочлен. 
Проверяем несократимость и обратимость разных записей. 

D4. Делим на лаг и форвард?

1. Структура решений ARMA уравнения

Начальные условия.
Стационарные решения.
Стационарные решения вида MA(oo) относительно (u_t) из уравнения. 

3. Миф про корень уравнения больше 1. 

4. AR-модель и ARMA-модель.

D5.Есть ли стационарное решение и какого оно вида?
два примера! ARMA(2,1), псевдо ARMA(1,1)
вот здесь лаговый и характеристический (!)




D1. Считаем ACF для AR(2) модели. 

D2. Считаем PACF для AR(2) модели. 

R1. Генерируем AR(0.5), AR(0.95), RW, смотрим ACF, строим прогнозы (в том числе и заведомо ложные).

R2. Агрегируем свадьбы, сравниваем AR, MA, и ARMA.


### Неделя 6. ARIMA. I + сезонность.

L1. буковка I

Единичный корень. 
Определение ARIMA(p,d,q) процесса. 
Выбор по графику.

L2. ADF 3 варианта

L3. KPSS 2 варианта

D1. ADF тест пару раз руками

D2. Долгосрочная дисперсия AR(1) и MA(1) процесса. 

D3. KPSS тест пару раз руками.

L3. Cезонная ARIMA

Экономность записи. 
Что можно, а что нельзя подбирать по AIC?

L4. Алгоритм Хандакара-Хиндмана. 


R1. Проводим KPSS и ADF тест на ряду. Делаем вывод о его стационарности. 

R2. Оцениваем заказанную и автоматическую SARIMA
данные по свадьбам 
полностью автоматическая SARIMA по обучающей выборке
несколько фиксированных вариаций и полуавтоматика на скользящем окне

Pad1. Расшифровываем выдачу для SARIMA.
ARIMA(1,1,2)
ARIMA(1,1,2) + включение константы
SARIMA(1,0,1)(1,1,1)[12]



### Неделя 7. Добавляем предикторы


L1. Как обойтись без ARIMA/ETS?
Лаги, агрегирующие функции, скользящее и растущее окно.

L2. У нас ещё есть время!

D1. Доска про дерево?

L3. Лес и бустинг

L4. ARMAX (ARDL) и ARMA в ошибках 

D2. Оценка двух эффектов


R1. Создали предикторы. 
Запустили лес, регрессию и catboost. 

R2. Дневные данные, ARIMA и тригонометрические предикторы. 

R3. ARDL / регрессия с ARMA ошибками

### Неделя 8. Структурные сдвиги и аномалии 


L1. Заполнение пропусков.

L2. Обнаружение выбросов. 

L3. Обнаружение структурного сдвига. 

L4. Байсовский подход и 

L5. структурные модели. 

L6. Оценивание эффекта воздействия. 


R1. Добавим пропуски и заполним их. 

R2. Обнаружение выборосов. 

R3. Обнаружение структурного сдвига 

R4. BSTS 

R5. CausalImpact 



Заполнение пропусков: https://cran.r-project.org/web/packages/imputeTS/index.html

### В этот курс не входят:

* Модели прогнозирования волатильности
* Коинтеграцию
* VAR/SVAR
* нейронные сети


## Random notes

Наблюдаемые ряды и единороги! 
Не вошедший пример:
Y_t = u_t
Y_t = (-1)^t u_t
Y_t = 2 u_t


Не вошло...

Прямая и рекуррентная стратегии прогнозирования.

Тест Диболда-Мариано

[TODO]: UCM?




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



### Монтирование pptx из png
* Запускаем powerpoint
* добавить картинки - новый альбом - выбираем файлы (галочки на каждом НЕ надо ставить! просто insert)
* конструктор (или что там справа от добавить картинки) - устанавливаем формат 4:3. 
При масштабировании фон сам сменится на прозрачный.
* или: Дизайн: размер слайда (справа)
