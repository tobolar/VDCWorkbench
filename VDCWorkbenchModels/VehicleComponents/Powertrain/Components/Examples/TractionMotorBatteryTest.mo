within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.Examples;
model TractionMotorBatteryTest
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.TimeTable timeTable(
    table=[0.0,0.0; 10,20; 20,20; 30,0; 100,0],
    startTime=2) annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J = 100,
    stateSelect=StateSelect.prefer,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ParameterizedModels.ROMOTractionMotor rOMOTractionMotor
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  ParameterizedModels.ROMOBatteryPack90s1pAging rOMOBatteryPack90s1pAging(
    SOC_init=0.8,
    includeHeatPort=true,
    includeGround=true)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
    final T=298.15)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
equation
  connect(timeTable.y, rOMOTractionMotor.torque_dem)
    annotation (Line(points={{-59,-60},{4,-60},{4,-12}}, color={0,0,127}));
  connect(rOMOTractionMotor.torque, inertia.flange_a)
    annotation (Line(points={{20,0},{40,0}}, color={0,0,0}));
  connect(rOMOBatteryPack90s1pAging.heatPort,fixedTemperature. port)
    annotation (Line(points={{-30,-10},{-30,-20},{-60,-20}},
        color={191,0,0}));
  connect(rOMOBatteryPack90s1pAging.pin_n, rOMOTractionMotor.pin_n) annotation (
     Line(points={{-20,-6},{0,-6}}, color={0,0,255}));
  connect(rOMOBatteryPack90s1pAging.pin_p, rOMOTractionMotor.pin_p) annotation (
     Line(points={{-20,6},{-0.2,6}}, color={0,0,255}));
  annotation (
    experiment(StopTime=50));
end TractionMotorBatteryTest;
