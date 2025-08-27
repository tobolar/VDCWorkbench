within VDCWorkbenchModels.VehicleComponents.Powertrain.Components;
model AgingCalculation
  Modelica.Blocks.Math.ContinuousMean tempMean(t_eps=0.1)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Math.Abs currentAbs annotation (Placement(transformation(extent={{-86,-6},{-74,6}})));
  Modelica.Blocks.Math.ContinuousMean currentMean
    annotation (Placement(transformation(extent={{-64,-6},{-52,6}})));
  Modelica.Blocks.Math.Gain mean_C_rate(k=-1/C_N)
    annotation (Placement(transformation(extent={{-38,-8},{-22,8}})));
  Modelica.Blocks.Continuous.Derivative derivative(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start=0)
    annotation (Placement(transformation(extent={{-86,54},{-74,66}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=0, uMin=-1000)
    annotation (Placement(transformation(extent={{-64,54},{-52,66}})));
  Modelica.Blocks.Continuous.Integrator dissCycles(k=-1)
    "Real value of discharge cycles"
    annotation (Placement(transformation(extent={{-42,54},{-30,66}})));
  Modelica.Blocks.Interfaces.RealInput SoC
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput current annotation (Placement(
        transformation(rotation=0, extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput temperature annotation (Placement(
        transformation(rotation=0, extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput Capacity "Aged initial capacity"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,60})));
  Modelica.Blocks.Interfaces.RealOutput C_aged "Remaining cell capacity"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealOutput DeltaC_dN "Cell aging rate"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-60})));
  Modelica.Blocks.Sources.RealExpression cap(y=no_p*C_aged_0*3600)
    annotation (Placement(transformation(extent={{34,44},{80,76}})));
  parameter Modelica.Units.NonSI.ElectricCharge_Ah C_N=1 "Nominal cell capacity @ C=0.25, T = 25 degC";
  parameter Real no_s = 1 "Number of cells connected in series";
  parameter Real no_p = 1 "Number of cells connected in parallel";
  parameter Real N_cycles = 100 "Number of cell discharge cycles";
  parameter Real C_rate = 1 "C-Rate during aging";
  parameter Modelica.Units.NonSI.Temperature_degC T_aged = 25 "Temperature during aging";
  parameter Real b[10] = {2.047950e-04,8.774712e-03,1.053884e+00,9.627156e+00,4.145082e+00,5.851487e+02,2.473591e-02,8.568005e-03,-3.290276e+02,1.966467e+01} "Aging parameters";

  final parameter Modelica.Units.NonSI.ElectricCharge_Ah C_aged_0 = (1-DeltaC_0)*C_N
    "Initial aged cell capacity";
  final parameter Real Nknee_0 = b[6] + b[9]*C_rate + b[10]*T_aged
    "Fade effect point between short and long time aging effects";
  final parameter VehicleInterfaces.Types.NormalizedReal DeltaC_0 = b[1] * exp(-b[4]/T_aged) * exp((b[2]+b[5]/T_aged)*C_rate) * N_cycles^b[3] + b[8] * exp(b[7]*(N_cycles- Nknee_0))
    "Loss of charge";

  Modelica.Blocks.Nonlinear.Limiter dissCyclesLim(
    uMax=1e6,
    uMin=1e-4)
    annotation (Placement(transformation(extent={{-20,54},{-8,66}})));
protected
  Real Nknee;
  Real k;
  Real DeltaC;
//  Real C_aged;
//  Real DeltaC_dN;

initial equation
  // DeltaC_dN = 0;
  //k=0;

equation

  //T_aged = TempeatureMean.y;
  Nknee = (b[6]+b[9]*mean_C_rate.y + b[10]*T_aged);
  DeltaC = b[1] * exp(-b[4]/T_aged) * exp((b[2] + b[5]/T_aged)*mean_C_rate.y) *dissCyclesLim.y ^b[3] + exp( (dissCyclesLim.y- Nknee) *b[7])*b[8];
  C_aged = (1-DeltaC)*C_aged_0;
  k = b[1] * exp(-b[4]/tempMean.y) * exp((b[2] + b[5]/tempMean.y)*currentMean.y) "constant independent from N";
  DeltaC_dN = k * b[3] * (N_cycles+dissCyclesLim.y)^(b[3]-1);

  // The following is not working as desired
  //when terminal() then
  //  k = b[1] * exp(-b[4]/tempMean.y) * exp((b[2] + b[5]/tempMean.y)*currentMean.y) "constant independent from N";
  //  DeltaC_dN = k * b[3] * (DissCycles.y)^(b[3]-1);
  //end when;

  connect(currentMean.y, mean_C_rate.u)
    annotation (Line(points={{-51.4,0},{-39.6,0}}, color={0,0,127}));
  connect(derivative.y, limiter.u)
    annotation (Line(points={{-73.4,60},{-65.2,60}}, color={0,0,127}));
  connect(limiter.y, dissCycles.u)
    annotation (Line(points={{-51.4,60},{-43.2,60}}, color={0,0,127}));
  connect(currentAbs.y, currentMean.u)
    annotation (Line(points={{-73.4,0},{-65.2,0}}, color={0,0,127}));
  connect(current, currentAbs.u)
    annotation (Line(points={{-120,0},{-87.2,0}}, color={0,0,127}));
  connect(SoC, derivative.u)
    annotation (Line(points={{-120,60},{-87.2,60}}, color={0,0,127}));
  connect(temperature, tempMean.u) annotation (Line(points={{-120,-60},{-82,-60}},
        color={0,0,127}));
  connect(cap.y, Capacity)
    annotation (Line(points={{82.3,60},{110,60}}, color={0,0,127}));
  connect(dissCycles.y, dissCyclesLim.u)
    annotation (Line(points={{-29.4,60},{-21.2,60}}, color={0,0,127}));
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=90,
          origin={52,60},
          pattern=LinePattern.None,
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=45,
          origin={80,6},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,0,0}),
        Rectangle(
          extent={{80,6},{100,-6}},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=135,
          origin={122,-48},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=90,
          origin={52,-120},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=45,
          origin={-50,-120},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{-100,6},{-80,-6}},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Rectangle(
          extent={{20,58},{40,46}},
          fillPattern=FillPattern.Solid,
          rotation=135,
          origin={-6,80},
          lineColor={95,95,95},
          fillColor={95,95,95}),
        Ellipse(
          extent={{10,-10},{-10,10}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,0},{54,54}},
          color={95,95,95},
          thickness=1),
        Line(
          points={{-62,4},{0,0}},
          color={95,95,95},
          thickness=1),
        Text(
          extent={{-100,-100},{104,-130}},
          textColor={28,108,200},
          textString="%name")}),
    Documentation(
      info="<html>
<p>
The aging model for predicting the capacity degradation of the battery due to the
charge/discharge events. The aging is computed using the average <code>current</code>
and <code>temperature</code> of the battery over a&nbsp;discharge cycle, whereby
<code>dissCyclesLim.y</code> calculates the number of discharge cycles.
</p>
<p>
The remaining cell capacity <code>C_aged</code> is defined as
</p>
<blockquote><pre>
C_aged = (1-DeltaC) * C_aged_0,
</pre></blockquote>
<p>
with the initial cell capacity <code>C_aged_0</code> and the normalized cell capacity
loss during the drive cycle <code>DeltaC</code>. The latter is calculated by means of
aging parameters&nbsp;<code>b</code>.
</p>
<p>
For further details of the aging model, refer to
[<a href=\"modelica://VDCWorkbenchModels.UsersGuide.References\">deCastro2022</a>].
</p>
</html>"));
end AgingCalculation;
