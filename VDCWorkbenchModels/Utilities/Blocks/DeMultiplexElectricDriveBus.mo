within VDCWorkbenchModels.Utilities.Blocks;
block DeMultiplexElectricDriveBus "DeMultiplexer block for electric drive bus"
  extends Modelica.Blocks.Icons.Block;
public
  Interfaces.ElectricDriveBus electricDriveBus "Signal bus of electric drive" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput angularVelocity annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Modelica.Blocks.Interfaces.RealOutput torque annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput mechanicPower annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput electricPower annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput powerLoss annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput I_q annotation (Placement(transformation(extent={{100,-110},{120,-90}})));
equation
  connect(angularVelocity, electricDriveBus.angularVelocity) annotation (Line(points={{110,100},{70,100},{70,6},{-100,6},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(torque, electricDriveBus.torque) annotation (Line(points={{110,60},{72,60},{72,4},{-100,4},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(mechanicPower, electricDriveBus.mechanicPower) annotation (Line(points={{110,20},{74,20},{74,2},{-100,2},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(electricPower, electricDriveBus.electricPower) annotation (Line(points={{110,-20},{74,-20},{74,0},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(powerLoss, electricDriveBus.powerLoss) annotation (Line(points={{110,-60},{72,-60},{72,-2},{-100,-2},{-100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-12,3},{-12,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(I_q, electricDriveBus.I_q) annotation (Line(points={{110,-100},{70,-100},{70,-4},{-100,-4},{-100,0}}, color={0,0,127}), Text(
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
end DeMultiplexElectricDriveBus;
