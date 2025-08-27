within VDCWorkbenchModels.Utilities.Interfaces;
expandable connector RefBus
  "Bus of VDCWorkbenchModels.Utilities.Interfaces: Empty expandable connector used for reference signals of the EMA"
  extends Modelica.Icons.SignalSubBus;

  annotation (
    defaultComponentName="refBus",
    defaultComponentPrefixes="protected",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-8,6},{10,-2}},
          lineColor={255,204,51},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.1)),
    Documentation(info="<html>
<p>An expandable connector used as electric drive bus which should contain signals measured in the electric drive subsystem. It is defined as an empty expandable connector.</p>
</html>"));
end RefBus;
