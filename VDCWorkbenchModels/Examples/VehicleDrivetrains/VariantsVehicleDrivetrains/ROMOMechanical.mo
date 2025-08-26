within VDCWorkbenchModels.Examples.VehicleDrivetrains.VariantsVehicleDrivetrains;
model ROMOMechanical "Architecture of the ROMO planar vehicle with driving torque on rear differential"
  extends BaseConfigurations.BaseRomo(
    v_Start=0,
    redeclare replaceable Modelica.Blocks.Sources.Constant steeringWheelAngleDemand(k=0),
    redeclare Modelica.Blocks.Sources.TimeTable tMTorqueDemand(
      table=[0.0,0.0; 5,160; 10,160; 12,-160; 20,-160]),
    vehicle(
      axleFront(
        wheelRight(
          stateSelect=StateSelect.always,
          phi_roll(start=0, fixed=true), w_roll(fixed=true)),
        wheelLeft(
          stateSelect=StateSelect.always)),
      axleRear(
        wheelRight(
          stateSelect=StateSelect.always,
          phi_roll(start=0, fixed=true), w_roll(fixed=true)),
        wheelLeft(
          stateSelect=StateSelect.always))));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
equation
  connect(tMTorqueDemand.y, torque.tau)
    annotation (Line(points={{-79,-80},{-42,-80}}, color={0,0,127}));
  connect(torque.flange, vehicle.flangeDriveRear) annotation (Line(points={{-20,-80},{0,-80},{0,-10}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=20,
      Interval=0.1),
    Documentation(
      info="<html>
<p>
A&nbsp;model architecture of the DLR&apos;s ROboMObil with driving torque
prescribed by a&nbsp;table. This torque acts on the central
rear drive flange of the vehicle.
The prescribed driving torque can be simply modified by changing the data of table
<code>tMTorqueDemand</code>.
The steering wheel signal can be modified by replacing the block
<code>steeringWheelAngleDemand</code> with the desired signal.
</p>
</html>"));
end ROMOMechanical;
