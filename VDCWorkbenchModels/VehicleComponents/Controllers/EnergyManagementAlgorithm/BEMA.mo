within VDCWorkbenchModels.VehicleComponents.Controllers.EnergyManagementAlgorithm;
model BEMA "Baseline energy management algorithm of the IEEE MVC 2023"
  extends BaseClasses.InterfacesEMA;
  import VDCWorkbenchModels.Utilities.Types.StateOfCharge;

  parameter StateOfCharge bat_SOCmax=0.8 "Upper limit of battery SOC";
  parameter StateOfCharge bat_SOCmin=0.2 "Lower limit of battery SOC";
  parameter StateOfCharge bat_SOC_delta = 0.05 "SoC for derating";
  parameter StateOfCharge fuelcell_SOCmax = 1.00 "Maximum allowed SoC of fuel cell";
  parameter StateOfCharge fuelcell_SOCmin = 0.1 "Minimum allowed SoC of fuel cell";

  parameter Real EMAbaseline_kfc = 0.8 "Fuel cell distribution ratio";
  parameter Real EMAbaseline_ktv = 0.5 "Torque vectoring ratio";
  parameter Real EMAbaseline_a_ad = 0.5 "Front/rear ratio";

  VDCWorkbenchModels.Utilities.Blocks.IntervalTest socBatLim(
    upperLimit=bat_SOCmax,
    lowerLimit=bat_SOCmin)
    annotation (Placement(transformation(extent={{-40,54},{-28,66}})));
  VDCWorkbenchModels.Utilities.Blocks.IntervalTest socH2Lim(
    upperLimit=fuelcell_SOCmax,
    lowerLimit=fuelcell_SOCmin)
    annotation (Placement(transformation(extent={{-40,74},{-28,86}})));
  Modelica.Blocks.Logical.And SOCinBand
    annotation (Placement(transformation(extent={{-14,66},{-2,78}})));
  Modelica.Blocks.Math.BooleanToReal isSafe
    annotation (Placement(transformation(extent={{4,66},{16,78}})));
  Modelica.Blocks.Sources.RealExpression iFC(y=EMAbaseline_kfc)
    annotation (Placement(transformation(extent={{-20,40},{20,60}})));
  Modelica.Blocks.Math.Product alpha_FC
    annotation (Placement(transformation(extent={{40,64},{52,76}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=4)
    annotation (Placement(transformation(extent={{-40,20},{-28,32}})));
  Modelica.Blocks.Sources.RealExpression TV_ratio(y=EMAbaseline_ktv)
    annotation (Placement(transformation(extent={{-94,-10},{-54,10}})));
  Modelica.Blocks.Math.Add alpha_TV
    annotation (Placement(transformation(extent={{40,14},{52,26}})));
  Modelica.Blocks.Sources.RealExpression TV_ratio_diff(y=0.5)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.RealExpression alpha_AD(y=EMAbaseline_a_ad)
    annotation (Placement(transformation(extent={{0,-20},{40,0}})));
  Modelica.Blocks.Math.Gain gain(k=1/bat_SOC_delta)
    annotation (Placement(transformation(extent={{0,-46},{12,-34}})));
  Modelica.Blocks.Math.Add alpha_v
    annotation (Placement(transformation(extent={{40,-56},{52,-44}})));
  Modelica.Blocks.Sources.RealExpression alpha_AD1(y=-bat_SOCmin/bat_SOC_delta + 1)
    annotation (Placement(transformation(extent={{-20,-80},{20,-60}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_alpha_v(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{64,-56},{76,-44}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_alpha_AD(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{64,-16},{76,-4}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_alpha_TV(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{64,14},{76,26}})));
  Modelica.Blocks.Nonlinear.Limiter limiter_alpha_FC(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{64,64},{76,76}})));

equation
  connect(socBatLim.u, batteryBus.SOC) annotation (Line(points={{-41.2,60},{-50,60},{-50,50},{-90,50}},
        color={0,0,127}),
      Text(
        string="%second",
        index=4,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(socH2Lim.u, rexBus.H2SoC) annotation (Line(points={{-41.2,80},{-90,80}},
        color={0,0,127}),
      Text(
        string="%second",
        index=2,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(SOCinBand.y, isSafe.u)
    annotation (Line(points={{-1.4,72},{2.8,72}}, color={255,0,255}));
  connect(SOCinBand.u2, socBatLim.y) annotation (Line(points={{-15.2,67.2},{-20,67.2},{-20,60},{-27.4,60}},
        color={255,0,255}));
  connect(SOCinBand.u1, socH2Lim.y) annotation (Line(points={{-15.2,72},{-20,72},{-20,80},{-27.4,80}},
        color={255,0,255}));
  connect(isSafe.y, alpha_FC.u1)
    annotation (Line(points={{16.6,72},{24,72},{24,73.6},{38.8,73.6}},
        color={0,0,127}));
  connect(iFC.y, alpha_FC.u2) annotation (Line(points={{22,50},{30,50},{30,66.4},{38.8,66.4}},
        color={0,0,127}));
  connect(multiProduct.u[1], TV_ratio.y) annotation (Line(points={{-40,24.425},{-40,24},{-46,24},{-46,0},{-52,0}},
        color={0,0,127}));
  connect(multiProduct.y, alpha_TV.u1)
    annotation (Line(points={{-26.98,26},{30,26},{30,23.6},{38.8,23.6}},
        color={0,0,127}));
  connect(TV_ratio_diff.y, alpha_TV.u2) annotation (Line(points={{21,10},{30,10},{30,16.4},{38.8,16.4}},
        color={0,0,127}));
  connect(socBatLim.u, gain.u) annotation (Line(points={{-41.2,60},{-50,60},{-50,38},{-20,38},{-20,-40},{-1.2,-40}},
        color={0,0,127}));
  connect(alpha_v.u1, gain.y)
    annotation (Line(points={{38.8,-46.4},{30,-46.4},{30,-40},{12.6,-40}},
        color={0,0,127}));
  connect(alpha_AD1.y, alpha_v.u2) annotation (Line(points={{22,-70},{30,-70},{30,-53.6},{38.8,-53.6}},
        color={0,0,127}));
  connect(limiter_alpha_FC.y, eMAControls.alpha_FC) annotation (Line(points={{76.6,70},{100,70},{100,0}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(limiter_alpha_TV.y, eMAControls.alpha_TV) annotation (Line(points={{76.6,20},{88,20},{88,0},{100,0}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(limiter_alpha_AD.y, eMAControls.alpha_AD) annotation (Line(points={{76.6,-10},{90,-10},{90,-2},{100,-2},{100,0}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(limiter_alpha_v.y, eMAControls.alpha_v) annotation (Line(points={{76.6,-50},{92,-50},{92,-4},{100,-4},{100,0}},
        color={0,0,127}),
      Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
  connect(alpha_FC.y, limiter_alpha_FC.u)
    annotation (Line(points={{52.6,70},{62.8,70}},
        color={0,0,127}));
  connect(alpha_TV.y, limiter_alpha_TV.u) annotation (Line(points={{52.6,20},{62.8,20}},
        color={0,0,127}));
  connect(alpha_AD.y, limiter_alpha_AD.u) annotation (Line(points={{42,-10},{62.8,-10}},
        color={0,0,127}));
  connect(alpha_v.y, limiter_alpha_v.u)
    annotation (Line(points={{52.6,-50},{62.8,-50}}, color={0,0,127}));
  connect(multiProduct.u[2], motionDemandBus.kappa_path) annotation (Line(
        points={{-40,25.475},{-40,26},{-60,26},{-60,20},{-90,20}},
        color={0,0,127}));
  connect(multiProduct.u[3], motionDemandBus.v_path) annotation (Line(points={{-40,26.525},{-40,28},{-62,28},{-62,20},{-90,20}},
        color={0,0,127}));
  connect(multiProduct.u[4], motionDemandBus.v_path) annotation (Line(points={{-40,27.575},{-40,30},{-64,30},{-64,20},{-90,20}},
        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false),
      graphics={
        Text(
          extent={{-100,-60},{100,-88}},
          textColor={0,0,0},
          textString="baseline EMA")}),
    Documentation(info="<html>
<p>
The energy management algorithm (EMA) is responsible for computing four control variables:
</p>
<ol>
  <li>
    The normalized fuel cell current, &alpha;<sub>FC</sub>&nbsp;&isin;&nbsp;[0,&nbsp;1], which
    affects the power split between the battery and the fuel cell.
    Note, the fuel cell current <var>I</var><sub>FC</sub>&nbsp;= &alpha;<sub>FC</sub>&nbsp;<var>I</var><sub>FC,max</sub>,
    where <var>I</var><sub>FC,max</sub> is the maximum allowed current.
  </li>
  <li>
    The axle torque distribution ratio, &alpha;<sub>AD</sub>&nbsp;&isin;&nbsp;[0,&nbsp;1],
    to determine the front and rear distribution of the desired torque, see also
    <a href=\"modelica://VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.Components.TorqueVectoring\">Components.TorqueVectoring</a>.
  </li>
  <li>
    The torque vectoring ratio, &alpha;<sub>TV</sub>&nbsp;&isin;&nbsp;[0,&nbsp;1], to determine
    the torque allocation between right and left rear motors, see also
    <a href=\"modelica://VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.Components.TorqueVectoring\">Components.TorqueVectoring</a>.
  </li>
  <li>
    The velocity derating factor, &alpha;<sub><var>v</var></sub>&nbsp;&isin;&nbsp;[0,&nbsp;1],
    which decreases the reference velocity&nbsp;<var>v</var> to
    &alpha;<sub><var>v</var></sub>&nbsp;<var>v</var>. It offers an additional degree of freedom
    to prevent violation of safety constraints in the system (e.g. over-discharge of the battery).
  </li>
</ol>
<p>
The <em>baseline policy</em> of the energy management algorithm (bEMA) is a&nbsp;simple example policy
provided for the IEEE MVC 2023, III.D.&nbsp;<em>EMA Baseline Policy</em>,
[<a href=\"modelica://VDCWorkbenchModels.UsersGuide.References\">Brembeck2022</a>].
This policy enforces
</p>
<ul>
  <li>
    constant usage of the fuel cell (with constant ratio &alpha;<sub>FC</sub> given by
    <code>EMAbaseline_kfc</code>) if safety constraints are fulfilled; it disables the fuel
    cell whenever violation of <var>SoC</var> constraints occur,
  </li>
  <li>
    constant front-rear torque distribution ratio &alpha;<sub>AD</sub> (given by <code>EMAbaseline_a_ad</code>),
  </li>
  <li>
    a&nbsp;torque allocation policy proportional to the expected lateral acceleration of
    the vehicle, with proportional factor <code>EMAbaseline_ktv</code>,
  </li>
  <li>
    a&nbsp;simple derating strategy that reduces the maximum vehicle velocity whenever
    the battery <var>SoC</var> are violated.
  </li>
</ul>
</html>"));
end BEMA;
