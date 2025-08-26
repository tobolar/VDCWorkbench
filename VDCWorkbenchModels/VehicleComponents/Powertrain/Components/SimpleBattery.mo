within VDCWorkbenchModels.VehicleComponents.Powertrain.Components;
model SimpleBattery
  "Simple battery model based on inner resistance and SOC_OCV table"
  parameter VDCWorkbenchModels.Utilities.Types.StateOfCharge SOC_init = 1 "Initial value of SOC"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.Units.NonSI.ElectricCharge_Ah C_N=cellParameters.C_N "Nominal cell capacity @ C=0.25, T = 25C";
  parameter Real no_s = cellParameters.no_s "Number of cells connected in series";
  parameter Real no_p = cellParameters.no_p "Number of cells connected in parallel";
  //parameter Real intConst = 1/(no_p*C_N*3600) "Integrater constant";

  parameter Boolean includeHeatPort = false "True, if heatPort is enabled";
  parameter Boolean includeGround = false
    "True, if negative electrical pin is internally grounded";
/* ****** Not used so far
  parameter String SOC_OCV_table = "noName"
    "Path and file name of SOC_OCV table";
  parameter String Ri_Lookup_table = "noName" "Path and file name of Ri table";
*/
  parameter Modelica.Units.SI.HeatCapacity Ch_cell=cellParameters.Ch_cell
    "Heat capacity of one cell";

  replaceable parameter Data.BaseRecords.Battery cellParameters
    constrainedby Data.BaseRecords.Battery "Set of common battery parameters"
    annotation (Placement(transformation(extent={{-100,78},{-80,98}})));

protected
  Modelica.Electrical.Analog.Basic.Ground ground if includeGround
  annotation (Placement(transformation(extent={{-100,-101},{-80,-81}})));
public
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive electrical pin"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative electrical pin"
    annotation (Placement(transformation(extent={{-90,-70},{-110,-50}}, rotation=0), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealOutput voltage "Total pack voltage"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput SOC "State of charge"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput current "Total pack current"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if includeHeatPort
    "Conditional port for exhaust heat flow"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}},
          rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor(
    useHeatPort=true)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,0})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor sensorCurrent
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-60,-40})));
  Modelica.Electrical.Analog.Sources.SignalVoltage cellVoltage
    "Voltage calculated by the mESC"
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-60,40})));
  Modelica.Blocks.Tables.CombiTable1Ds lookup_SOC_OCV(
    tableOnFile=false,
    table=cellParameters.SOC_OCV,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    "Open circuit voltage dependent state of charge"
    annotation (Placement(transformation(extent={{60,30},{40,50}})));
  Modelica.Blocks.Tables.CombiTable1Ds lookup_Ri(
    tableOnFile=false,
    table=cellParameters.R_i,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    "Dynamic R_i"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Continuous.LimIntegrator IntegratorSOC(
    outMax=1,
    outMin=0,
    y_start=SOC_init,
    k=1/(no_p*C_N*3600))
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Blocks.Math.Gain packScale(k=no_s/no_p)
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Math.Gain voltageScale(k=no_s)
    annotation (Placement(transformation(extent={{20,30},{0,50}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-90,20})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
    C=Ch_cell*no_s*no_p,
    T(start=298.15, fixed=true)) "Cell heat capacitor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-80})));
  Utilities.Interfaces.ControlBus controlBus annotation (Placement(
        transformation(extent={{40,-120},{80,-80}})));
protected
  VehicleInterfaces.Interfaces.BatteryBus batteryBus
    annotation (Placement(transformation(extent={{10,-90},{30,-70}}), iconTransformation(extent={{0,-96},{20,-76}})));
equation
  connect(ground.p, pin_n) annotation (Line(
      points={{-90,-81},{-90,-60},{-100,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(cellVoltage.p, pin_p) annotation (Line(
      points={{-60,50},{-60,60},{-100,60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(cellVoltage.n,variableResistor. p) annotation (Line(
      points={{-60,30},{-60,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(variableResistor.n,sensorCurrent. n) annotation (Line(
      points={{-60,-10},{-60,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sensorCurrent.i,IntegratorSOC. u) annotation (Line(
      points={{-49,-40},{38,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(IntegratorSOC.y,lookup_SOC_OCV. u) annotation (Line(
      points={{61,-40},{80,-40},{80,40},{62,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(IntegratorSOC.y, SOC) annotation (Line(
      points={{61,-40},{80,-40},{80,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(current,sensorCurrent. i) annotation (Line(
      points={{110,-60},{0,-60},{0,-40},{-49,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(packScale.y,variableResistor. R) annotation (Line(
      points={{-1,0},{-50,0},{-50,-2.02067e-15},{-48,-2.02067e-15}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(voltageScale.u,lookup_SOC_OCV. y[1]) annotation (Line(
      points={{22,40},{39,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(voltageScale.y,cellVoltage. v) annotation (Line(
      points={{-1,40},{-48,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(voltageSensor.v, voltage) annotation (Line(
      points={{-79,20},{-74,20},{-74,70},{90,70},{90,60},{110,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatCapacitor.port,variableResistor. heatPort) annotation (Line(
      points={{-50,-80},{-40,-80},{-40,-54},{-80,-54},{-80,0},{-76,0},{-76,1.77636e-15},{-70,1.77636e-15}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatPort,heatCapacitor. port) annotation (Line(
      points={{-40,-100},{-40,-80},{-50,-80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(lookup_Ri.u, lookup_SOC_OCV.u) annotation (Line(points={{62,0},{80,0},{80,40},{62,40}},
                            color={0,0,127}));
  connect(lookup_Ri.y[1], packScale.u)
    annotation (Line(points={{39,0},{22,0}},  color={0,0,127}));
  connect(pin_n, sensorCurrent.p) annotation (
      Line(points={{-100,-60},{-60,-60},{-60,-50}}, color={0,0,255}));
  connect(voltageSensor.p, pin_p) annotation (
      Line(points={{-90,30},{-90,60},{-100,60}}, color={0,0,255}));
  connect(voltageSensor.n, pin_n) annotation (
      Line(points={{-90,10},{-90,-60},{-100,-60}}, color={0,0,255}));
  connect(batteryBus, controlBus.batteryBus) annotation (Line(
      points={{20,-80},{20,-99.9},{60.1,-99.9}},
      color={255,204,51},
      thickness=0.5));
  connect(IntegratorSOC.y, batteryBus.SOC) annotation (Line(points={{61,-40},{80,-40},{80,-80},{20,-80}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(voltageScale.y, batteryBus.voltage) annotation (Line(points={{-1,40},{-10,40},{-10,-82},{20,-82},{20,-80}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  connect(sensorCurrent.i, batteryBus.current)
    annotation (Line(points={{-49,-40},{0,-40},{0,-80},{20,-80}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(graphics={
        Text(
          extent={{-90,0},{110,-30}},
          textColor={0,0,0},
          textString="%no_s%s %no_p%pin_p"),
        Line(
          points={{-100,-60},{-100,-96},{-100,-108}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
        Line(
          points={{-120,-108},{-80,-108}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
        Line(
          points={{-112,-116},{-88,-116}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
        Line(
          points={{-106,-124},{-94,-124}},
          color={0,0,255},
          smooth=Smooth.None,
          visible=includeGround),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{70,34},{-36,18},{-36,-60},{70,-44},{70,34}},
          lineColor={85,85,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-36,18},{-70,44},{-70,-34},{-36,-60},{-36,18}},
          lineColor={85,85,255},
          fillColor={215,236,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-70,44},{36,60},{70,34},{-36,18},{-70,44}},
          lineColor={85,85,255},
          fillColor={215,236,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,34},{-40,30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-52,38},{-40,32}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-52,40},{-40,36}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,48},{50,44}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{38,52},{50,46}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,54},{50,50}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-38,38},{-28,34}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,40},{-12,36}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,42},{2,38}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{8,44},{18,40}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{24,46},{34,42}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name")}), Documentation(info="<html>
<p>
A functional battery with an equivalent electrical circuit model to model obtain
a&nbsp;good tradeoff between simulation speed and modeling accuracy.
</p>
<p>
The electrical circuit consists of an ideal voltage source in series with an internal
resistance, thus forming the terminal voltage of the cell. Both the internal voltage
and resistance depend on the battery state of charge <code>SOC</code>, a&nbsp;normalized
indicator for the amount of charge stored in the battery.
Lookup tables <code>SOC_OCV</code> and <code>R_i</code> are employed, respectively,
to characterize this variation, but are limited to room temperature values.
</p>
</html>"));
end SimpleBattery;
