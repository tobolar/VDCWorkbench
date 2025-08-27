within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOAccelerateTurn "Vehicle with four in-wheel motors and battery accelerating and braking in turn"
  extends VariantsVehicleDrivetrains.ROMO4IWM(
    v_Start=2,
    redeclare Modelica.Blocks.Sources.Ramp steeringWheelAngleDemand(
      duration=1,
      startTime=1,
      height=130),
    redeclare Modelica.Blocks.Sources.TimeTable tMTorqueDemand(
      table=[0.0,0.0; 5,160; 20,160]));
  annotation (experiment(
      StopTime=20,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
<p>
Similar to <a href=\"modelica://VDCWorkbenchModels.Examples.VehicleDrivetrains.ROMOAccelBrakeStraight\">ROMOAccelBrakeStraight</a>,
a&nbsp;demanded driving torque is realized by four in-wheel traction motors, thus
accelerating the vehicle.
Additionally, the steering wheel angle increases so that the vehicle drives in
circle of some 17&nbsp;m radius.
</p>
<p>
The demanded driving torque of a&nbsp;ramp form accelerates the vehicle.
The steering angle is of a&nbsp;ramp form as well, with delayed start of 1&nbsp;s.
Simulate for 20&nbsp;s, and plot the vehicle velocity depending on the torque demand.
</p>
</html>",
      figures = {
        Figure(
          identifier = "ROMOAccelerateTurn_results",
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
          identifier = "ROMOAccelerateTurn_steer",
          preferred = false,
          plots = {
            Plot(
              title = "Vehicle position in horizontal plane",
              identifier = "positionVehicle_xy",
              curves = {
                Curve(x = controlBus.chassisBus.position_x, y = controlBus.chassisBus.position_y)})})}));
end ROMOAccelerateTurn;
