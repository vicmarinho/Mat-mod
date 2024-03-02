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
der(y) = -(w*w)*x - g*y;
end lab42;
