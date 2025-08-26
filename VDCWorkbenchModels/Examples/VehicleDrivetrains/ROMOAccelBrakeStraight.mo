within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOAccelBrakeStraight "Vehicle with four in-wheel motors and battery accelerating and braking straight"
  extends VariantsVehicleDrivetrains.ROMO4IWM(
    v_Start=0,
    redeclare Modelica.Blocks.Sources.Constant steeringWheelAngleDemand(k=0),
    redeclare Modelica.Blocks.Sources.TimeTable tMTorqueDemand(
      table=[0.0,0.0; 5,160; 10,160; 12,-160; 20,-160]));
  annotation (
    experiment(
      StopTime=20,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
<p>
A&nbsp;vehicle driving straight ahead and accelerating/braking. 
A&nbsp;table which prescribes the total <em>demanded</em> torque is given. This torque demand
is realized by four traction motors which are connected directly to the wheel flanges of
the vehicle, thus representing four in-wheel motors. Each of the motors realizes 1/4 of the
total torque demand.
A&nbsp;battery provides energy source for all traction motors.
</p>
<p>
The demanded torque is positive first, thus accelerating the vehicle.
After some 10&nbsp;s, the torque changes to negative values and the vehicle decelerates.
Simulate for 20&nbsp;s, and plot the vehicle velocity depending on the torque demand.
</p>
</html>",
      figures = {
        Figure(
          identifier = "ROMOAccelBrakeStraight_results",
          preferred = true,
          plots = {
            Plot(
              title = "Vehicle velocity",
              identifier = "v_vehicle",
              curves = {
                Curve(y = controlBus.chassisBus.longitudinalVelocity, legend = "chassisBus.longitudinalVelocity")}),
            Plot(
              title = "Demanded driving (+) / braking (-) torque",
              identifier = "torque",
              curves = {
                Curve(y = tractionMotorFL.torque_dem, legend = "front left (FL)"),
                Curve(y = tractionMotorFR.torque_dem, legend = "front right (FR)"),
                Curve(y = tractionMotorRL.torque_dem, legend = "rear left (RL)"),
                Curve(y = tractionMotorRR.torque_dem, legend = "rear right (RR)")})},
          caption = "%(plot:v_vehicle) Vehicle speed (%(variable:controlBus.chassisBus.longitudinalVelocity)) due to individual driving / braking torques on all four wheels, shown in %(plot:torque).")}));
end ROMOAccelBrakeStraight;
