within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOAccelerateTurn
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
      __Dymola_Algorithm="Dassl"));
end ROMOAccelerateTurn;
