within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.ParameterizedModels;
model ROMOBatteryPack90s1p "ROMO: 90s1p battery pack"
  extends SimpleBattery(
    redeclare Data.ROMOBattery cellParameters);
  annotation (
    Icon(graphics={
        Text(
          extent={{-28,10},{62,-38}},
          textColor={28,108,200},
          textString="90s1p")}));
end ROMOBatteryPack90s1p;
