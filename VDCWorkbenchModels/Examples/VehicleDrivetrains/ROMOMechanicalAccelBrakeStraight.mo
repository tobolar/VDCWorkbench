within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOMechanicalAccelBrakeStraight "Vehicle with prescribed rear drive torque accelerating and braking straight"
  extends VariantsVehicleDrivetrains.ROMOMechanical(
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
A&nbsp;table which prescribes torque is given and the torque acts on the central
rear drive flange of the vehicle. It is splited by a&nbsp;rear differential to the
rear wheels.
</p>
<p>
The torque is positive first, thus accelerating the vehicle.
After some 10&nbsp;s, the torque changes to negative values and the vehicle decelerates.
Simulate for 20&nbsp;s, and plot the vehicle velocity depending on the torque <code>torque.tau</code>.
</p>
</html>",
      figures = {
        Figure(
          identifier = "ROMOMechanicalAccelBrakeStraight_results",
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
                Curve(y = torque.tau, legend = "torque.tau")})},
          caption = "%(plot:v_vehicle) Vehicle speed (%(variable:controlBus.chassisBus.longitudinalVelocity)) due to driving / braking torque on the rear axle, shown in %(plot:torque).")}));
end ROMOMechanicalAccelBrakeStraight;
