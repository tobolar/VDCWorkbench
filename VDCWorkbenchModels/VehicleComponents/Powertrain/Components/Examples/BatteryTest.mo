within VDCWorkbenchModels.VehicleComponents.Powertrain.Components.Examples;
model BatteryTest
  extends Modelica.Icons.Example;

  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-40,0})));
  Modelica.Blocks.Sources.SawTooth sawTooth(
    amplitude=300,
    offset=-150,
    period=500)  annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(final T=298.15)
    annotation (Placement(transformation(extent={{40,-50},{20,-30}})));

  ParameterizedModels.ROMOBatteryPack90s1pAging rOMOBatteryPack90s1pAging(
    SOC_init=0.8,
    includeHeatPort=true,
    includeGround=true)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(sawTooth.y, signalCurrent.i) annotation (Line(points={{-69,0},{-52,0}},
        color={0,0,127}));
  connect(rOMOBatteryPack90s1pAging.pin_p, signalCurrent.p) annotation (Line(
        points={{0,6},{-10,6},{-10,10},{-40,10}}, color={0,0,255}));
  connect(signalCurrent.n, rOMOBatteryPack90s1pAging.pin_n) annotation (Line(
        points={{-40,-10},{-10,-10},{-10,-6},{0,-6}}, color={0,0,255}));
  connect(rOMOBatteryPack90s1pAging.heatPort, fixedTemperature.port)
    annotation (Line(points={{10,-10},{10,-40},{20,-40}}, color={191,0,0}));
  annotation (
    experiment(
      StopTime=1,
      __Dymola_Algorithm="Dassl"));
end BatteryTest;
