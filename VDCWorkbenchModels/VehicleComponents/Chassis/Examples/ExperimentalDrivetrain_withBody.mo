within VDCWorkbenchModels.VehicleComponents.Chassis.Examples;
model ExperimentalDrivetrain_withBody
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Velocity v_Start=0.1 "Initial velocity";

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.TimeTable tMTorqueDemand(
    table=[0.0,0.0; 5,160; 10,160; 12,-160; 20,-160])
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Constant steeringWheelAngleDemand(k=0)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Mechanics.Rotational.Sources.Position position(w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Data.ROMOParameters data annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Components.SimpleAxisFront simpleAxisFront(
    R0=data.R0,
    s=data.s,
    N=data.m_vehicle*9.81/4,
    vAdhesion=data.vAdhesion,
    vSlide=data.vSlide,
    mu_A=data.mu_A,
    mu_S=data.mu_S,
    J_wheel=data.J_wheel,
    J_steer=data.J_steer,
    v_long=v_Start,
    trackWidth=data.trackWidth,
    wheelLeft(phi_roll(fixed=true)),
    wheelRight(phi_roll(fixed=true), w_roll(fixed=true))) annotation (Placement(transformation(extent={{0,0},{20,20}})));
  inner PlanarMechanics.PlanarWorld planarWorld(constantGravity={0,0})
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Components.CarBody carBody(
    wheelBase=data.wheelBase,
    Jz=data.Jz_vehicle,
    m=data.m_body,
    v_long=v_Start,
    body(
      r(each fixed=true),
      v(each fixed=true),
      phi(fixed=true),
      w(fixed=true))) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(tMTorqueDemand.y, torque.tau)
    annotation (Line(points={{-59,30},{-42,30}}, color={0,0,127}));
  connect(steeringWheelAngleDemand.y,from_deg. u)
    annotation (Line(points={{-59,70},{-52,70}}, color={0,0,127}));
  connect(from_deg.y,position. phi_ref)
    annotation (Line(points={{-29,70},{-22,70}}, color={0,0,127}));
  connect(torque.flange, simpleAxisFront.flangeDifferential)
    annotation (Line(points={{-20,30},{6,30},{6,20}}, color={0,0,0}));
  connect(position.flange, simpleAxisFront.flangeSteeringWheel)
    annotation (Line(points={{0,70},{14,70},{14,20}},      color={0,0,0}));
  connect(carBody.frameAxleFront, simpleAxisFront.frameChassis) annotation (Line(
      points={{10,-20},{10,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(
      StopTime=20,
      __Dymola_Algorithm="Dassl"));
end ExperimentalDrivetrain_withBody;
