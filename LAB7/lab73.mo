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
der(y) = -(w*w)*x - g*y + sin(3*t);
end lab43;
