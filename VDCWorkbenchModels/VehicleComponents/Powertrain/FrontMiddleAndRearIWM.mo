within VDCWorkbenchModels.VehicleComponents.Powertrain;
model FrontMiddleAndRearIWM "Powertrain with front middle drive and rear in-wheel drives"
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
    T=298.15);

  Components.ParameterizedModels.ROMOTractionMotorFront tractionMotorFM(
    final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{-40,50},{-60,30}})));
  Components.ParameterizedModels.ROMOTractionMotor tractionMotorRL(
    final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{-40,-30},{-60,-50}})));
  Components.ParameterizedModels.ROMOTractionMotor tractionMotorRR(
    final useHeatPort=useHeatPort) annotation (Placement(transformation(extent={{40,-30},{60,-50}})));
  Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(rotation=90,extent={{-20,-20},{20,20}},
        origin={100,80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,40})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flangeDriveFront "Flange of front drive" annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flangeWheelRL "Flange of rear left wheel" annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flangeWheelRR "Flange of rear right wheel" annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive electrical pin" annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative electrical pin" annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
protected
  Utilities.Interfaces.ElectricDriveControlBus electricMotorControlBusFM annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Utilities.Interfaces.ElectricDriveControlBus electricMotorControlBusRL annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Utilities.Interfaces.ElectricDriveControlBus electricMotorControlBusRR annotation (Placement(transformation(extent={{40,-20},{60,0}})));
equation
  connect(internalHeatPort, tractionMotorFM.heatPort) annotation (Line(points={{-100,-80},{-100,-60},{-80,-60},{-80,52},{-56,52},{-56,50}},
        color={191,0,0}));
  connect(internalHeatPort, tractionMotorRL.heatPort) annotation (Line(points={{-100,-80},{-100,-60},{-80,-60},{-80,-20},{-56,-20},{-56,-30}},
        color={191,0,0}));
  connect(internalHeatPort, tractionMotorRR.heatPort) annotation (Line(points={{-100,-80},{-100,-60},{-80,-60},{-80,-20},{56,-20},{56,-30}},
        color={191,0,0}));
  connect(tractionMotorRL.torque, flangeWheelRL) annotation (Line(points={{-60,-40},{-100,-40}}, color={0,0,0}));
  connect(tractionMotorRR.torque, flangeWheelRR) annotation (Line(points={{60,-40},{100,-40}}, color={0,0,0}));
  connect(tractionMotorFM.torque, flangeDriveFront) annotation (Line(points={{-60,40},{-100,40}},
        color={0,0,0}));
  connect(tractionMotorRL.electricMotorBus, controlBus.electricMotorBusRL) annotation (Line(
      points={{-60,-34},{-70,-34},{-70,0},{70,0},{70,80.1},{99.9,80.1}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotorFM.electricMotorBus, controlBus.electricMotorBusFM) annotation (Line(
      points={{-60,46},{-70,46},{-70,80},{99.9,80},{99.9,80.1}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotorRR.electricMotorBus, controlBus.electricMotorBusRR) annotation (Line(
      points={{60,-34},{70,-34},{70,80.1},{99.9,80.1}},
      color={255,204,51},
      thickness=0.5));
  connect(electricMotorControlBusFM, controlBus.electricMotorControlBusFM) annotation (Line(
      points={{-50,70},{-50,80.1},{99.9,80.1}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotorFM.torque_dem, electricMotorControlBusFM.torque) annotation (Line(points={{-44,52},{-44,70},{-50,70}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Left));
  connect(electricMotorControlBusRL, controlBus.electricMotorControlBusRL) annotation (Line(
      points={{-50,-10},{-50,0},{70,0},{70,80.1},{99.9,80.1}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotorRL.torque_dem, electricMotorControlBusRL.torque) annotation (Line(points={{-44,-28},{-44,-10},{-50,-10}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(electricMotorControlBusRR, controlBus.electricMotorControlBusRR) annotation (Line(
      points={{50,-10},{50,0},{70,0},{70,80.1},{99.9,80.1}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotorRR.torque_dem, electricMotorControlBusRR.torque) annotation (Line(points={{44,-28},{44,-10},{50,-10}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tractionMotorFM.pin_p, pin_p) annotation (Line(points={{-39.8,34},{0,34},{0,-100}}, color={0,0,255}));
  connect(tractionMotorRL.pin_p, pin_p) annotation (Line(points={{-39.8,-46},{0,-46},{0,-100}}, color={0,0,255}));
  connect(tractionMotorRR.pin_p, pin_p) annotation (Line(points={{39.8,-46},{0,-46},{0,-100}}, color={0,0,255}));
  connect(tractionMotorFM.pin_n, pin_n) annotation (Line(points={{-40,46},{20,46},{20,-80},{60,-80},{60,-100}}, color={0,0,255}));
  connect(tractionMotorRL.pin_n, pin_n) annotation (Line(points={{-40,-34},{20,-34},{20,-80},{60,-80},{60,-100}}, color={0,0,255}));
  connect(tractionMotorRR.pin_n, pin_n) annotation (Line(points={{40,-34},{20,-34},{20,-80},{60,-80},{60,-100}}, color={0,0,255}));

  annotation (
    Icon(
      graphics={
        Line(
          points={{0,18},{0,-80},{60,-80},{60,-100}},
          color={0,0,255}),
        Line(
          points={{0,-100},{0,-60},{0,-40},{20,-40}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{0,-100},{0,-60},{0,-40},{-20,-40}},
          color={0,0,255},
          smooth=Smooth.Bezier),
        Line(
          points={{-22,40},{-100,40}},
          color={0,0,0}),
        Line(
          points={{-66,-40},{-100,-40}},
          color={0,0,0}),
        Line(
          points={{100,-40},{66,-40}},
          color={0,0,0}),
        Text(
          extent={{-150,110},{150,70}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{26,54},{18,26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{-26,54},{18,26}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Polygon(
          points={{-26,20},{-20,20},{-10,34},{10,34},{20,20},{26,20},{26,14},{-26,14},{-26,20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,-26},{-26,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{-70,-26},{-26,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Polygon(
          points={{-70,-60},{-64,-60},{-54,-46},{-34,-46},{-24,-60},{-18,-60},{-18,-66},{-70,-66},{-70,-60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,-26},{20,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{26,-26},{70,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,128,255}),
        Polygon(
          points={{18,-60},{24,-60},{34,-46},{54,-46},{64,-60},{70,-60},{70,-66},{18,-66},{18,-60}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-2},{-40,-2},{-50,-4},{-56,-10},{-58,-18},{-58,-90},{-68,-90},{-50,-110},{-32,-90},{-42,-90},{-42,-20},{-40,-18},{30,-18},{30,-2}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid,
          visible=useHeatPort)}),
    Documentation(info="<html>
<p>
Powertrain with three traction motors. One motor is to be connected to the drive flange
of the front vehicle axle. The remaining two motors drive rear axle wheels, each on one side.
</p>
</html>"));
end FrontMiddleAndRearIWM;
