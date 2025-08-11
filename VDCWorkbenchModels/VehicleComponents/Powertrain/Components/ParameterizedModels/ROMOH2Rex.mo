within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.ParameterizedModels;
model ROMOH2Rex "ROMO: H2 range extender"
  extends FunctionalH2RangeExtender(
    SoC(k=1/REXparameters.H2_tank_level),
    H2Power2Consumption(table=REXparameters.H2consumption),
    H2Power2Efficiency(table=REXparameters.H2efficiency),
    H2_tank(y_start=REXparameters.H2_tank_level),
    redeclare Data.ROMORangeExtender REXparameters(H2consumption=[0,0; 100,
          5.5114638447971775E-8; 250,2.4315281668222846E-8; 500,
          1.9683799445704209E-8; 1000,1.7223324514991183E-8; 2500,
          1.530962179110327E-8; 5000,1.4253785805509944E-8; 10000,
          1.3778659611992947E-8; 15000,1.4503852223150467E-8; 20000,
          1.6534391534391535E-8]));
equation
  connect(sensorCurrent.i, rexBus.H2Current) annotation (Line(points={{-59,-40},{-56,-40},{-56,-74},{82,-74},{82,-34},{100,-34},{100,-30}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(voltageSensor.v, rexBus.H2Voltage) annotation (Line(points={{-79,0},{-60,0},{-60,26},{0,26},{0,12},{102,12},{102,-30},{100,-30}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(graphics={
        Text(
          extent={{-140,150},{160,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(
      info="<html>
<p>
</p>
</html>"));
end ROMOH2Rex;
