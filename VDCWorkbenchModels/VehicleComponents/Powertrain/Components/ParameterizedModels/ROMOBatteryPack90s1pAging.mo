within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.ParameterizedModels;
model ROMOBatteryPack90s1pAging "ROMO: 90s1p battery pack with aging"
  extends SimpleBatteryAging(
    redeclare Data.ROMOBattery cellParameters);

  Modelica.Blocks.Math.Product Batpower
    annotation (Placement(transformation(extent={{-38,-36},{-26,-48}})));
equation
  connect(Batpower.u2, sensorCurrent.i) annotation (Line(points={{-39.2,-38.4},
          {-39.2,-38},{-46,-38},{-46,-30},{-49,-30}}, color={0,0,127}));
  connect(Batpower.u1, voltageSensor.v) annotation (Line(points={{-39.2,-45.6},
          {-50,-45.6},{-50,40},{-79,40}}, color={0,0,127}));
  connect(Batpower.y, batteryBus.power) annotation (Line(points={{-25.4,-42},{
          -14,-42},{-14,-50},{0,-50}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(graphics={
        Text(
          extent={{-28,10},{62,-38}},
          textColor={28,108,200},
          textString="90s1p")}));
end ROMOBatteryPack90s1pAging;
