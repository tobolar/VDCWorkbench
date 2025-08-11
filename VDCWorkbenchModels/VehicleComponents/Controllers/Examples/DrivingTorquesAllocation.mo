within VDCWorkbenchModels.VehicleComponents.Controllers.Examples;
model DrivingTorquesAllocation "Show allocation of driving torques for front and rear electric machines"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Interfaces.RealOutput torqueDemandFront "Torque demand to front electric machine" annotation (Placement(transformation(extent={{70,20},{90,40}}), iconTransformation(extent={{80,30},{80,30}})));
  Modelica.Blocks.Interfaces.RealOutput torqueDemandRearL "Torque demand to electric machine rear left" annotation (Placement(transformation(extent={{70,-10},{90,10}}), iconTransformation(extent={{80,0},{80,0}})));
  Modelica.Blocks.Interfaces.RealOutput torqueDemandRearR "Torque demand to electric machine rear right" annotation (Placement(transformation(extent={{70,-40},{90,-20}}), iconTransformation(extent={{80,-30},{80,-30}})));
  VDControl.Components.TorqueVectoring torqueVectoring(
    wheel_r=0.3,
    track_width=1.5,
    Torque_max_frontMotor=100,
    Torque_max_rearMotor=50) annotation (Placement(transformation(extent={{-10,-20},{30,20}})));
  Modelica.Blocks.Sources.Constant signalTorqueTotal(k=75) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Blocks.Sources.TimeTable signalRatioFR(
    table=[0.0,0.0; 0.1,0.0; 0.6,1; 0.8,1; 1.0,0.5; 1.5,0.5; 1.8,0; 3,0])
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Sources.TimeTable signalRatioTV(
    table=[0.0,0.0; 0.65,0.0; 0.75,0.5; 1.2,0.5; 1.6,1; 3,1])
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
equation
  connect(signalTorqueTotal.y, torqueVectoring.Torque) annotation (Line(points={{-49,40},{-40,40},{-40,12},{-14,12}}, color={0,0,127}));
  connect(signalRatioFR.y, torqueVectoring.alpha_FrontRear) annotation (Line(points={{-49,0},{-14,0}},color={0,0,127}));
  connect(signalRatioTV.y, torqueVectoring.alpha_TV) annotation (Line(points={{-49,-40},{-40,-40},{-40,-12},{-14,-12}},
                                                                                                                     color={0,0,127}));
  connect(torqueVectoring.torque_dem_front, torqueDemandFront) annotation (Line(points={{32,12},{50,12},{50,30},{80,30}}, color={0,0,127}));
  connect(torqueVectoring.torque_dem_rearLeft, torqueDemandRearL) annotation (Line(points={{32,-4},{40,-4},{40,0},{80,0}}, color={0,0,127}));
  connect(torqueVectoring.torque_dem_rearRight, torqueDemandRearR) annotation (Line(points={{32,-12},{50,-12},{50,-30},{80,-30}}, color={0,0,127}));
  annotation (
    experiment(
      StopTime=2,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<html>
<p>
Allocate torque demands on driving motors for a&nbsp;demanded constant total torque.
The demanded torques are generated for the front central motor and the rear right and
the rear left motors. The torques are allocated according to
</p>
<ul>
  <li>
    the front/rear ratio in the range from&nbsp;0 to&nbsp;1 given by table
    <code>signalRatioFR</code> and
  </li>
  <li>
    the right/left rear ratio in the range from&nbsp;0 to&nbsp;1 given by table
    <code>signalRatioTV</code>.
  </li>
</ul>
<p>
Simulate for 2&nbsp;s. The following plot shows the demanded torques for changing
front/rear and right/left ratios. In the bottom diagram, the torque vectoring on the
rear drives is shown.
</p>
<div>
  <img src=\"modelica://VDCWorkbenchModels/Resources/Images/VehicleComponents/Controllers/ExampleTorqueVectoring_plot.png\" alt=\"Plot of simulation results\"/>
</div>
</html>"));
end DrivingTorquesAllocation;
