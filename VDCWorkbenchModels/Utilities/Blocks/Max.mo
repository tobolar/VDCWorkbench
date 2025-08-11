within VDCWorkbenchModels.Utilities.Blocks;
block Max "Computes the maximum of the input signal"
  extends Modelica.Blocks.Interfaces.SISO;
  /*
protected
  Real ud;
initial equation
  y = u;
equation
  ud = der(u);
  der(y) = if y < u and ud > 0 then ud else 0;
*/
  /*
protected
  Real ud;
initial equation
  y = u;
equation
  ud = der(u);
  when {ud < 0,terminal()} then
    y = max(u, pre(y));
  end when;
*/
  /*
protected
  Real ud;
  Real q;
initial equation
  y = u;
equation
  ud = der(u);
  if q > 0 then
    der(y) = 0;
    q = y - u;
  elseif ud > 0 then
    der(y) = ud;
    q = -1;
  else
    der(y) = 0;
    q = y - u;
  end if;
*/
  /*
protected
  Real ud;
  Real q;
initial equation
  y = u;
equation
  ud = der(u);
  if q < 0 and ud > 0 then
    der(y) = ud;
    q = -1;
  else
    der(y) = 0;
    q = y - u;
  end if;
*/
protected
  Real ud;
  Real q;
  Real yMaxCriticalPoints;
initial equation
  yMaxCriticalPoints = u;
equation
  ud = der(u);
  if q < 0 and ud > 0 then
    y = u;
    q = -1;
  else
    y = yMaxCriticalPoints;
    q = y - u;
  end if;
  when {ud < 0} then
    yMaxCriticalPoints = max(u, pre(yMaxCriticalPoints));
  end when;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
        Line(points={{-80,-80},{78,-80}}, color={192,192,192}),
        Polygon(
          points={{96,-79},{74,-71},{74,-87},{96,-79}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,-6},{-63,2},{-51,11},{-42,22},{-35,31},{-28,35},{-23,
              32},{-8,2.06},{0,-17.45},{8,-33.541},{16,-43.271},{24,-45.629},
              {32,-41.428},{40,-32.79},{48,-22.44},{56,-12.97},{64,-6.34},{
              72,-3.5},{80,-4.39}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Line(points={{-80,34},{91,34}}, color={0,0,255}),
        Polygon(
          points={{-28,34},{-36,56},{-20,56},{-28,34}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-28,55},{-28,77}},
          color={255,0,0},
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>The <strong>maximum</strong> of the input signal&nbsp;<var>u</var> is detected.</p>
</html>"));
end Max;
