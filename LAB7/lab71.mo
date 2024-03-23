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
der(y) = -(w*w)*x - g*y;
end lab41;
