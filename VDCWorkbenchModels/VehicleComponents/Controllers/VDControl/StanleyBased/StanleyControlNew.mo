within VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.StanleyBased;
model StanleyControlNew "Classic Stanley lateral control law"
  extends BaseClasses.BaseStanleyNew;
  parameter Real k = 5 "Stanley gain";
  parameter Modelica.Units.SI.Velocity v_eps = 0.1  "Small velocity to avoid division by zero";
  parameter Real k_d_yaw = 0.14 "Factor for yaw rate related damping";
  parameter Real k_d_steer = 0.0 "Factor penalizing rate of steering angle change";

  parameter Modelica.Units.SI.Angle deltaMax = 0.3 "Steering saturation";

  parameter Real K_vctrl = 0.5 "Gain of torque control" annotation (Dialog(group="Torque controller"));
  parameter Modelica.Units.SI.Torque tauDriveMax = 0.3 "Torque limit" annotation (Dialog(group="Torque controller"));

  parameter Modelica.Units.SI.Mass m = 7.151 "Vehicle mass" annotation(Dialog(group="Vehicle parameters"));
  parameter Modelica.Units.SI.Length lf = 0.1805 "Distance of CoG to front axle" annotation(Dialog(group="Vehicle parameters"));
  parameter Modelica.Units.SI.Length lr = 0.1805 "Distance of CoG to rear axle" annotation(Dialog(group="Vehicle parameters"));
  parameter Real C_Tire = 150 "Tire stiffnes for slip angle compensation" annotation(Dialog(group="Vehicle parameters"));

  StanleyCore stanleyCore annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Nonlinear.Limiter limitDelta(
    final uMax=deltaMax,
    final uMin=-deltaMax) annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Blocks.Nonlinear.Limiter limitTorque(
    final uMax=tauDriveMax,
    final uMin=-tauDriveMax) annotation (Placement(transformation(extent={{70,30},{90,50}})));
equation

  connect(x_path, stanleyCore.x_path) annotation (Line(points={{-60,90},{-40,90},{-40,20},{-22,20}},color={0,0,127}));
  connect(y_path, stanleyCore.y_path) annotation (Line(points={{-60,70},{-44,70},{-44,16},{-22,16}},color={0,0,127}));
  connect(psi_path, stanleyCore.psi_path) annotation (Line(points={{-60,50},{-44,50},{-44,12},{-22,12}},color={0,0,127}));
  connect(v_path, stanleyCore.v_path) annotation (Line(points={{-60,30},{-46,30},{-46,8},{-22,8}},  color={0,0,127}));
  connect(kappa_path, stanleyCore.kappa_path) annotation (Line(points={{-60,10},{-48,10},{-48,4},{-22,4}},    color={0,0,127}));
  connect(xveh, stanleyCore.xveh) annotation (Line(points={{-60,-10},{-48,-10},{-48,-4},{-22,-4}},
                                                                                            color={0,0,127}));
  connect(yveh, stanleyCore.yveh) annotation (Line(points={{-60,-30},{-46,-30},{-46,-8},{-22,-8}},
                                                                                              color={0,0,127}));
  connect(psiveh, stanleyCore.psiveh) annotation (Line(points={{-60,-50},{-44,-50},{-44,-12},{-22,-12}},
                                                                                                color={0,0,127}));
  connect(yaw_rate, stanleyCore.yaw_rate) annotation (Line(points={{-60,-70},{-42,-70},{-42,-16},{-22,-16}},
                                                                                                    color={0,0,127}));
  connect(vveh_long, stanleyCore.vveh_long) annotation (Line(points={{-60,-90},{-40,-90},{-40,-20},{-22,-20}},
                                                                                                      color={0,0,127}));
  connect(stanleyCore.delta, limitDelta.u) annotation (Line(points={{22,16},{50,16},{50,80},{68,80}}, color={0,0,127}));
  connect(limitDelta.y, delta) annotation (Line(points={{91,80},{110,80}},                 color={0,0,127}));
  connect(stanleyCore.torque, limitTorque.u) annotation (Line(points={{22,8},{60,8},{60,40},{68,40}},   color={0,0,127}));
  connect(limitTorque.y, torque) annotation (Line(points={{91,40},{110,40}},                 color={0,0,127}));
  annotation (
    Icon(
      graphics={
        Polygon(
          points={{-100,-100},{-100,100},{100,100},{100,-100},{-100,-100}},
          lineColor={28,108,200},
          fillColor={0,140,72},
          fillPattern=FillPattern.Forward,
          pattern=LinePattern.DashDot),
        Text(
          extent={{-100,60},{100,30}},
          textColor={255,255,255},
          textString="Stanley")}));
end StanleyControlNew;
