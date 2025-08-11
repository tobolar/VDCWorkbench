within VDCWorkbenchModels.Data.BaseRecords;
record EMA "Basic record containing template data of the energy management algorithm"
  extends Modelica.Icons.Record;
  import VDCWorkbenchModels.Utilities.Types.StateOfCharge;

  parameter String variantName= "baselineEMA" "Name of identification variant";

  parameter Modelica.Units.SI.Current fuelcell_Imax=40 "Maximum possible current" annotation (Dialog(group="Fuel cell"));
  parameter StateOfCharge fuelcell_SOCmax = 1.00 "Maximum allowed SoC" annotation (Dialog(group="Fuel cell"));
  parameter StateOfCharge fuelcell_SOCmin = 0.1 "Minimum allowed SoC" annotation (Dialog(group="Fuel cell"));
  parameter Modelica.Units.SI.Mass fuelcell_H2_tank_level = 0.15 "Initial level of H2 tank" annotation (Dialog(group="Fuel cell"));

  parameter StateOfCharge bat_SOCmax = 0.8 "Maximum allowed SoC" annotation (Dialog(group="Battery"));
  parameter StateOfCharge bat_SOCmin = 0.2 "Minimum allowed SoC" annotation (Dialog(group="Battery"));
  parameter StateOfCharge bat_SOC_delta = 0.05 "SoC for derating" annotation (Dialog(group="Battery"));
  parameter StateOfCharge bat_SOC_init = 0.65 "Initial SoC" annotation (Dialog(group="Battery"));

  // safety battery/FC SoC values
  parameter StateOfCharge fuelcell_SOCmin_stop = 0.01 "Vehicle shutdown if fuel cell SoC become lower than this value" annotation (Dialog(group="Emergency case"));
  parameter StateOfCharge fuelcell_SOCmax_stop = 1.00 "Vehicle shutdown if fuel cell SoC become higher than this value" annotation (Dialog(group="Emergency case"));

  parameter StateOfCharge bat_SOCmin_stop = 0.01 "Vehicle shutdown if battery SoC become lower than this value" annotation (Dialog(group="Emergency case"));
  parameter StateOfCharge bat_SOCmax_stop = 0.99 "Vehicle shutdown if battery SoC become higher than this value" annotation (Dialog(group="Emergency case"));
  parameter Modelica.Units.NonSI.Temperature_degC bat_Tmax = 35 "Maximum allowed temperature of the battery pack" annotation (Dialog(group="Emergency case"));

  // Baseline EMA parameters
  parameter Real EMAbaseline_kfc = 0.8 "Fuel cell distribution ratio";
  parameter Real EMAbaseline_ktv = 0.5 "Torque vectoring ratio";
  parameter Real EMAbaseline_a_ad = 0.5 "Front/rear ratio";

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true),
      graphics={
        Text(
          extent={{-140,-100},{140,-130}},
          textColor={0,0,0},
          textString="%variantName")}),

    Documentation(
      info="<html>
<p>
This record contains template data of an energy management algorithm (EMA).
Extend from this record to create a&nbsp;new record of particular EMA.
</p>
</html>"));
end EMA;
