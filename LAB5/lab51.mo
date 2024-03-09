model lab51
  Real a = 0.18;
  Real b = 0.38;
  Real c = 0.047;
  Real d = 0.035;
  Real x;
  Real y;

initial equation
  x = 12;
  y = 17;
equation
  der(x) = -a*x + c*x*y;
  der(y) = b*y - d*x*y;
  annotation(
    experiment(StartTime = 0, StopTime = 60, Tolerance = 1e-06, Interval = 0.05));
end lab51;
