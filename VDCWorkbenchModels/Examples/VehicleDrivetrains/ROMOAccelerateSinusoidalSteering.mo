within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOAccelerateSinusoidalSteering
  extends VariantsVehicleDrivetrains.ROMO4IWM(
    v_Start=8,
    redeclare Modelica.Blocks.Sources.Sine steeringWheelAngleDemand(
      startTime=1,
      amplitude=90,
      f=0.2),
    redeclare Modelica.Blocks.Sources.TimeTable tMTorqueDemand(
      table=[0.0,0.0; 5,160; 20,160]),
    vehicle(useHeatPort=true)        );
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor sensorPLossVehicle annotation (Placement(transformation(extent={{-10,40},{10,60}})));
equation
  connect(vehicle.heatPort, sensorPLossVehicle.port_a) annotation (Line(points={{-10,-10},{-12,-10},{-12,50},{-10,50}}, color={191,0,0}));
  connect(sensorPLossVehicle.port_b, infinityHeatCapacitor.port) annotation (Line(points={{10,50},{70,50},{70,-90},{80,-90}}, color={191,0,0}));
  annotation (experiment(
      StopTime=20,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"));
end ROMOAccelerateSinusoidalSteering;
