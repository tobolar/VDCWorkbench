within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOSingeleMotorAccelBrakeStraight "Vehicle with central rear motor and battery accelerating and braking straight"
  extends VariantsVehicleDrivetrains.ROMOSingleMotor(
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
A&nbsp;table which prescribes the <em>demanded</em> torque is given. This torque demand
is realized by a&nbsp;traction motor which is connected to the central rear drive flange
of the vehicle. It is then splited by a&nbsp;rear differential to the rear wheels.
A&nbsp;battery provides energy source for the traction motor.
</p>
<p>
The demanded torque is positive first, thus accelerating the vehicle.
After some 10&nbsp;s, the torque changes to negative values and the vehicle decelerates.
Simulate for 20&nbsp;s, and plot the vehicle velocity depending on the torque demand
<code>tractionMotor.torque_dem</code>.
</p>
</html>",
      figures = {
        Figure(
          identifier = "ROMOSingeleMotorAccelBrakeStraight_results",
          preferred = true,
          plots = {
            Plot(
              title = "Vehicle velocity",
              identifier = "v_vehicle",
              curves = {
                Curve(y = controlBus.chassisBus.longitudinalVelocity, legend = "chassisBus.longitudinalVelocity")}),
            Plot(
              title = "Total driving (+) / braking (-) torque on rear axle",
              identifier = "torque",
              curves = {
                Curve(y = tractionMotor.torque_dem, legend = "Demanded torque"),
                Curve(y = tractionMotor.electricMotorBus.torque, legend = "Actual torque")})},
          caption = "%(plot:v_vehicle) Vehicle speed (%(variable:controlBus.chassisBus.longitudinalVelocity)) due to driving / braking torque on the rear axle, shown in %(plot:torque).")}));
end ROMOSingeleMotorAccelBrakeStraight;
