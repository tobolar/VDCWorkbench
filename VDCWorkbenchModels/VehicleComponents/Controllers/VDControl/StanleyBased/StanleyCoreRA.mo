within VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.StanleyBased;
model StanleyCoreRA "Rear axle Stanley lateral control law"
  extends Modelica.Blocks.Icons.Block;
  import Modelica.Math.{cos,sin,atan,atan2};

  parameter Real k = 1 "Stanley gain";
  parameter Modelica.Units.SI.Velocity v_eps = 0.1  "Small velocity to avoid division by zero";
  parameter Real k_d_yaw = 0.14 "Factor for yaw rate related damping";
  parameter Real k_d_steer = 0.0 "Factor penalizing rate of steering angle change";

  parameter Modelica.Units.SI.Angle deltaMax = 0.3 "Steering saturation";

  parameter Real K_vctrl = 0.5 "P gain of velocity controller" annotation (Dialog(group="Torque controller"));
  parameter Modelica.Units.SI.Torque tauDriveMax = 0.3 "Torque limit" annotation (Dialog(group="Torque controller"));

  parameter Modelica.Units.SI.Mass m = 7.151 "Vehicle mass" annotation(Dialog(group="Vehicle parameters"));
  parameter Modelica.Units.SI.Length lf = 0.1805 "Distance of CoG to front axle" annotation(Dialog(group="Vehicle parameters"));
  parameter Modelica.Units.SI.Length lr = 0.1805 "Distance of CoG to rear axle" annotation(Dialog(group="Vehicle parameters"));
  parameter Real C_Tire = 150 "Tire stiffnes for slip angle compensation" annotation(Dialog(group="Vehicle parameters"));

protected
  parameter Modelica.Units.SI.Length wheelbase = lf + lr;

public
  Real e_lat;
  Real xf_ref, yf_ref, psi_f_ref, delta_kappa_ref;
  Real theta_r_star;
  Real delta_raw;
  Real delta_yaw_RA;
  Real delta_ff;
  Real theta_ss_r;
  Real theta_ss_f;

  Modelica.Blocks.Interfaces.RealOutput delta
    annotation (Placement(transformation(extent={{100,70},{120,90}}), iconTransformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealInput vveh_long "Absolute longitudinal vehicle speed"
    annotation (Placement(transformation(extent={{20,-20},{-20,20}}, rotation=180, origin={-120,10}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,10})));
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

  Modelica.Blocks.Interfaces.RealInput yawRate_path
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.RealInput x_front
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-20})));
  Modelica.Blocks.Interfaces.RealInput y_front
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-50})));
  Modelica.Blocks.Interfaces.RealInput delta_yaw
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-80})));
  Modelica.Blocks.Interfaces.RealInput psiveh
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-80,-120})));
  Modelica.Blocks.Interfaces.RealInput kappa_ff
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,40})));

equation

  // set coordinates to center of front axle
  // input_from_stanley_x_front = xveh + lf*cos(psiveh);
  // input_from_stanley_y_front = yveh + lf*sin(psiveh);
  // // input_from_motionDemandBus.kappa_ff
  // // input_from_Bus.vveh_long
  // // input_from_Bus.x_path
  // // input_from_Bus.y_path
  // // input_from_Bus.psi_path

  // input_from_stanley_yawRate_path  = vveh_long * kappa_path;

  theta_ss_r = m / (C_Tire * (1 + lr/lf)) * vveh_long * yawRate_path;
  theta_ss_f = m / (C_Tire * (1 + lf/lr)) * vveh_long * yawRate_path;

  xf_ref = x_path + wheelbase * cos(psi_path + theta_ss_r);
  yf_ref = y_path + wheelbase * sin(psi_path + theta_ss_r);

  delta_kappa_ref = atan( (wheelbase*(yawRate_path / max(1e-6, vveh_long)) - sin(theta_ss_r)) / cos(theta_ss_r));
  psi_f_ref = psi_path + theta_ss_r + delta_kappa_ref;

  e_lat = -(xf_ref - x_front)*sin(psi_f_ref) + (yf_ref - y_front)*cos(psi_f_ref);

  theta_r_star = atan2( sin(psi_path + theta_ss_r - psiveh), cos(psi_path + theta_ss_r - psiveh));

  // feed forward control
  delta_ff = atan((wheelbase*kappa_ff - sin(theta_ss_r)) / cos(theta_ss_r));

  // yaw rate damping
  // delta_yaw = k_d_yaw * (yawRate_path - yaw_rate) + theta_ss_f;
  delta_yaw_RA  = delta_yaw + theta_ss_f;

  // steer response damping (not defined for model without steering dynamics)
  //delta_steer = k_d_steer * (delta_km1 - delta_km2);

  // Rear axle Stanley control law
  delta_raw = delta_ff + theta_r_star + atan(k * e_lat/(vveh_long + v_eps)) + delta_yaw_RA; // + delta_steer
  delta = delta_raw;

  //torque = K_vctrl*(v_path - vveh_long);

  annotation (
    Icon(
      graphics={
        Text(
          extent={{-100,20},{100,-40}},
          textColor={0,0,0},
          textString="rear axle
Stanley")}));
end StanleyCoreRA;
