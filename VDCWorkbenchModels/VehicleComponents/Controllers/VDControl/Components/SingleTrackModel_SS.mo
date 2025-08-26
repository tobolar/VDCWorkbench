within VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.Components;
model SingleTrackModel_SS "Quasi-static inverse single-track model"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.Units.SI.Mass m=1000 "Vehicle mass";
  parameter Modelica.Units.SI.Length lf=1.2 "Distance of CoG to front axle";
  parameter Modelica.Units.SI.Length lr=1.2 "Distance of CoG to rear axle";
  parameter Modelica.Units.SI.Inertia J=1000 "Yaw inertia";
  parameter Real cf(unit="N/rad")=30e3 "Cornering stiffness of front axle";
  parameter Real cr(unit="N/rad")=30e3 "Cornering stiffness of rear axle";

  parameter Modelica.Units.SI.Acceleration ayMax = 3 "Maximum allowed lateral acceleration";

  Real r; // yaw rate
  Real beta_;// side-slip
  Real steer_f_; // front steering angle

  Real v_sat; // saturated velocity (avoid division by zero)

  //auxiliary variables
  Real a1;
  Real a2;
  Real a3;
  Real a4;
  Real b1;
  Real b2;
  Real b3;

  Modelica.Blocks.Interfaces.RealInput Mz_TorqueVect(unit="N.m")
    "Yaw Moment from torque vectoring"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput v(unit="m/s") "Velocity" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealInput curvature(unit="1/m") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,60})));
  Modelica.Blocks.Interfaces.RealOutput beta(unit="rad")
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput yaw_rate(unit="rad/s")
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput steer_f(unit="rad") "Front steering angle"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Sources.RealExpression expr_beta(y=beta_) annotation (Placement(transformation(extent={{54,-14},{90,14}})));
  Modelica.Blocks.Sources.RealExpression expr_yawRate(y=r) annotation (Placement(transformation(extent={{54,-74},{90,-46}})));

  Modelica.Blocks.Sources.RealExpression expr_steer_f(y=steer_f_) annotation (Placement(transformation(extent={{54,46},{90,74}})));
  Modelica.Blocks.Nonlinear.Limiter v_lim(uMax=1e3, uMin=0.1)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Nonlinear.VariableLimiter curvature_lim
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
  Modelica.Blocks.Sources.Constant const_ayMax(k=ayMax) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-4,14},{8,26}})));
equation
  connect(expr_beta.y, beta) annotation (Line(points={{91.8,1.77636e-15},{91.8,0},{110,0}}, color={0,0,127}));
  connect(expr_yawRate.y, yaw_rate) annotation (Line(points={{91.8,-60},{110,-60}}, color={0,0,127}));
        v_sat=v_lim.y;

        // Compute auxiliary variables for the Single Track Model
        // Source: Ackerman Book (p.195)
        a1 = -(cf+cr)/(m*v_sat);
        a2 = -1 + (cr*lr - cf*lf)/(m*v_sat^2);
        a3 =  (cr*lr - cf*lf)/J;
        a4 = -(cr*lr^2 + cf*lf^2)/(J*v_sat);
        b1 = cf/(m*v_sat);
        b2 = cf*lf/(J);
        b3 = 1/J;

        // single track model in steady state conditions
        0=a1*beta_ + a2*r + b1*steer_f;
        0=a3*beta_ + a4*r + b2*steer_f + b3*Mz_TorqueVect;
        0=v_sat*curvature_lim.y - r;

  connect(v, v_lim.u) annotation (Line(points={{-120,0},{-92,0}},
                     color={0,0,127}));
  connect(expr_steer_f.y, steer_f) annotation (Line(points={{91.8,60},{110,60}}, color={0,0,127}));
  connect(curvature, curvature_lim.u)
    annotation (Line(points={{-120,60},{10,60},{10,40},{18,40}},
        color={0,0,127}));
  connect(v_lim.y, product1.u1) annotation (Line(points={{-69,0},{-60,0},{-60,3.6},{-57.2,3.6}},
        color={0,0,127}));
  connect(division.y, curvature_lim.limit1) annotation (Line(points={{-13.4,20},{-10,20},{-10,48},{18,48}},
        color={0,0,127}));
  connect(gain.y, curvature_lim.limit2) annotation (Line(points={{8.6,20},{10,20},{10,32},{18,32}},
        color={0,0,127}));
  connect(gain.u, division.y) annotation (Line(points={{-5.2,20},{-13.4,20}},
        color={0,0,127}));
  connect(product1.y, division.u2) annotation (Line(points={{-43.4,0},{-32,0},{-32,16},{-27.2,16},{-27.2,16.4}},
        color={0,0,127}));
  connect(const_ayMax.y, division.u1) annotation (Line(points={{-39,30},{-32,30},{-32,23.6},{-27.2,23.6}}, color={0,0,127}));
  connect(v_lim.y, product1.u2) annotation (Line(points={{-69,0},{-60,0},{-60,-3.6},{-57.2,-3.6}}, color={0,0,127}));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-8,34},{8,-34}},
          lineColor={0,0,0},
          radius=10,
          origin={0,-52},
          rotation=-30,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,34},{8,-34}},
          lineColor={0,0,0},
          radius=10,
          origin={0,50},
          rotation=50,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,50},{6,-50}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-104,92},{90,-78}},
          textColor={0,0,0},
          textString="(  )"),
        Text(
          extent={{50,82},{94,54}},
          textColor={0,0,0},
          textString="-1")}),
    Diagram(
      coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-92,-20},{-20,-30}},
          textColor={28,108,200},
          textString="Maximum Curvature (rho_max=ayMax/V^2)")}),
    Documentation(info="<html>
<p>
A&nbsp;simplified single-track model according to
[<a href=\"modelica://VDCWorkbenchModels.UsersGuide.References\">Ackermann2002</a>]
which can be used e.g. for vehicle&apos;s
<a href=\"modelica://VDCWorkbenchModels.VehicleComponents.Controllers.VDControl.MVCLateralControl\">lateral control</a>.
</p>
<p>
The vehicle&apos;s reference side-slip angle <code>beta</code>, the yaw rate
<code>yaw_rate</code> and the steering angle <code>steer_f</code> are generated depending
on the vehicle velocity&nbsp;<code>v</code> and the torque vectoring generated by the
in-wheel motors <code>Mz_TorqueVect</code>.
A&nbsp;feedforward control law realized herewith allows the vehicle to follow the reference
<code>curvature</code> when the model uncertainty is reduced.
The model assumes a&nbsp;quasi-static motion, i.e. slow variations in path curvature.
</p>
For further details, please refer to the IEEE MVC 2023, III.F.&nbsp;<em>Vehicle Motion Controller</em>,
[<a href=\"modelica://VDCWorkbenchModels.UsersGuide.References\">Brembeck2022</a>].
</html>"));
end SingleTrackModel_SS;
