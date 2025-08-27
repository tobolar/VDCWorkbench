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
  annotation (
    experiment(
      StopTime=20,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
<p>
Similar to <a href=\"modelica://VDCWorkbenchModels.Examples.VehicleDrivetrains.ROMOAccelBrakeStraight\">ROMOAccelBrakeStraight</a>,
a&nbsp;demanded driving torque is realized by four in-wheel traction motors, thus
accelerating the vehicle.
Additionally, a&nbsp;sinusoidal steering wheel angle signal is prescribed.
</p>
<p>
The demanded driving torque of a&nbsp;ramp form accelerates the vehicle.
The sinusoidal steering wheel angle of constant frequency and amplitude additionally
imposes vehicle&apos;s motion.
Simulate for 20&nbsp;s, and plot the vehicle velocity depending on the torque demand.
</p>
</html>",
      figures = {
        Figure(
          identifier = "ROMOAccelerateSinusoidalSteering_results",
          preferred = true,
          plots = {
            Plot(
              title = "Vehicle velocity",
              identifier = "v_vehicle",
              curves = {
                Curve(y = controlBus.chassisBus.longitudinalVelocity, legend = "chassisBus.longitudinalVelocity")}),
            Plot(
              title = "Demanded driving torque",
              identifier = "torque",
              curves = {
                Curve(y = tractionMotorFL.torque_dem, legend = "front left (FL)"),
                Curve(y = tractionMotorFR.torque_dem, legend = "front right (FR)"),
                Curve(y = tractionMotorRL.torque_dem, legend = "rear left (RL)"),
                Curve(y = tractionMotorRR.torque_dem, legend = "rear right (RR)")}),
            Plot(
              title = "Lateral acceleration",
              identifier = "torque",
              curves = {
                Curve(y = controlBus.chassisBus.lateralAcceleration)})},
          caption = "%(plot:v_vehicle) Vehicle speed (%(variable:controlBus.chassisBus.longitudinalVelocity)) due to individual driving / braking torques on all four wheels, shown in %(plot:torque)."),
        Figure(
          identifier = "ROMOAccelerateSinusoidalSteering_steer",
          preferred = false,
          plots = {
            Plot(
              title = "Vehicle position in horizontal plane",
              identifier = "positionVehicle_xy",
              curves = {
                Curve(x = controlBus.chassisBus.position_x, y = controlBus.chassisBus.position_y)})})}));
end ROMOAccelerateSinusoidalSteering;
