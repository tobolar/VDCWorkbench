within VDCWorkbenchModels.Utilities.Blocks;
block TerminateSimulation
  "Terminate simulation if condition is fulfilled"

  Modelica.Blocks.Interfaces.BooleanInput condition
    "Terminate simulation when condition becomes true" annotation (
      Placement(transformation(extent={{-222,-10},{-202,10}})));
  parameter String terminationText="... End condition reached"
    "Text that will be displayed when simulation is terminated";

equation
  when condition then
    terminate(terminationText);
  end when;
  annotation (Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-200,-20},{-20,20}},
        initialScale=0.2),
        graphics={
      Rectangle(fillColor={235,235,235},
        fillPattern=FillPattern.Solid,
        lineThickness=5,
        borderPattern=BorderPattern.Raised,
        extent={{-200,-22},{-22,20}}),
      Text(extent={{-304,-15},{56,15}},
        textString="%condition"),
      Rectangle(fillColor={161,35,41},
        fillPattern=FillPattern.Solid,
        borderPattern=BorderPattern.Raised,
        extent={{-64,-14},{-38,14}}),
      Text(textColor={0,0,255},
        extent={{-170,22},{-40,40}},
        textString="%name")}), Documentation(info="<html>
<p>
Terminate the simulation if the boolean input <code>condition</code> becomes <strong>true</strong>.
A&nbsp;termination message explaining the reason for the termination can be given via
parameter <code>terminationText</code>.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-200,-20},{-20,20}})));
end TerminateSimulation;
