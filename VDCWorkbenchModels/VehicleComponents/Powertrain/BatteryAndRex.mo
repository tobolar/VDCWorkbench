within VDCWorkbenchModels.VehicleComponents.Powertrain;
model BatteryAndRex "Energy source consisting of battery and hydrogen range extender"
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
    T=298.15);

  parameter VDCWorkbenchModels.Utilities.Types.StateOfCharge SOC_init=1
    "Initial value of SOC";
  parameter Boolean includeGround=false "= true, if negative electrical pin is internally grounded";

  Components.ParameterizedModels.ROMOBatteryPack90s1pAging batteryPack(
    SOC_init=SOC_init,
    final includeGround=includeGround,
    final includeHeatPort=useHeatPort) annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Components.ParameterizedModels.ROMOH2Rex rex(
    final includeHeatPort=useHeatPort,
    final includeGround=false)
    annotation (Placement(transformation(extent={{20,-20},{0,-40}})));
  Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,80})));
  Modelica.Blocks.Interfaces.RealInput I_dem annotation (Placement(transformation(rotation=0, extent={{-140,-20},{-100,20}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive electrical pin" annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative electrical pin" annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
equation
  connect(controlBus, batteryPack.controlBus) annotation (Line(
      points={{-100,80},{-10,80},{-10,10},{4,10},{4,20}},
      color={255,204,51},
      thickness=0.5));
  connect(internalHeatPort, batteryPack.heatPort) annotation (Line(points={{-100,-80},{-100,-60},{-20,-60},{-20,0},{10,0},{10,20}},    color={191,0,0}));
  connect(I_dem, rex.I_dem) annotation (Line(points={{-120,0},{-40,0},{-40,-36},{-2,-36}}, color={0,0,127}));
  connect(controlBus, rex.controlBus) annotation (Line(
      points={{-100,80},{-10,80},{-10,10},{4,10},{4,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(internalHeatPort, rex.heatPort) annotation (Line(points={{-100,-80},{-100,-60},{-20,-60},{-20,0},{10,0},{10,-20}},    color={191,0,0}));
  connect(rex.pin_p, batteryPack.pin_p) annotation (Line(points={{20,-36},{80,-36},{80,36},{20,36}}, color={0,0,255}));
  connect(rex.pin_n, batteryPack.pin_n) annotation (Line(points={{20,-24},{60,-24},{60,24},{20,24}}, color={0,0,255}));
  connect(batteryPack.pin_p, pin_p) annotation (Line(points={{20,36},{80,36},{80,60},{100,60}}, color={0,0,255}));
  connect(batteryPack.pin_n, pin_n) annotation (Line(points={{20,24},{60,24},{60,-60},{100,-60}}, color={0,0,255}));
  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-80,-10},{40,-70}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Line(points={{-70,20},{-90,0},{-100,0}},  color={0,0,0}),
        Text(
          extent={{-150,140},{150,100}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-80,70},{40,10}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-64,62},{-56,18}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,-28},{-10,-28},{-10,-36}},
          color={0,0,255}),
        Line(
          points={{-24,-36},{4,-36}},
          color={0,0,255}),
        Line(
          points={{-16,-44},{-4,-44}},
          color={0,0,255}),
        Line(
          points={{40,-52},{-10,-52},{-10,-44}},
          color={0,0,255}),
        Line(
          points={{40,-28},{80,-28},{80,60},{100,60}},
          color={0,0,255}),
        Rectangle(
          extent={{-38,62},{-30,18}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,62},{-4,18}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{14,62},{22,18}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{58,-24},{62,-32}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{40,-52},{100,-52},{100,-60}},
          color={0,0,255}),
        Line(
          points={{40,50},{80,50}},
          color={0,0,255}),
        Line(
          points={{40,30},{60,30},{60,-52}},
          color={0,0,255}),
        Line(
          points={{-70,30},{-70,-100},{-100,-100}},
          color={127,0,0},
          visible=useHeatPort),
        Line(
          points={{60,-52},{60,-90}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
        Line(
          points={{40,-90},{80,-90}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
        Line(
          points={{48,-98},{72,-98}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
        Line(
          points={{54,-106},{66,-106}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround)}),
    Documentation(
      info="<html>
<p>
The hybrid energy storage is composed of a&nbsp;fuel cell and a&nbsp;Li-ion battery.
A&nbsp;DC/DC converter is connected to the fuel cell in order to regulate its
current&nbsp;<var>I</var><sub>FC</sub> and power flow between the hybrid storage elements.
Both the fuel cell &amp; H2 tank and the battery provide energy for the vehicle&apos;s
drivetrain.
</p>
</html>"));
end BatteryAndRex;
