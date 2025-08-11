within VDCWorkbenchModels.Examples.VDCWorkbenches;
model Techlab2TrainStationWessling_MVCLateral
  extends VehicleArchitectures.VDCWorkbench2025(
    redeclare VehicleComponents.Controllers.VDControl.MVCLateralControl controller);
  annotation (
    experiment(
      StopTime=136,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"),
    Documentation(
      info="<html>
<p>
Vehicle&apos;s architecture intended for the IEEE VTS Motor Vehicles Challenge 2023.
</p>
</html>"));
end Techlab2TrainStationWessling_MVCLateral;
