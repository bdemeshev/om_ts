01_01

\begin{frame}{Прогнозируем}
    картинка с наивным сезонным прогнозом
\end{frame}

\begin{frame}{Измеряем близость рядов}
  картинка с измерением близости
\end{frame}

01_02

\begin{frame}{Тренд, сезонность и остаток}
    здесь картинка для свадеб в россии 
\end{frame}

01_03
\begin{frame}{STL: результат}
  здесь будет картинка
\end{frame}

01_04
\begin{frame}{Ряд и его ACF}
картинка
\end{frame}

\begin{frame}{Ряд и его PACF}
картинка
\end{frame}

\begin{frame}{Выраженность тренда и сезонности}
    картинка с рядами по свадьбам
\end{frame}


01_05
\begin{frame}{Первые прогнозы!}
  Картинка с моделью независимых наблюдений и случайным блужданием
\end{frame}

\begin{frame}{Уже неплохо!}
  картинка с наивной сезонной моделью 
\end{frame}

02_01
\begin{frame}
  \frametitle{Прогнозируем}
  картинка с прогнозами ANN модели  
\end{frame}

02_02
\begin{frame}
  \frametitle{ETS(AAN): прогнозируем}
Картинка с прогнозами на 2 шага вперед
\end{frame}

02_03
\begin{frame}
  \frametitle{ETS(AAA): прогнозируем}
    Картинка с прогнозами на 12 шагов вперед
\end{frame}

02_04
нет

02_05
\begin{frame}
    \frametitle{Деление на обучающую и тестовую}
    картинка с растущими стрелочками-параболками
\end{frame}

\begin{frame}
    \frametitle{Кросс-валидация скользящим окном}
    картинка с растущими стрелочками-параболками
\end{frame}

\begin{frame}
    \frametitle{Кросс-валидация растущим окном}
    картинка с растущими стрелочками-параболками
\end{frame}



Скринкасты:

Лекция 1.
Скринкаст 1:
создаём tsibble
ts -> tsibble
и графики ряда

Скринкаст 2:
чистим свадьбы!
строим график


Скринкаст 3:
STL-декомпозиция одного ряда
STL фичи множества рядов 
и изображаем на графике множество рядов 

Скринкаст 4. 
Делим выборки на две части. 
Прогноз по наивной модели. 
Прогноз по модели независимых наблюдений. 
Изображаем картинки!
Смотрим параметры моделей. 


Лекция 2.1.
Делим выборку на две части.
Прогноз по ETS(ANA)
Прогноз по ETS(AAA)
Прогноз по ln y_t ~ ETS(AAA)
Прогноз по наивной модели. 
Сравниваем прогнозную силу. 
Смотрим уравнения. 

Лекция 2.1.
Делим выборку на две части.
Прогноз по ETS(AAA)
Разделяем на три составляющих. 

Лекция 2.3.
Устанавливаем минимальную ширину окна. 
Прогноз по ETS(ANA)
Прогноз по ETS(AAA)
Прогноз по наивной модели. 
Сравниваем прогнозную силу по двум типам кросс-валидации.
Автоматически выбираем по AIC.

fcst = forecast(model_table, h = 1)
accuracy(fcst, marr_rf)
marr_rf_stretch = stretch_tsibble(
  marr_rf, .init = 170, .step = 1)


Скринкаст по LOESS?


google_2015_tr %>%
  model(RW(Close ~ drift())) %>%
  forecast(h = 1) %>%
  accuracy(google_2015)










