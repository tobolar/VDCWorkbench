within VDCWorkbenchModels;
package Data "Collection of data sets"
  extends Modelica.Icons.Package;

annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
          {100,100}}), graphics={
      Ellipse(
        extent={{-56,-12},{44,-50}},
        lineColor={0,0,255},
        fillColor={140,140,140},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-56,-2},{44,-32}},
        fillColor={140,140,140},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{-56,18},{44,-22}},
        lineColor={0,0,255},
        fillColor={180,180,180},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-56,28},{44,0}},
        fillColor={180,180,180},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{-56,48},{44,8}},
        lineColor={0,0,255},
        fillColor={180,180,180},
        fillPattern=FillPattern.Solid),
      Line(
        points={{-56,28},{-56,-32}},
        smooth=Smooth.None,
        color={0,0,255}),
      Line(
        points={{44,28},{44,-32}},
        smooth=Smooth.None,
        color={0,0,255})}), Documentation(info="<html>
<p>
This package contains datasets for various parametrization of a&nbsp;vehicle.
</p>
</html>"));
end Data;
