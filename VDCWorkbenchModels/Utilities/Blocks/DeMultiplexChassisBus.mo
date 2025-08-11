within VDCWorkbenchModels.Utilities.Blocks;
block DeMultiplexChassisBus "DeMultiplexer block for chassis bus"
  extends Modelica.Blocks.Icons.Block;
  VehicleInterfaces.Interfaces.ChassisBus chassisBus "Signal bus of chassis"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput steeringWheelAngle annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput longitudinalVelocity annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput longitudinalAcceleration annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput lateralAcceleration annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput yawRate annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput sideSlipAngle annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
equation
  connect(steeringWheelAngle, chassisBus.steeringWheelAngle) annotation (Line(points={{110,100},{68,100},{68,4},{-100,4},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(longitudinalVelocity, chassisBus.longitudinalVelocity) annotation (Line(points={{110,60},{70,60},{70,2},{-100,2},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(longitudinalAcceleration, chassisBus.longitudinalAcceleration) annotation (Line(points={{110,20},{72,20},{72,0},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(lateralAcceleration, chassisBus.lateralAcceleration) annotation (Line(points={{110,-20},{72,-20},{72,-2},{-100,-2},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(yawRate, chassisBus.yawRate) annotation (Line(points={{110,-60},{70,-60},{70,-4},{-100,-4},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sideSlipAngle, chassisBus.sideSlipAngle) annotation (Line(points={{110,-100},{68,-100},{68,-6},{-100,-6},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(graphics={
        Line(
          points={{-100,0},{-40,0},{40,100},{100,100}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(
          points={{-100,0},{-40,0},{40,60},{100,60}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(
          points={{-100,0},{-40,0},{40,20},{100,20}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(
          points={{-100,0},{-40,0},{40,-20},{100,-20}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(
          points={{-100,0},{-40,0},{40,-60},{100,-60}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(
          points={{-100,0},{-40,0},{40,-100},{100,-100}},
          color={0,0,127},
          smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
The input bus connector is <strong>split up</strong> into output signal connectors.
</p>
</html>"));
end DeMultiplexChassisBus;
