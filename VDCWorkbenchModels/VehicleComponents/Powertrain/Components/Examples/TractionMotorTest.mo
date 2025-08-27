within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.Examples;
model TractionMotorTest
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,0})));
  Modelica.Blocks.Sources.Constant const(k=320) annotation (Placement(
        transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
      Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=160,
    duration=5,
    startTime=2) annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=100,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  ParameterizedModels.ROMOTractionMotor rOMOTractionMotor
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(signalVoltage.n, rOMOTractionMotor.pin_p) annotation (Line(
        points={{-40,10},{-10,10},{-10,6},{-0.2,6}}, color={0,0,255}));
  connect(signalVoltage.p, rOMOTractionMotor.pin_n) annotation (Line(
        points={{-40,-10},{-10,-10},{-10,-6},{0,-6}}, color={0,0,
          255}));
  connect(const.y, signalVoltage.v)
    annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(ground.p, signalVoltage.p) annotation (Line(points={{-30,-20},{-30,-10},{-40,-10}},
        color={0,0,255}));
  connect(ramp.y, rOMOTractionMotor.torque_dem) annotation (Line(
        points={{-19,-60},{4,-60},{4,-12}},color={0,0,127}));
  connect(rOMOTractionMotor.torque, inertia.flange_a)
    annotation (Line(points={{20,0},{40,0}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=50));
end TractionMotorTest;
