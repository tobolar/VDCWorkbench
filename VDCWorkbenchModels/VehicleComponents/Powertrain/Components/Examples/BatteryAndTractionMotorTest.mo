within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.Examples;
model BatteryAndTractionMotorTest
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp ramp(
    height=160,
    duration=5,
    startTime=2) annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J=100,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ParameterizedModels.ROMOBatteryPack90s1p rOMOBatteryPack90s1p(
    includeGround=true) annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  ParameterizedModels.ROMOTractionMotor rOMOTractionMotor
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(ramp.y, rOMOTractionMotor.torque_dem) annotation (Line(
        points={{-19,-50},{4,-50},{4,-12}},color={0,0,127}));
  connect(rOMOTractionMotor.torque, inertia.flange_a)
    annotation (Line(points={{20,0},{40,0}}, color={0,0,0}));
  connect(rOMOBatteryPack90s1p.pin_p, rOMOTractionMotor.pin_p)
    annotation (Line(points={{-20,6},{-0.2,6}}, color={0,0,255}));
  connect(rOMOBatteryPack90s1p.pin_n, rOMOTractionMotor.pin_n)
    annotation (Line(points={{-20,-6},{0,-6}}, color={0,0,255}));
  annotation (
    experiment(
      StopTime=50));
end BatteryAndTractionMotorTest;
