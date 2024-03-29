﻿**РОССИЙСКИЙ УНИВЕРСИТЕТ ДРУЖБЫ НАРОДОВ**

**Факультет физико-математических и естественных наук**

**Кафедра прикладной информатики и теории вероятностей**





**ОТЧЕТ** 

**ПО ЛАБОРАТОРНОЙ РАБОТЕ № 5**

*дисциплина:	Математическое моделирование*	 









Студент:   Тозе Витор Ф                                  

`	`Группа: НФИбд-02-21                                      





**МОСКВА**

2024 г.




# Содержание
[Цель работы	1](#_toc160909569)

[Теоретическое введение	1](#_toc160909570)

[Задачи	2](#_toc160909571)

[Задание	3](#_toc160909572)

[Выполнение лабораторной работы	3](#_toc160909573)

[Построение математической модели. Решение с помощью программ	3](#_toc160909574)

[Julia	3](#_toc160909575)

[Результаты работы кода на Julia	5](#_toc160909576)

[OpenModelica	6](#_toc160909577)

[Результаты работы кода на OpenModelica	7](#_toc160909578)

[Анализ полученных результатов. Сравнение языков.	8](#_toc160909579)

[Вывод	8](#_toc160909580)

[Список литературы. Библиография	8](#_toc160909581)


# <a name="цель-работы"></a><a name="_toc160909569"></a>**Цель работы**
Изучить жесткую модель хищник-жертва и построить эту модель.
# <a name="теоретическое-введение"></a><a name="_toc160909570"></a>**Теоретическое введение**
- Модель Лотки—Вольтерры — модель взаимодействия двух видов типа «хищник — жертва», названная в честь её авторов, которые предложили модельные уравнения независимо друг от друга. Такие уравнения можно использовать для моделирования систем «хищник — жертва», «паразит — хозяин», конкуренции и других видов взаимодействия между двумя видами. [4]

Данная двувидовая модель основывается на следующих предположениях [4]:

1. Численность популяции жертв x и хищников y зависят только от времени (модель не учитывает пространственное распределение популяции на занимаемой территории)
1. В отсутствии взаимодействия численность видов изменяется по модели Мальтуса, при этом число жертв увеличивается, а число хищников падает
1. Естественная смертность жертвы и естественная рождаемость хищника считаются несущественными
1. Эффект насыщения численности обеих популяций не учитывается
1. Скорость роста численности жертв уменьшается пропорционально численности хищников

dxdt=-axt+bytxtdydt=cyt-dytxt

В этой модели x – число жертв, y - число хищников. Коэффициент a описывает скорость естественного прироста числа жертв в отсутствие хищников, с - естественное вымирание хищников, лишенных пищи в виде жертв. Вероятность взаимодействия жертвы и хищника считается пропорциональной как количеству жертв, так и числу самих хищников (xy). Каждый акт взаимодействия уменьшает популяцию жертв, но способствует увеличению популяции хищников (члены -bxy и dxy в правой части уравнения).

Математический анализ этой (жёсткой) модели показывает, что имеется стационарное состояние, всякое же другое начальное состояние приводит к периодическому колебанию численности как жертв, так и хищников, так что по прошествии некоторого времени такая система вернётся в изначальное состояние.

Стационарное состояние системы (положение равновесия, не зависящее от времени решения) будет находиться в точке x0=cd,y0=ab. Если начальные значения задать в стационарном состоянии x0=x0,y0=y0, то в любой момент времени численность популяций изменяться не будет. При малом отклонении от положения равновесия численности как хищника, так и жертвы с течением времени не возвращаются к равновесным значениям, а совершают периодические колебания вокруг стационарной точки. Амплитуда колебаний и их период определяется начальными значениями численностей x0,y0. Колебания совершаются в противофазе.
# <a name="задачи"></a><a name="_toc160909571"></a>**Задачи**
1. Построить график зависимости численности хищников от численности жертв
1. Построить график зависимости численности хищников и численности жертв от времени
1. Найти стационарное состояние системы
# <a name="задание"></a><a name="_toc160909572"></a>**Задание**
Вариант 7:

Для модели «хищник-жертва»:

dxdt=-0.18xt+0.047ytxtdydt=0.38yt-0.035ytxt

Постройте график зависимости численности хищников от численности жертв, а также графики изменения численности хищников и численности жертв при следующих начальных условиях: x0=12,y0=17 Найдите стационарное состояние системы.
# <a name="выполнение-лабораторной-работы"></a><a name="_toc160909573"></a>**Выполнение лабораторной работы**
## <a name="x38ecfa8bd1d9931fb6f8cd8559cb494816d89b3"></a><a name="_toc160909574"></a>**Построение математической модели. Решение с помощью программ**
### <a name="julia"></a><a name="_toc160909575"></a>**Julia**
Код программы для нестационарного состояния:

using Plots
using DifferentialEquations

x0 = 12
y0 = 17

a = 0.18
b = 0.38
c = 0.047
d = 0.035


function ode\_fn(du, u, p, t)
`    `x, y = u
`    `du[1] = -a\*u[1] + c \* u[1] \* u[2]
`    `du[2] = b \* u[2] - d \* u[1] \* u[2]
end

v0 = [x0, y0]
tspan = (0.0, 60.0)
prob = ODEProblem(ode\_fn, v0, tspan)
sol = solve(prob, dtmax=0.05)
X = [u[1] for u in sol.u]
Y = [u[2] for u in sol.u]
T = [t for t in sol.t]

plt = plot(
`  `dpi=300,
`  `legend=false)

plot!(
`  `plt,
`  `X,
`  `Y,
`  `label="Зависимость численности хищников от численности жертв",
`  `color=:blue)

savefig(plt, "julia1-1.png")

plt2 = plot(
`  `dpi=300,
`  `legend=true)

plot!(
`  `plt2,
`  `T,
`  `X,
`  `label="Численность жертв",
`  `color=:green)

plot!(
`  `plt2,
`  `T,
`  `Y,
`  `label="Численность хищников",
`  `color=:red)

savefig(plt2, "julia1-2.png")


Код программы для стационарного состояния:

using Plots
using DifferentialEquations

a = 0.18
b = 0.38
c = 0.047
d = 0.035

x0 = c / d 
y0 = a / b

function ode\_fn(du, u, p, t)
`    `x, y = u
`    `du[1] = -a\*u[1] + c \* u[1] \* u[2]
`    `du[2] = b \* u[2] - d \* u[1] \* u[2]
end

v0 = [x0, y0]
tspan = (0.0, 60.0)
prob = ODEProblem(ode\_fn, v0, tspan)
sol = solve(prob, dtmax=0.05)
X = [u[1] for u in sol.u]
Y = [u[2] for u in sol.u]
T = [t for t in sol.t]

plt2 = plot(
`  `dpi=300,
`  `legend=true)

plot!(
`  `plt2,
`  `T,
`  `X,
`  `label="Численность жертв",
`  `color=:green)

plot!(
`  `plt2,
`  `T,
`  `Y,
`  `label="Численность хищников",
`  `color=:red)

savefig(plt2, "julia2.png")

В стационарном состоянии решение вида yx=somefunction будет представлять собой точку.
### <a name="результаты-работы-кода-на-julia"></a><a name="_toc160909576"></a>**Результаты работы кода на Julia**

*График численности хищников от численности жертв*

![Изображение выглядит как линия, диаграмма, График

Автоматически созданное описание](Aspose.Words.74b2b701-298f-4502-ae40-b285ab75d579.001.png)








*График численности жертв и хищников от времени*

![Изображение выглядит как текст, диаграмма, График, линия

Автоматически созданное описание](Aspose.Words.74b2b701-298f-4502-ae40-b285ab75d579.002.png)

![Изображение выглядит как текст, График, диаграмма, линия

Автоматически созданное описание](Aspose.Words.74b2b701-298f-4502-ae40-b285ab75d579.003.png)*Стационарное состояние*









##
## <a name="openmodelica"></a><a name="_toc160909577"></a>**OpenModelica**
Код программы для нестационарного состояния:

model lab51
`  `Real a = 0.18;
`  `Real b = 0.38;
`  `Real c = 0.047;
`  `Real d = 0.035;
`  `Real x;
`  `Real y;

initial equation
`  `x = 12;
`  `y = 17;
equation
`  `der(x) = -a\*x + c\*x\*y;
`  `der(y) = b\*y - d\*x\*y;
`  `annotation(
`    `experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.05));
end lab51;

Код программы для стационарного состояния:

model lab52
`  `Real a = 0.18;
`  `Real b = 0.38;
`  `Real c = 0.047;
`  `Real d = 0.035;
`  `Real x;
`  `Real y;
initial equation
`  `x = c/d;
`  `y = a/b;
equation
`  `der(x) = -a\*x + c\*x\*y;
`  `der(y) = b\*y - d\*x\*y;
`  `annotation(
`    `experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.05));
end lab52;

В стационарном состоянии решение вида yx=somefunction будет представлять собой точку.
### <a name="результаты-работы-кода-на-openmodelica"></a><a name="_toc160909578"></a>**Результаты работы кода на OpenModelica**
![График численности хищников от численности жертв](Aspose.Words.74b2b701-298f-4502-ae40-b285ab75d579.004.png)

*График численности хищников от численности жертв*

![График численности жертв и хищников от времени](Aspose.Words.74b2b701-298f-4502-ae40-b285ab75d579.005.png)

*График численности жертв и хищников от времени*

![Стационарное состояние](Aspose.Words.74b2b701-298f-4502-ae40-b285ab75d579.006.png)

*Стационарное состояние*
# <a name="x9c2f4050edd52bf181b19031b296462e82f064b"></a><a name="_toc160909579"></a>**Анализ полученных результатов. Сравнение языков.**
В итоге проделанной работы мы построили график зависимости численности хищников от численности жертв, а также графики изменения численности хищников и численности жертв на языках Julia и OpenModelica. Построение модели хищник-жертва на языке openModelica занимает меньше строк, чем аналогичное построение на Julia.
# <a name="вывод"></a><a name="_toc160909580"></a>**Вывод**
В ходе выполнения лабораторной работы была изучена модель хищник-жертва и построена модель на языках Julia и Open Modelica.
# <a name="список-литературы.-библиография"></a><a name="_toc160909581"></a>**Список литературы. Библиография**
[1] Документация по Julia: https://docs.julialang.org/en/v1/

[2] Документация по OpenModelica: https://openmodelica.org/

[3] Решение дифференциальных уравнений: https://www.wolframalpha.com/

[4] Модель Лотки—Вольтерры: https://math-it.petrsu.ru/users/semenova/MathECO/Lections/Lotka\_Volterra.pdf
