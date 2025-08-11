within VDCWorkbenchModels.VehicleComponents.Powertrain.Components;
model TractionMotor "Traction motor"
  parameter Boolean useHeatPort = false "True, if HeatPort is enabled";

  replaceable parameter Data.ROMOTractionMotor data constrainedby VDCWorkbenchModels.Data.BaseRecords.TractionMotor
    "Set of common motor parameters" annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Modelica.Blocks.Math.Gain I_q(
    k=2/3*1/pMSM.p*1/pMSM.psi_PM)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Continuous.CriticalDamping iq_Filter(
    f=10,
    initType=Modelica.Blocks.Types.Init.SteadyState)
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));
  Modelica.Blocks.Sources.Constant Id(k=0)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  PMSM pMSM(
    useHeatPort=useHeatPort,
    p=data.p,
    V0=data.V0,
    psi_PM=data.psi_PM,
    fNominal=data.fNominal,
    INominal=data.INominal,
    wNominal=data.wNominal,
    tauNominal=data.tauNominal,
    J_r=data.J_r,
    R_s=data.R_s,
    L_1=data.L_1,
    tauFricRef=data.tauFricRef,
    kHyst=data.kHyst,
    kEddy=data.kEddy,
    kfric=data.kfric,
    InverterLossConstant=data.InverterLossConstant,
    InverterLossCoefficient=data.InverterLossCoefficient) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b torque
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput torque_dem
    "Torque demand to electric machine"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-120})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive electrical pin"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}), iconTransformation(extent={{-112,50},{-92,70}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative electrical pin"
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
    "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Utilities.Interfaces.ElectricDriveBus electricMotorBus annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={100,-60})));
equation
  connect(I_q.y,iq_Filter. u) annotation (Line(
      points={{-19,-20},{-2,-20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(I_q.u, torque_dem)
    annotation (Line(points={{-42,-20},{-60,-20},{-60,-120}},
        color={0,0,127}));
  connect(pMSM.flange, torque)
    annotation (Line(points={{80,0},{100,0}}, color={0,0,0}));
  connect(pin_p, pMSM.pin_p) annotation (Line(points={{-100,60},{50,60},{50,8},{60,8}},
        color={0,0,255}));
  connect(iq_Filter.y, pMSM.I_q)
    annotation (Line(points={{21,-20},{30,-20},{30,-4},{58,-4}}, color={0,0,127}));
  connect(Id.y, pMSM.I_d) annotation (Line(points={{21,20},{30,20},{30,4},{58,4}},
        color={0,0,127}));
  connect(pin_n, pMSM.pin_n) annotation (Line(points={{-100,-60},{-100,-50},{50,-50},{50,-8},{60,-8}},
        color={0,0,255}));
  connect(pMSM.heatPort, heatPort) annotation (Line(points={{62,-10},{62,-20},{60,-20},{60,-100}},
        color={191,0,0}));
  connect(pMSM.electricMotorBus, electricMotorBus) annotation (Line(
      points={{76,-10},{76,-20},{100,-20},{100,-60}},
      color={255,204,51},
      thickness=0.5));
  connect(I_q.y, electricMotorBus.I_q) annotation (Line(points={{-19,-20},{-10,-20},{-10,-60},{100,-60}}, color={0,0,127}), Text(
      string="%second",
      index=3,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  annotation (
    Icon(graphics={
      Rectangle(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        radius=20,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-50,-14},{-50,-88},{-60,-100}},
        smooth=Smooth.None),
      Rectangle(
        extent={{8,28},{82,-26}},
        lineColor={0,0,0},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={0,128,255}),
      Rectangle(
        extent={{8,28},{0,-26}},
        lineColor={0,0,0},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={128,128,128}),
      Rectangle(
        extent={{82,6},{100,-6}},
        lineColor={0,0,0},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={95,95,95}),
      Polygon(
        points={{0,-42},{14,-42},{26,-8},{58,-8},{74,-42},{88,-42},{88,-50},{0,
            -50},{0,-42}},
        lineColor={0,0,0},
        fillColor={0,0,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{28,-56},{44,-66}},
        lineColor={0,0,0},
        fillColor={0,255,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{44,-56},{60,-66}},
        lineColor={0,0,0},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid),
      Ellipse(extent={{22,-38},{66,-82}},  lineColor={0,0,255}),
      Rectangle(
        extent={{-66,-48},{-34,-80}},
        lineColor={0,0,0},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-50,-54},{-60,-72},{-40,-72},{-50,-54}},
        lineColor={0,0,0},
        fillColor={0,0,0},
        fillPattern=FillPattern.Solid),
      Rectangle(
          extent={{-80,28},{-36,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
      Text(
        extent={{-92,18},{-30,-4}},
        textColor={255,0,0},
          textString="Id=0"),
      Line(
        points={{-36,0},{-18,0},{0,0}},
        smooth=Smooth.None,
        color={0,0,163},
        thickness=1),
      Line(
        points={{-100,-60},{-88,-4},{-80,-4}},
        color={0,0,255},
        smooth=Smooth.None),
      Polygon(
        points={{-42,0},{-36,-6},{-30,0},{-36,6},{-42,0}},
        lineColor={0,0,255},
        smooth=Smooth.None,
        fillColor={0,0,175},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-80,18},{-88,18},{-100,60}},
        color={0,0,255},
        smooth=Smooth.None),
      Polygon(
        points={{-6,0},{0,-6},{6,0},{0,6},{-6,0}},
        lineColor={0,0,255},
        smooth=Smooth.None,
        fillColor={0,0,175},
        fillPattern=FillPattern.Solid),
      Line(visible=false,
        points={{88,-46},{88,-60},{100,-60}},
        color={0,0,0},
        smooth=Smooth.None),
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
A permanent magnet synchronous machines (PMSM) containing the ideal motor
torque control as well as the bus connections.
</p>
</html>"));
end TractionMotor;
