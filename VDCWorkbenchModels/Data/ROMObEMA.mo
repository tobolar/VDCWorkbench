within VDCWorkbenchModels.Data;
record ROMObEMA "ROMO's baseline policy of energy management algorithm"
  extends BaseRecords.EMA(
    variantName="baselineEMA ROMO",
    EMAbaseline_a_ad=0.5,
    EMAbaseline_ktv=0.5,
    EMAbaseline_kfc=0.8,
    bat_Tmax=35,
    bat_SOCmax_stop=0.99,
    bat_SOCmin_stop=0.01,
    fuelcell_SOCmax_stop=1,
    fuelcell_SOCmin_stop=0.01,
    bat_SOC_init=0.65,
    bat_SOC_delta=0.05,
    bat_SOCmin=0.20,
    bat_SOCmax=0.8,
    fuelcell_H2_tank_level=0.15,
    fuelcell_SOCmin=0.1,
    fuelcell_SOCmax=1.00,
    fuelcell_Imax=40);
  annotation (
    Documentation(
      info="<html>
<p>
Set of parameters for the baseline policy of the <em>ROMO&apos;s</em> energy management algorithm (EMA).
</p>
</html>"));
end ROMObEMA;
