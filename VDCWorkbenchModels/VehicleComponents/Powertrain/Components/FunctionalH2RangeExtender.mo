within VDCWorkbenchModels.VehicleComponents.Powertrain.Components;
model FunctionalH2RangeExtender "Functional model of fuel cell and hydrogen tank"

  replaceable parameter VDCWorkbenchModels.Data.BaseRecords.RangeExtender REXparameters
    constrainedby Data.BaseRecords.RangeExtender "Set of common fuel cell pack parameters"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  parameter Boolean includeHeatPort = false "= true, if heatPort is enabled";
  parameter Boolean includeGround = false
    "= true, if negative electrical pin is internally grounded";
  parameter Modelica.Units.SI.Mass H2_tank_level=REXparameters.H2_tank_level
    "H2 tank initial level value";

  parameter Real H2efficiency[:,:]=REXparameters.H2efficiency
    "Efficiency of H2 rex range extender";
  parameter Real H2consumption[:,:]=REXparameters.H2consumption
    "H2 consumption in dependency of rex output power";

public
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive electrical pin"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative electrical pin"
    annotation (Placement(transformation(extent={{-90,-70},{-110,-50}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor sensorCurrent
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-70,-40})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if includeHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,0})));

  Modelica.Electrical.Analog.Sources.SignalCurrent generatorCurrent annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,40})));
  Modelica.Blocks.Tables.CombiTable1Ds H2Power2Consumption(
    tableOnFile=false, table=REXparameters.H2consumption,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation (Placement(transformation(extent={{-8,-20},{12,0}})));
  Modelica.Blocks.Continuous.LimIntegrator H2_tank(
    outMax=H2_tank.y_start,
    outMin=0,
    y_start=H2_tank_level,
    k=-1) annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Math.Product H2power
    annotation (Placement(transformation(extent={{-42,20},{-22,0}})));
  Modelica.Blocks.Interfaces.RealInput I_dem "Desired Current"
    annotation (Placement(transformation(extent={{140,40},{100,80}})));
  Modelica.Blocks.Math.RealToBoolean H2_activation(threshold=1)
    annotation (Placement(transformation(extent={{50,50},{30,70}})));
  Modelica.Blocks.Logical.Switch switchH2on
    annotation (Placement(transformation(extent={{10,50},{-10,70}})));
  Modelica.Blocks.Continuous.FirstOrder H2_dynamics(T=0.1)
    annotation (Placement(transformation(extent={{-20,50},{-40,70}})));
  Modelica.Blocks.Sources.Constant H2_deactivated(k=0)
    annotation (Placement(transformation(extent={{50,20},{30,40}})));
  Modelica.Blocks.Tables.CombiTable1Ds H2Power2Efficiency(
    tableOnFile=false, table=REXparameters.H2efficiency)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=1)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant inv(k=1)
    annotation (Placement(transformation(extent={{-32,-70},{-20,-58}})));
  Modelica.Blocks.Math.Product powerLoss annotation (Placement(transformation(extent={{32,-60},{52,-40}})));
  Utilities.Interfaces.ControlBus controlBus annotation (Placement(
        transformation(extent={{40,-120},{80,-80}})));
  Modelica.Blocks.Math.Gain SoC(k=1/REXparameters.H2_tank_level)
                       annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={78,-10})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow H2Losses if includeHeatPort
    annotation (Placement(transformation(extent={{30,-90},{10,-70}})));
  Modelica.Blocks.Nonlinear.Limiter currentLimiter(uMax=40, uMin=0)
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  Modelica.Blocks.Math.Product consumption
    annotation (Placement(transformation(extent={{22,-16},{34,-4}})));
protected
  Utilities.Interfaces.RexBus rexBus
    annotation (Placement(transformation(extent={{90,-40},{110,-20}}), iconTransformation(extent={{78,-52},{98,-32}})));
protected
  Modelica.Electrical.Analog.Basic.Ground ground if includeGround
  annotation (Placement(transformation(extent={{-100,-89},{-80,-69}})));
initial equation
  switchH2on.y = H2_dynamics.y;
equation
  connect(voltageSensor.p, pin_p) annotation (
      Line(points={{-90,10},{-90,60},{-100,60}}, color={0,0,255}));
  connect(pin_n, sensorCurrent.p) annotation (
      Line(points={{-100,-60},{-70,-60},{-70,-50}}, color={0,0,255}));
  connect(ground.p, pin_n) annotation (Line(
      points={{-90,-69},{-90,-60},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSensor.n, pin_n) annotation (
      Line(points={{-90,-10},{-90,-60},{-100,-60}}, color={0,0,255}));
  connect(pin_p, generatorCurrent.p) annotation (
      Line(points={{-100,60},{-70,60},{-70,50}}, color={0,0,255}));
  connect(generatorCurrent.n, sensorCurrent.n)
    annotation (Line(points={{-70,30},{-70,-30}}, color={0,0,255}));
  connect(voltageSensor.v, H2power.u1) annotation (Line(points={{-79,0},{-60,0},{-60,4},{-44,4}},
        color={0,0,127}));
  connect(H2power.y, H2Power2Consumption.u) annotation (Line(points={{-21,10},{-14,10},{-14,-10},{-10,-10}},
        color={0,0,127}));
  connect(switchH2on.u2, H2_activation.y)
    annotation (Line(points={{12,60},{29,60}}, color={255,0,255}));
  connect(H2_dynamics.u, switchH2on.y)
    annotation (Line(points={{-18,60},{-11,60}},
        color={0,0,127}));
  connect(H2_dynamics.y, generatorCurrent.i) annotation (Line(points={{-41,60},{-50,60},{-50,40},{-58,40}},
        color={0,0,127}));
  connect(H2power.u2, generatorCurrent.i) annotation (Line(points={{-44,16},{-50,16},{-50,40},{-58,40}},
        color={0,0,127}));
  connect(H2_deactivated.y, switchH2on.u3) annotation (Line(points={{29,30},{20,30},{20,52},{12,52}},
        color={0,0,127}));
  connect(H2Power2Efficiency.u, H2power.y) annotation (Line(points={{-42,-40},{-50,-40},{-50,-10},{-14,-10},{-14,10},{-21,10}},
        color={0,0,127}));
  connect(H2Power2Efficiency.y[1], add.u1)
    annotation (Line(points={{-19,-40},{-10,-40},{-10,-44},{-2,-44}},
        color={0,0,127}));
  connect(add.u2, inv.y) annotation (Line(points={{-2,-56},{-10,-56},{-10,-64},{-19.4,-64}},
        color={0,0,127}));
  connect(add.y, powerLoss.u2) annotation (Line(points={{21,-50},{24,-50},{24,-56},{30,-56}}, color={0,0,127}));
  connect(powerLoss.u1, H2power.y) annotation (Line(points={{30,-44},{24,-44},{24,-30},{-14,-30},{-14,10},{-21,10}},
        color={0,0,127}));
  connect(rexBus, controlBus.rexBus) annotation (Line(
        points={{100,-30},{100,-99.9},{60.1,-99.9}},
        color={255,204,51},
        thickness=0.5));
  connect(powerLoss.y, rexBus.H2PowerLoss) annotation (Line(points={{53,-50},{80,-50},{80,-32},{100,-32},{100,-30}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(H2_tank.y, rexBus.H2TankContent) annotation (Line(points={{61,-10},{66,-10},{66,-30},{100,-30}}, color={0,0,127}),
      Text(
        string="%second",
        index=3,
        extent={{3,3},{3,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(H2power.y, rexBus.H2Power) annotation (Line(points={{-21,10},{100,10},{100,-30}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(H2_tank.y, SoC.u) annotation (Line(points={{61,-10},{70.8,-10}}, color={0,0,127}));
  connect(SoC.y, rexBus.H2SoC) annotation (Line(points={{84.6,-10},{90,-10},{90,-28},{100,-28},{100,-30}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-3,3},{-3,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(powerLoss.y, H2Losses.Q_flow) annotation (Line(points={{53,-50},{60,-50},{60,-80},{30,-80}},
        color={0,0,127}));
  connect(H2Losses.port, heatPort)
    annotation (Line(points={{10,-80},{0,-80},{0,-100}}, color={191,0,0}));
  connect(currentLimiter.u, I_dem)
    annotation (Line(points={{92,60},{120,60}}, color={0,0,127}));
  connect(H2_activation.u, currentLimiter.y)
    annotation (Line(points={{52,60},{69,60}}, color={0,0,127}));
  connect(currentLimiter.y, switchH2on.u1) annotation (Line(points={{69,60},{60,60},{60,80},{20,80},{20,68},{12,68}},
        color={0,0,127}));
  connect(H2Power2Consumption.y[1],consumption. u2)
    annotation (Line(points={{13,-10},{18,-10},{18,-13.6},{20.8,-13.6}},
        color={0,0,127}));
  connect(consumption.y, H2_tank.u) annotation (Line(points={{34.6,-10},{38,-10}},
        color={0,0,127}));
  connect(consumption.u1, H2power.y) annotation (Line(points={{20.8,-6.4},{18,-6.4},{18,10},{-21,10}},
        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
        Rectangle(
          extent={{-94,96},{94,-96}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dot),
        Rectangle(
          extent={{-78,76},{-52,-72}},
          lineColor={28,108,200},
          pattern=LinePattern.Dot,
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,76},{80,-72}},
          lineColor={28,108,200},
          pattern=LinePattern.Dot,
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,66},{-26,-58}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,66},{6,-58}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,66},{40,-58}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-60,94},{60,64}},
          textColor={255,255,255},
          textString="H2"),
        Text(
          extent={{-114,-60},{108,-94}},
          textColor={244,125,35},
          textString="REX V2")}),
    Documentation(
      info="<html>
<p>
A&nbsp;fuel cell and a&nbsp;hydrogen tank which can be used as a&nbsp;range extender
unit in a&nbsp;hybrid power train.
A&nbsp;DC/DC converter is connected to the fuel cell in order to regulate its
current&nbsp;<var>I</var><sub>FC</sub> and power flow between the hybrid storage elements.
</p>
</html>"));
end FunctionalH2RangeExtender;
