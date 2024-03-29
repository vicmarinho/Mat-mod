﻿`                 `**РОССИЙСКИЙ УНИВЕРСИТЕТ ДРУЖБЫ НАРОДОВ**

**Факультет физико-математических и естественных наук**

**Кафедра прикладной информатики и теории вероятностей**





**ОТЧЕТ** 

**ПО ЛАБОРАТОРНОЙ РАБОТЕ № 4**

*дисциплина:	Математическое моделирование*	 



Студент:   Тозе Витор Ф                           

Группа: НФИбд-02-21                                      


**МОСКВА**

2024 г.










# Содержание
[Цель работы	1](#_toc160309462)

[Теоретическое введение	1](#_toc160309463)

[Задачи	2](#_toc160309464)

[Задание	3](#_toc160309465)

[Выполнение лабораторной работы	3](#_toc160309466)

[Построение математической модели. Решение с помощью программ	3](#_toc160309467)

[Julia	3](#_toc160309468)

[Результаты работы кода на Julia	6](#_toc160309469)

[OpenModelica	6](#_toc160309470)

[Результаты работы кода на OpenModelica	7](#_toc160309471)

[Анализ полученных результатов. Сравнение языков.	8](#_toc160309472)

[Вывод	8](#_toc160309473)


# <a name="цель-работы"></a><a name="_toc160309462"></a>**Цель работы**
Изучить понятие гармонического осциллятора, построить фазовый портрет и найти решение уравнения гармонического осциллятора.













# <a name="теоретическое-введение"></a><a name="_toc160309463"></a>**Теоретическое введение**
- Гармонический осциллятор [1] — система, которая при смещении из положения равновесия испытывает действие возвращающей силы F, пропорциональной смещению x.
- Гармоническое колебание [2] - колебание, в процессе которого величины, характеризующие движение (смещение, скорость, ускорение и др.), изменяются по закону синуса или косинуса (гармоническому закону).

Движение грузика на пружинке, маятника, заряда в электрическом контуре, а также эволюция во времени многих систем в физике, химии, биологии и других науках при определенных предположениях можно описать одним и тем же дифференциальным уравнением, которое в теории колебаний выступает в качестве основной модели. Эта модель называется линейным гармоническим осциллятором. Уравнение свободных колебаний гармонического осциллятора имеет следующий вид:

x+2γx+ω02=0

где x - переменная, описывающая состояние системы (смещение грузика, заряд конденсатора и т.д.), γ - параметр, характеризующий потери энергии (трение в механической системе, сопротивление в контуре), ω0 - собственная частота колебаний. Это уравнение есть линейное однородное дифференциальное уравнение второго порядка и оно является примером линейной динамической системы.

При отсутствии потерь в системе ( γ=0 ) получаем уравнение консервативного осциллятора энергия колебания которого сохраняется во времени.

x+ω02x=0

Для однозначной разрешимости уравнения второго порядка необходимо задать два начальных условия вида

xt0=x0xt0=y0

Уравнение второго порядка можно представить в виде системы двух уравнений первого порядка:

x=yy=-ω02x

Начальные условия для системы примут вид:

xt0=x0yt0=y0

Независимые переменные x,y определяют пространство, в котором «движется» решение. Это фазовое пространство системы, поскольку оно двумерно будем называть его фазовой плоскостью.

Значение фазовых координат x,y в любой момент времени полностью определяет состояние системы. Решению уравнения движения как функции времени отвечает гладкая кривая в фазовой плоскости. Она называется фазовой траекторией. Если множество различных решений (соответствующих различным начальным условиям) изобразить на одной фазовой плоскости, возникает общая картина поведения системы. Такую картину, образованную набором фазовых траекторий, называют фазовым портретом.

# <a name="задачи"></a><a name="_toc160309464"></a>**Задачи**
1. Разобраться в понятии гармонического осциллятора
1. Ознакомиться с уравнением свободных колебаний гармонического осциллятора
1. Построить фазовый портрет гармонического осциллятора и решение уравнения на языках Julia и Open Modelica гармонического осциллятора для следующих случаев:
- Колебания гармонического осциллятора без затуханий и без действий внешней силы
- Колебания гармонического осциллятора c затуханием и без действий внешней силы
- Колебания гармонического осциллятора c затуханием и под действием внешней силы
# <a name="задание"></a><a name="_toc160309465"></a>**Задание**
Вариант 7:

Постройте фазовый портрет гармонического осциллятора и решение уравнения гармонического осциллятора для следующих случаев:

1. Колебания гармонического осциллятора без затуханий и без действий внешней силы x+7x=0;
1. Колебания гармонического осциллятора c затуханием и без действий внешней силы x+2x+6x=0
1. Колебания гармонического осциллятора c затуханием и под действием внешней силы x+5x+x=cos3t

На интервале t∈0;25 (шаг 0.05) с начальными условиями x0=-1,y0=-1.
# <a name="выполнение-лабораторной-работы"></a><a name="_toc160309466"></a>**Выполнение лабораторной работы**
## <a name="x38ecfa8bd1d9931fb6f8cd8559cb494816d89b3"></a><a name="_toc160309467"></a>**Построение математической модели. Решение с помощью программ**
### <a name="julia"></a><a name="_toc160309468"></a>**Julia**
Код программы для первого случая:

using Plots
using DifferentialEquations

w = 7.0
g = 0.0
x₀ = -1.0
y₀ = -1.0


function ode\_fn(du, u, p, t)
`  `x, y = u
`  `du[1] = u[2]
`  `du[2] = -(w\*w)\*u[1] - g\*u[2]
end

v₀ = [x₀, y₀]
tspan = (0.0, 25.0)
prob = ODEProblem(ode\_fn, v₀, tspan)
sol = solve(prob, dtmax=0.05)

X = [u[1] for u in sol.u]
Y = [u[2] for u in sol.u]
T = [t for t in sol.t]
plt = plot(
`           `layout=(1,2),
`           `dpi=300,
`           `legend=false)

plot!(
`      `plt[1],
`      `T,
`      `X,
`      `title="Решение уравнения",
`      `color=:blue)

plot!(
`      `plt[2],
`      `X,
`      `Y,
`      `title="Фазовый портрет",
`      `color=:blue)

savefig(plt, "jl1.png")

![Изображение выглядит как текст, снимок экрана, линия, диаграмма

Автоматически созданное описание](jl1.png)











Код программы для второго случая:

using Plots
using DifferentialEquations

w = 6.0
g = 2.0
x₀ = -1.0
y₀ = -1.0


function ode\_fn(du, u, p, t)
`  `x, y = u
`  `du[1] = u[2]
`  `du[2] = -(w\*w)\*u[1] - g\*u[2]
end

v₀ = [x₀, y₀]
tspan = (0.0, 25.0)
prob = ODEProblem(ode\_fn, v₀, tspan)
sol = solve(prob, dtmax=0.05)

X = [u[1] for u in sol.u]
Y = [u[2] for u in sol.u]
T = [t for t in sol.t]
plt = plot(
`           `layout=(1,2),
`           `dpi=300,
`           `legend=false)

plot!(
`      `plt[1],
`      `T,
`      `X,
`      `title="Решение уравнения",
`      `color=:blue)

plot!(
`      `plt[2],
`      `X,
`      `Y,
`      `title="Фазовый портрет",
`      `color=:blue)

savefig(plt, "jl2.png")

![Изображение выглядит как текст, диаграмма, линия, График

Автоматически созданное описание](jl2.png)











Код программы для третьего случая:

using Plots
using DifferentialEquations

w = 1.0
g = 5.0
x₀ = -1.0
y₀ = -1.0


function ode\_fn(du, u, p, t)
`  `x, y = u
`  `du[1] = u[2]
`  `du[2] = -(w\*w)\*u[1] - g\*u[2] + cos(3\*t)
end

v₀ = [x₀, y₀]
tspan = (0.0, 25.0)
prob = ODEProblem(ode\_fn, v₀, tspan)
sol = solve(prob, dtmax=0.05)

X = [u[1] for u in sol.u]
Y = [u[2] for u in sol.u]
T = [t for t in sol.t]
plt = plot(
`           `layout=(1,2),
`           `dpi=300,
`           `legend=false)

plot!(
`      `plt[1],
`      `T,
`      `X,
`      `title="Решение уравнения",
`      `color=:blue)

plot!(
`      `plt[2],
`      `X,
`      `Y,
`      `title="Фазовый портрет",
`      `color=:blue)

savefig(plt, "jl3.png")

![Изображение выглядит как текст, линия, Шрифт, График

Автоматически созданное описание](jl3.png)








### <a name="результаты-работы-кода-на-julia"></a><a name="_toc160309469"></a>**Результаты работы кода на Julia**
Первый случай:

Колебания гармонического осциллятора без затуханий и без действий внешней силы

|“Решение уравнения и фазовый портрет для колебания гармонического осциллятора без затуханий и без действий внешней силы на языке Julia”|
| :-: |

*“Решение уравнения и фазовый портрет для колебания гармонического осциллятора без затуханий и без действий внешней силы на языке Julia”*

Второй случай:

Колебания гармонического осциллятора c затуханием и без действий внешней силы

|“Решение уравнения и фазовый портрет для колебания гармонического осциллятора c затуханием и без действий внешней силы на языке Julia”|
| :-: |

*“Решение уравнения и фазовый портрет для колебания гармонического осциллятора c затуханием и без действий внешней силы на языке Julia”*

Третий случай:

Колебания гармонического осциллятора c затуханием и под действием внешней силы

|“Решение уравнения и фазовый портрет для колебания гармонического осциллятора cc затуханием и под действием внешней силы на языке Julia”|
| :-: |

*“Решение уравнения и фазовый портрет для колебания гармонического осциллятора cc затуханием и под действием внешней силы на языке Julia”*


## <a name="openmodelica"></a><a name="_toc160309470"></a>**OpenModelica**
Код программы для первого случая:

model lab41
Real x;
Real y;
Real w = 7.0;
Real g = 0.0;
Real t = time;
initial equation
x = -1.0;
y = -1.0;
equation
der(x) = y;
der(y) = -(w\*w)\*x - g\*y;
end lab41;



Код программы для второго случая:

model lab42
Real x;
Real y;
Real w = 6.0;
Real g = 2.0;
Real t = time;
initial equation
x = -1.0;
y = -1.0;
equation
der(x) = y;
der(y) = -(w\*w)\*x - g\*y;
end lab42;

Код программы для третьего случая:

model lab43
Real x;
Real y;
Real w = 1.0;
Real g = 5.0;
Real t = time;
initial equation
x = -1.0;
y = -1.0;
equation
der(x) = y;
der(y) = -(w\*w)\*x - g\*y + sin(3\*t);
end lab43;
### <a name="результаты-работы-кода-на-openmodelica"></a><a name="_toc160309471"></a>**Результаты работы кода на OpenModelica**
Первый случай:

Колебания гармонического осциллятора без затуханий и без действий внешней силы

|“Решение уравнения и фазовый портрет для колебания гармонического осциллятора без затуханий и без действий внешней силы на языке Open Modelica”|
| :-: |

*“Решение уравнения и фазовый портрет для колебания гармонического осциллятора без затуханий и без действий внешней силы на языке Open Modelica”*

Второй случай:

Колебания гармонического осциллятора c затуханием и без действий внешней силы

<a name="fig:005"></a>“Решение уравнения и фазовый портрет для колебания гармонического осциллятора c затуханием и без действий внешней силы на языке Open Modelica” Третий случай:

Колебания гармонического осциллятора c затуханием и под действием внешней силы

|“Решение уравнения и фазовый портрет для колебания гармонического осциллятора cc затуханием и под действием внешней силы на языке Open Modelica”|
| :-: |

*“Решение уравнения и фазовый портрет для колебания гармонического осциллятора cc затуханием и под действием внешней силы на языке Open Modelica”*
# <a name="x9c2f4050edd52bf181b19031b296462e82f064b"></a><a name="_toc160309472"></a>**Анализ полученных результатов. Сравнение языков.**
В итоге проделанной работы мы построили три графика для вышеуказанных моделей на языках Julia и OpenModelica. Построение моделей колебания на языке OpenModelica занимает меньше строк, чем аналогичное построение на Julia.
# <a name="вывод"></a><a name="_toc160309473"></a>**Вывод**
В ходе выполнения лабораторной работы были построены решения уравнения гармонического осциллятора и фазовые портреты гармонических колебаний без затухания, с затуханием и при действии внешней силы на языках Julia и Open Modelica.
