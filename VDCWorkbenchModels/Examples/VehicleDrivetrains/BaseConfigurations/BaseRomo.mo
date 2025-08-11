within VDCWorkbenchModels.Examples.VehicleDrivetrains.BaseConfigurations;
partial model BaseRomo "Basic architecture of the ROMO planar vehicle"
  extends VehicleArchitectures.BaseArchitecture;
  extends Modelica.Icons.Example;

  replaceable Modelica.Blocks.Interfaces.SO steeringWheelAngleDemand
    constrainedby Modelica.Blocks.Interfaces.SO
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  replaceable Modelica.Blocks.Interfaces.SO tMTorqueDemand
    constrainedby Modelica.Blocks.Interfaces.SO
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
equation
  connect(steeringWheelAngleDemand.y, from_deg.u)
    annotation (Line(points={{-79,80},{-62,80}}, color={0,0,127}));
  connect(from_deg.y, chassisControlBus.steeringWheelAngle) annotation (Line(points={{-39,80},{20,80},{20,60},{80,60}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
end BaseRomo;
