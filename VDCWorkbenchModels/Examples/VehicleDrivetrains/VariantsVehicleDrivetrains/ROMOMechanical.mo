within VDCWorkbenchModels.Examples.VehicleDrivetrains.VariantsVehicleDrivetrains;
model ROMOMechanical
  extends BaseConfigurations.BaseRomo(
    v_Start=0,
    redeclare Modelica.Blocks.Sources.Constant steeringWheelAngleDemand(k=0),
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
      Interval=0.1));
end ROMOMechanical;
