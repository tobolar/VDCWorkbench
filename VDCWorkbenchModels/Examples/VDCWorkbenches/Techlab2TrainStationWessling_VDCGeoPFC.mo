within VDCWorkbenchModels.Examples.VDCWorkbenches;
model Techlab2TrainStationWessling_VDCGeoPFC
  extends VehicleArchitectures.VDCWorkbench2025(
    redeclare VehicleComponents.Controllers.VDControl.VDCWorkbenchControl controller);
  annotation (
    experiment(
      StopTime=136,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"));
end Techlab2TrainStationWessling_VDCGeoPFC;
