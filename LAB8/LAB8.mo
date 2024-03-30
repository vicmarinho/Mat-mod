model LAB3

Real y11(start=24000);
Real y21(start=9500);
parameter Real a=0.30;
parameter Real b=0.87;
parameter Real c=0.50;
parameter Real d=0.41;

Real y12(start=24000);
Real y22(start=9500);
parameter Real a2=0.25;
parameter Real b2=0.64;
parameter Real c2=0.20;
parameter Real d2=0.52;

equation
  der(y11) = -a*y11 - b*y21 + sin(2*time) + 1;
  der(y21) = -c*y11 - d*y21 + cos(3*time) + 1;

 
equation
  der(y12) = -a2*y12 - b2*y22 + sin(2*time+4);
  der(y22) = -c2*y12*y22 - d2*y22 + cos(time+4);

end LAB3;

