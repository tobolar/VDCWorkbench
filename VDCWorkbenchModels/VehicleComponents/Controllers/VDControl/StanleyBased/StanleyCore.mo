within VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.StanleyBased;
model StanleyCore "Classic Stanley lateral control law"
  extends Modelica.Blocks.Icons.Block;
  import Modelica.Math.{cos,sin,atan,atan2};

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

public
  Real e_lat;
  Real e_psi;
  Real delta_raw;
  Real dpsi;
  Real psi_ss;

  Modelica.Blocks.Interfaces.RealOutput torque "Summarized propulsion torque"
    annotation (Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput delta
    annotation (Placement(transformation(extent={{100,90},{120,110}}),iconTransformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealInput xveh "Measured vehicle position, x"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealInput yveh "Measured vehicle position, y"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-110,-40})));
  Modelica.Blocks.Interfaces.RealInput psiveh "Measured vehicle position, psi"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealInput vveh_long "Absolute longitudinal vehicle speed"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-110,-100})));
  Modelica.Blocks.Interfaces.RealInput psi_path "Position psi of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,60})));
  Modelica.Blocks.Interfaces.RealInput x_path "Position x of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,100})));
  Modelica.Blocks.Interfaces.RealInput y_path "Position y of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,80})));
  Modelica.Blocks.Interfaces.RealInput v_path "Velocity v at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,40})));
  Modelica.Blocks.Interfaces.RealInput kappa_path "Curvature kappa of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,20})));
  Modelica.Blocks.Interfaces.RealInput yaw_rate "Yaw rate of chassis"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-80})));

  Modelica.Blocks.Interfaces.RealOutput yawRate_path
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-60}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-60})));
  Modelica.Blocks.Interfaces.RealOutput x_front
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,20}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,20})));
  Modelica.Blocks.Interfaces.RealOutput y_front
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-20}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-20})));
  Modelica.Blocks.Interfaces.RealOutput delta_yaw
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-100}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,-100})));

equation
  // set coordinates to center of front axle
  x_front = xveh + lf*cos(psiveh);
  y_front = yveh + lf*sin(psiveh);

  // calc errors
  e_lat = -(x_path - x_front)*sin(psi_path) + (y_path - y_front)*cos(psi_path);

  // Slip angle compensation
  yawRate_path = vveh_long * kappa_path;
  psi_ss = m / (C_Tire * (1 + lf/lr)) * vveh_long * yawRate_path;
  dpsi = psi_path - psiveh - psi_ss;
  e_psi = atan2(sin(dpsi), cos(dpsi));

  // yaw rate damping
  delta_yaw = k_d_yaw * (yawRate_path - yaw_rate);

  // steer response damping (not defined for model without steering dynamics)
  //delta_steer =  k_d_steer * (delta_km1 - delta_km2);

  // Stanley control law
  delta_raw = e_psi + atan(k * e_lat/(vveh_long + v_eps)) + delta_yaw; // + delta_steer;
  delta = delta_raw;

  torque = K_vctrl*(v_path - vveh_long);

  annotation (
    Icon(
      graphics={
        Text(
          extent={{-100,-10},{100,-40}},
          textColor={0,0,0},
          textString="Stanley")}));
end StanleyCore;
