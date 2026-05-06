within VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.StanleyBased;
model RearAxleStanleyControlNew "Rear axle Stanley lateral control law"
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

  StanleyCore stanleyCore annotation (Placement(transformation(extent={{-30,-20},{10,20}})));
  Modelica.Blocks.Nonlinear.Limiter limitDelta(
    final uMax=deltaMax,
    final uMin=-deltaMax) annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Blocks.Nonlinear.Limiter limitTorque(
    final uMax=tauDriveMax,
    final uMin=-tauDriveMax) annotation (Placement(transformation(extent={{70,30},{90,50}})));
  StanleyCoreRA stanleyCoreRA annotation (Placement(transformation(extent={{30,44},{50,64}})));
equation

  connect(x_path, stanleyCore.x_path) annotation (Line(points={{-60,90},{-40,90},{-40,20},{-32,20}},color={0,0,127}));
  connect(y_path, stanleyCore.y_path) annotation (Line(points={{-60,70},{-42,70},{-42,16},{-32,16}},color={0,0,127}));
  connect(psi_path, stanleyCore.psi_path) annotation (Line(points={{-60,50},{-44,50},{-44,12},{-32,12}},color={0,0,127}));
  connect(v_path, stanleyCore.v_path) annotation (Line(points={{-60,30},{-46,30},{-46,8},{-32,8}},  color={0,0,127}));
  connect(kappa_path, stanleyCore.kappa_path) annotation (Line(points={{-60,10},{-48,10},{-48,4},{-32,4}},    color={0,0,127}));
  connect(xveh, stanleyCore.xveh) annotation (Line(points={{-60,-10},{-48,-10},{-48,-4},{-32,-4}},
                                                                                            color={0,0,127}));
  connect(yveh, stanleyCore.yveh) annotation (Line(points={{-60,-30},{-46,-30},{-46,-8},{-32,-8}},
                                                                                              color={0,0,127}));
  connect(psiveh, stanleyCore.psiveh) annotation (Line(points={{-60,-50},{-44,-50},{-44,-12},{-32,-12}},
                                                                                                color={0,0,127}));
  connect(yaw_rate, stanleyCore.yaw_rate) annotation (Line(points={{-60,-70},{-42,-70},{-42,-16},{-32,-16}},
                                                                                                    color={0,0,127}));
  connect(vveh_long, stanleyCore.vveh_long) annotation (Line(points={{-60,-90},{-40,-90},{-40,-20},{-32,-20}},
                                                                                                      color={0,0,127}));
  connect(limitDelta.y, delta) annotation (Line(points={{91,80},{110,80}},                 color={0,0,127}));
  connect(stanleyCore.torque, limitTorque.u) annotation (Line(points={{12,12},{60,12},{60,40},{68,40}}, color={0,0,127}));
  connect(limitTorque.y, torque) annotation (Line(points={{91,40},{110,40}},                 color={0,0,127}));
  connect(stanleyCoreRA.kappa_ff, motionDemandBus.kappa_ff) annotation (Line(points={{28,58},{0,58},{0,98},{-90,98},{-90,90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{2,2},{2,5}},
        horizontalAlignment=TextAlignment.Left));
  connect(stanleyCoreRA.delta, limitDelta.u) annotation (Line(points={{51,62},{60,62},{60,80},{68,80}}, color={0,0,127}));
  connect(x_path, stanleyCoreRA.x_path) annotation (Line(points={{-60,90},{-30,90},{-30,64},{29,64}}, color={0,0,127}));
  connect(y_path, stanleyCoreRA.y_path) annotation (Line(points={{-60,70},{-42,70},{-42,62},{29,62}}, color={0,0,127}));
  connect(psi_path, stanleyCoreRA.psi_path) annotation (Line(points={{-60,50},{-44,50},{-44,60},{29,60}}, color={0,0,127}));
  connect(vveh_long, stanleyCoreRA.vveh_long) annotation (Line(points={{-60,-90},{20,-90},{20,55},{28,55}},
                                                                                                      color={0,0,127}));
  connect(stanleyCore.x_front, stanleyCoreRA.x_front) annotation (Line(points={{12,4},{22,4},{22,52},{28,52}}, color={0,0,127}));
  connect(stanleyCore.y_front, stanleyCoreRA.y_front) annotation (Line(points={{12,-4},{24,-4},{24,49},{28,49}}, color={0,0,127}));
  connect(psiveh, stanleyCoreRA.psiveh) annotation (Line(points={{-60,-50},{32,-50},{32,42}},   color={0,0,127}));
  connect(stanleyCore.yawRate_path, stanleyCoreRA.yawRate_path) annotation (Line(points={{12,-12},{36,-12},{36,42}}, color={0,0,127}));
  connect(stanleyCore.delta_yaw, stanleyCoreRA.delta_yaw) annotation (Line(points={{12,-20},{26,-20},{26,46},{28,46}}, color={0,0,127}));
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
end RearAxleStanleyControlNew;
