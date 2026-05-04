within VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.BaseClasses;
partial model BaseStanleyNew "Basic interfaces for Stanley-based controller"

  Utilities.Interfaces.ControlBus controlBus annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={100,0})));
  Modelica.Blocks.Interfaces.RealOutput torque "Summarized propulsion torque"
    annotation (Placement(transformation(extent={{100,30},{120,50}}), iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput delta
    annotation (Placement(transformation(extent={{100,70},{120,90}}), iconTransformation(extent={{100,70},{120,90}})));
protected
  Utilities.Interfaces.MotionDemandBus motionDemandBus
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  VehicleInterfaces.Interfaces.ChassisBus chassisBus
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Interfaces.RealOutput xveh "Measured vehicle position, x"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-60,-10})));
  Modelica.Blocks.Interfaces.RealOutput yveh "Measured vehicle position, y"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-60,-30})));
  Modelica.Blocks.Interfaces.RealOutput psiveh "Measured vehicle position, psi"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-60,-50})));
  Modelica.Blocks.Interfaces.RealOutput vveh_long "Absolute longitudinal vehicle speed"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, rotation=180, origin={-60,-90})));
  Modelica.Blocks.Interfaces.RealOutput psi_path "Position psi of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,50})));
  Modelica.Blocks.Interfaces.RealOutput x_path "Position x of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,90})));
  Modelica.Blocks.Interfaces.RealOutput y_path "Position y of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,70})));
  Modelica.Blocks.Interfaces.RealOutput v_path "Velocity v at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,30})));
  Modelica.Blocks.Interfaces.RealOutput kappa_path "Curvature kappa of path at current arc length value"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,10})));
  Modelica.Blocks.Interfaces.RealOutput yaw_rate "Yaw rate of chassis"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-60,-70})));

equation
  connect(motionDemandBus, controlBus.motionDemandBus) annotation (Line(
        points={{-90,90},{-100,90},{-100,-100},{90,-100},{90,-0.1},{100.1,-0.1}},
        color={255,204,51},
        thickness=0.5));
  connect(xveh, chassisBus.position_x) annotation (Line(
        points={{-60,-10},{-86,-10},{-86,-82},{-90,-82},{-90,-90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,-2},{-2,-5}},
        horizontalAlignment=TextAlignment.Right));
  connect(yveh, chassisBus.position_y) annotation (Line(points={{-60,-30},{-84,-30},{-84,-84},{-90,-84},{-90,-90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,-2},{-2,-5}},
        horizontalAlignment=TextAlignment.Right));
  connect(psiveh, chassisBus.yawAngle) annotation (Line(points={{-60,-50},{-82,-50},{-82,-86},{-90,-86},{-90,-90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,-2},{-2,-5}},
        horizontalAlignment=TextAlignment.Right));
  connect(chassisBus, controlBus.chassisBus) annotation (Line(
        points={{-90,-90},{-100,-90},{-100,-100},{90,-100},{90,-0.1},{100.1,-0.1}},
        color={255,204,51},
        thickness=0.5));
  connect(vveh_long, chassisBus.longitudinalVelocity) annotation (Line(points={{-60,-90},{-90,-90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,-2},{-2,-5}},
        horizontalAlignment=TextAlignment.Right));
  connect(psi_path, motionDemandBus.psi_path) annotation (Line(points={{-60,50},{-82,50},{-82,86},{-90,86},{-90,90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,2},{-2,5}},
        horizontalAlignment=TextAlignment.Right));
  connect(x_path, motionDemandBus.x_path) annotation (
      Line(
        points={{-60,90},{-90,90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,2},{-2,5}},
        horizontalAlignment=TextAlignment.Right));
  connect(y_path, motionDemandBus.y_path) annotation (Line(points={{-60,70},{-80,70},{-80,88},{-86,88},{-86,90},{-90,90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,2},{-2,5}},
        horizontalAlignment=TextAlignment.Right));
  connect(v_path, motionDemandBus.v_path) annotation (Line(points={{-60,30},{-84,30},{-84,84},{-90,84},{-90,90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,2},{-2,5}},
        horizontalAlignment=TextAlignment.Right));
  connect(kappa_path, motionDemandBus.kappa_path) annotation (Line(points={{-60,10},{-86,10},{-86,82},{-90,82},{-90,90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,2},{-2,5}},
        horizontalAlignment=TextAlignment.Right));
  connect(yaw_rate, chassisBus.yawRate) annotation (
      Line(
        points={{-60,-70},{-80,-70},{-80,-88},{-86,-88},{-86,-90},{-90,-90}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{-2,-2},{-2,-5}},
        horizontalAlignment=TextAlignment.Right));
end BaseStanleyNew;
