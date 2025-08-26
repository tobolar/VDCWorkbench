within VDCWorkbenchModels.Data;
record ROMORangeExtender
  "ROMO's H2 range extender parameter set V2_2 from efficiency map with extra data points - max 20kW"
  extends BaseRecords.RangeExtender(
    variantName = "ROMO",
    H2_tank_level = 0.3,
    H2efficiency = [
      0,0.01;
      100,0.15;
      250,0.34;
      500,0.42;
      1000,0.48;
      2500,0.54;
      5000,0.58;
      10000,0.6;
      15000,0.57;
      20000,0.5],
    H2consumption = [
      0,0;
      100,5.5114638447971775E-8;
      250,2.4315281668222846E-8;
      500,1.9683799445704209E-8;
      1000,1.7223324514991183E-8;
      2500,1.530962179110327E-8;
      5000,1.4253785805509944E-8;
      10000,1.3778659611992947E-8;
      15000,1.4503852223150467E-8;
      20000,1.6534391534391535E-8]);

  annotation (Documentation(info="<html>
<p>
Record containing data of the ROMO&apos;s hydrogen range extender.
</p>
</html>"), Icon(graphics={Text(
          extent={{-76,42},{88,4}},
          textColor={28,108,200},
          textString="Rex V2.1")}));
end ROMORangeExtender;
