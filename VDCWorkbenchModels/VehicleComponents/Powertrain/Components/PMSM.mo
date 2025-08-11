within VDCWorkbenchModels.VehicleComponents.Powertrain.Components;
model PMSM "Permanent magnet synchronous machine"
  constant Real Pi=Modelica.Constants.pi;

  parameter Boolean useHeatPort = false "True, if HeatPort is enabled"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Integer p=19 "Pole pair number" annotation(Dialog(tab="Motor"));
  parameter Modelica.Units.SI.Voltage V0=273/sqrt(3)/sqrt(2)
    "Open circuit voltage at w_nominal"
    annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.MagneticFlux psi_PM=sqrt(2)*V0/(2*Pi*fNominal)
    "Magnets flux" annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.Frequency fNominal=320
    "Nominal frequency " annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.Current INominal=16
    "Nominal phase current" annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.AngularVelocity wNominal=2*Pi*fNominal/p
    "Nominal speed" annotation (Dialog(group="Load"));
  parameter Modelica.Units.SI.Torque tauNominal=160 "Nominal torque"
    annotation (Dialog(group="Load"));

  parameter Modelica.Units.SI.Inertia J_r=0.07
    "Rotor's moment of inertia" annotation (Dialog(tab="Motor"));

  //------------------------------------------------------------------------------------------------
  // nominal inductances and resistances

  parameter Modelica.Units.SI.Resistance R_s=0.099
    "Warm stator resistance per phase"
    annotation (Dialog(tab="Motor", group="Impedances"));
  parameter Modelica.Units.SI.Inductance L_1=0.00081
    "Main motor inductance"
    annotation (Dialog(tab="Motor", group="Impedances"));

  //------------------------------------------------------------------------------------------------
  // Constants for modelling losses

  parameter Modelica.Units.SI.Torque tauFricRef=0.2
    "Friction torque of motor in Nm at wNominal"
    annotation (Dialog(tab="Motor", group="Losses"));
  parameter Real kHyst(unit="W.s/rad")=0.095 "Hysteresis losses constant" annotation (Dialog(tab="Motor",group="Losses"));
  parameter Real kEddy(unit="W.s2/rad2")=9e-5 "Eddy current losses constant" annotation (Dialog(tab="Motor",group="Losses"));
  parameter Real kfric(unit="W.s/rad")=0.155 "Motor friction constant" annotation (Dialog(tab="Motor",group="Losses"));
  parameter Modelica.Units.SI.Power InverterLossConstant=95 "Constant inverter losses" annotation (Dialog(tab="Motor",group="Losses"));
  parameter Real InverterLossCoefficient(unit="W/A")=5
      "Inverter losses proportional to Iq/torque" annotation (Dialog(tab="Motor",group="Losses"));

  Modelica.Blocks.Interfaces.RealInput I_d "Reference drive torque" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={60,120}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
    annotation (Placement(transformation(extent={{90,-10},{110,10}},
          rotation=0), iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput I_q "Reference drive torque" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40})));

  Modelica.Units.SI.MagneticFlux psi_d;
  Modelica.Units.SI.MagneticFlux psi_q;
  Modelica.Units.SI.Voltage U_d;
  Modelica.Units.SI.Voltage U_q;
  Modelica.Units.SI.AngularVelocity omega_L;
  Modelica.Units.SI.AngularVelocity omega_m;
  Modelica.Units.SI.Torque M_Mi;
  Modelica.Units.SI.Power P_loss;
  Modelica.Units.SI.Power P_ges;
  Modelica.Units.SI.Power P_lossinv;
  Modelica.Units.SI.Power P_cop;
  Modelica.Units.SI.Power P_iron;
  Modelica.Units.SI.Power P_fric;

  Modelica.Mechanics.Rotational.Sources.Torque airGap_torque
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor mechanicalPower annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,0})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(
    phi(fixed=false),
    w(fixed=false),
    a(fixed=false),
    J=J_r) annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Sources.RealExpression airGap_torq(y=M_Mi)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Electrical.Machines.Losses.Friction lossesFriction(
    final frictionParameters(
      PRef=tauFricRef*wNominal,
      wRef=wNominal),
    useHeatPort=false) "Power losses due to friction"
    annotation (Placement(transformation(extent={{30,-38},{50,-18}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,0})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-70,-66})));
  Modelica.Blocks.Math.Division i_DC
      annotation (Placement(transformation(extent={{-30,-50},{-50,-30}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
    annotation (Placement(transformation(extent={{-90,-90},{-110,-70}}, rotation=0),
        iconTransformation(extent={{-90,-90},{-110,-70}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}}, rotation=0)));
  Modelica.Blocks.Sources.RealExpression electricPower(y=P_ges)
    annotation (Placement(transformation(extent={{0,-44},{-20,-24}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed(phi0=0)
    annotation (Placement(transformation(extent={{10,-62},{30,-42}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort if useHeatPort
        "Optional port to which dissipated losses are transported in form of heat"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow if useHeatPort
    annotation (Placement(transformation(extent={{-30,-104},{-50,-84}})));
  Modelica.Blocks.Sources.RealExpression lossPower(y=P_loss)
    annotation (Placement(transformation(extent={{10,-104},{-10,-84}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=V0)
    annotation (Placement(transformation(extent={{-50,-76},{-30,-56}})));
  Utilities.Interfaces.ElectricDriveBus electricMotorBus annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={90,-30})));
equation
  //Modelling of electric machine
  der(psi_d) = U_d-R_s*I_d+omega_L*psi_q;
  der(psi_q) = U_q-R_s*I_q-omega_L*psi_d;
  psi_d=psi_PM+L_1*I_d;
  psi_q=L_1*I_q;
  M_Mi=3/2*p*psi_PM*I_q;

  omega_m*p=omega_L;
  omega_m=der(flange.phi);

  //Modelling of losses
  P_iron=kHyst*abs(omega_m)*60/(2*Pi)+kEddy*omega_m^2*(60/(2*Pi))^2;
  P_lossinv=InverterLossConstant+InverterLossCoefficient*abs(I_q);
  P_fric=kfric*abs(omega_m);
  P_cop=(sqrt(3/2)*abs(I_q))^2*R_s;

  P_loss=P_iron+P_lossinv+P_cop+P_fric;
  P_ges=-(P_loss+mechanicalPower.power);
  connect(mechanicalPower.flange_a, airGap_torque.flange) annotation (Line(
      points={{40,0},{30,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(mechanicalPower.flange_b, inertiaRotor.flange_a) annotation (Line(
      points={{60,0},{70,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inertiaRotor.flange_b, flange) annotation (Line(
      points={{90,0},{100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(airGap_torq.y, airGap_torque.tau) annotation (Line(
      points={{-9,0},{8,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lossesFriction.flange, mechanicalPower.flange_a) annotation (Line(
      points={{40,-18},{40,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(signalCurrent.p,pin_p)  annotation (Line(
      points={{-90,10},{-90,80},{-100,80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(signalCurrent.n,pin_n)  annotation (Line(
      points={{-90,-10},{-90,-80},{-100,-80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSensor.n,signalCurrent. n) annotation (Line(
      points={{-70,-76},{-70,-80},{-90,-80},{-90,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSensor.p,signalCurrent. p) annotation (Line(
      points={{-70,-56},{-70,40},{-90,40},{-90,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(i_DC.y,signalCurrent. i) annotation (Line(
        points={{-51,-40},{-60,-40},{-60,-1.33227e-15},{-78,-1.33227e-15}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(electricPower.y, i_DC.u1) annotation (Line(
      points={{-21,-34},{-28,-34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, heatPort) annotation (Line(
      points={{-50,-94},{-100,-94},{-100,-100}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(lossPower.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-11,-94},{-30,-94}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(voltageSensor.v, firstOrder.u) annotation (Line(
        points={{-59,-66},{-52,-66}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(firstOrder.y, i_DC.u2) annotation (Line(
        points={{-29,-66},{-20,-66},{-20,-46},{-28,-46}},
        color={0,0,127},
        smooth=Smooth.None));
  connect(fixed.flange, airGap_torque.support)
    annotation (Line(points={{20,-52},{20,-10}}, color={0,0,0}));
  connect(electricPower.y, electricMotorBus.electricPower) annotation (Line(points={{-21,-34},{-24,-34},{-24,-42},{6,-42},{6,-78},{58,-78},{58,-100},{60,-100}},
        color={0,0,127}));
  connect(lossPower.y, electricMotorBus.powerLoss) annotation (Line(points={{-11,-94},{-20,-94},{-20,-80},{56,-80},{56,-100},{60,-100}},
        color={0,0,127}));
  connect(airGap_torq.y, electricMotorBus.torque) annotation (Line(points={{-9,0},{0,0},{0,-20},{8,-20},{8,-76},{60,-76},{60,-100}},
        color={0,0,127}));
  connect(mechanicalPower.power, electricMotorBus.mechanicPower) annotation (Line(
        points={{42,-11},{42,-14},{62,-14},{62,-100},{60,-100}}, color={0,0,127}));
  connect(inertiaRotor.flange_b, speedSensor.flange) annotation (Line(points={{90,0},{90,-20}}, color={0,0,0}));
  connect(speedSensor.w, electricMotorBus.angularVelocity) annotation (Line(points={{90,-41},{90,-50},{64,-50},{64,-100},{60,-100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(lossesFriction.support, fixed.flange) annotation (Line(points={{40,-38},{40,-40},{20,-40},{20,-52}}, color={0,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-150,150},{150,110}},
          textColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          radius=20,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
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
        Ellipse(extent={{22,-38},{66,-82}},
          lineColor={0,0,255}),
        Line(
          points={{-100,-40},{-18,0},{0,0}},
          smooth=Smooth.None,
          color={0,0,163},
          thickness=1),
        Polygon(
          points={{-6,0},{0,-6},{6,0},{0,6},{-6,0}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={0,0,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,40},{-18,0},{0,0}},
          smooth=Smooth.None,
          color={0,0,163},
          thickness=1),
        Text(
          extent={{-90,86},{90,44}},
          textColor={0,0,0},
          textString="ideally current
controlled")}),
    Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
An ideally controlled permanent magnet synchronous machines (PMSM) represented using
a&nbsp;quasi-stationary model. For more details on the modeling, refer to
[<a href=\"modelica://VDCWorkbenchModels.UsersGuide.References\">Schr&ouml;der2009</a>], Chap.&nbsp;16.6.
</p>
</html>"));
end PMSM;
