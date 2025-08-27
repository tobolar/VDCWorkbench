within VDCWorkbenchModels.Utilities.Blocks;
model IntervalTest "Detect whether the input is between the lower limit and the upper limit"

  parameter Real upperLimit(start=1) "Upper limit of input signal";
  parameter Real lowerLimit(max=upperLimit) = -upperLimit "Lower limit of input signal";

  Modelica.Blocks.Interfaces.RealInput u "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Logical.LessEqualThreshold upperTest(final threshold=upperLimit)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold lowerTest(final threshold=lowerLimit)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Logical.And intervalCheck
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
equation
  connect(u, lowerTest.u) annotation (Line(points={{-120,0},{-40,0},{-40,-30},{-22,-30}}, color={0,0,127}));
  connect(u, upperTest.u) annotation (Line(points={{-120,0},{-40,0},{-40,30},{-22,30}}, color={0,0,127}));
  connect(upperTest.y, intervalCheck.u1) annotation (Line(points={{1,30},{20,30},{20,0},{36,0}}, color={255,0,255}));
  connect(lowerTest.y, intervalCheck.u2) annotation (Line(points={{1,-30},{20,-30},{20,-8},{36,-8}}, color={255,0,255}));
  connect(intervalCheck.y, y) annotation (Line(points={{59,0},{110,0}}, color={255,0,255}));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Line(
          points={{-34,24},{-80,4},{-34,-16}},
          thickness=0.5),
        Line(
          points={{-80,-26},{-34,-26}},
          thickness=0.5),
        Line(
          points={{-4,24},{42,4},{-4,-16}},
          thickness=0.5),
        Line(
          points={{-4,-26},{42,-26}},
          thickness=0.5),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,60},{100,90}},
          textString="%upperLimit",
          textColor={0,0,0}),
        Text(
          extent={{-100,-90},{100,-60}},
          textString="%lowerLimit",
          textColor={0,0,0}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
The boolean output&nbsp;<var>y</var> is <em>true</em> as long as the real input&nbsp;<var>u</var>
is between the lower limit and the upper limit, otherwise it is <em>false</em>.
</p>
</html>"));
end IntervalTest;
