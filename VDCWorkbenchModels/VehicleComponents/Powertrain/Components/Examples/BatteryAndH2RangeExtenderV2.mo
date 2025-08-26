within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.Examples;
model BatteryAndH2RangeExtenderV2
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Constant const(k=40) annotation (Placement(transformation(extent={{60,0},{40,20}})));
  ParameterizedModels.ROMOBatteryPack90s1p rOMOBatteryPack90s1p(
    SOC_init=0.1,
    includeGround=true) annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  ParameterizedModels.ROMOH2Rex functionalGeneratorV2_1(
    includeHeatPort=true,
    H2_tank_level=0.4,
    REXparameters(H2_tank_level=1))
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
    final T=293.15)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
equation
  connect(functionalGeneratorV2_1.pin_p, rOMOBatteryPack90s1p.pin_p)
    annotation (Line(points={{0,6},{-20,6}}, color={0,0,255}));
  connect(rOMOBatteryPack90s1p.pin_n, functionalGeneratorV2_1.pin_n)
    annotation (Line(points={{-20,-6},{0,-6}}, color={0,0,255}));
  connect(const.y, functionalGeneratorV2_1.I_dem) annotation (Line(points={{39,10},{30,10},{30,6},{22,6}}, color={0,0,127}));
  connect(fixedTemperature.port, functionalGeneratorV2_1.heatPort)
    annotation (Line(points={{-20,-40},{10,-40},{10,-10}}, color={191,0,0}));
  annotation (
    experiment(
      StopTime=1000,
      __Dymola_Algorithm="Dassl"));
end BatteryAndH2RangeExtenderV2;
