within VDCWorkbenchModels.Examples.VehicleDrivetrains;
model ROMOMechanicalAccelBrakeStraight
  extends VariantsVehicleDrivetrains.ROMOMechanical(
    v_Start=0,
    redeclare Modelica.Blocks.Sources.Constant steeringWheelAngleDemand(k=0),
    redeclare Modelica.Blocks.Sources.TimeTable tMTorqueDemand(table=[0.0,0.0;
          5,160; 10,160; 12,-160; 20,-160]));
  annotation (experiment(
      StopTime=20,
      __Dymola_fixedstepsize=0.001,
      __Dymola_Algorithm="Dassl"));
end ROMOMechanicalAccelBrakeStraight;
