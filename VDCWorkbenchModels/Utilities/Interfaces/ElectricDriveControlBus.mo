within VDCWorkbenchModels.Utilities.Interfaces;
expandable connector ElectricDriveControlBus "Bus of VDCWorkbenchModels.Utilities.Interfaces: Empty expandable connector used as electric drive control bus"
  extends Modelica.Icons.SignalSubBus;

  annotation (
    defaultComponentName="electricDriveControlBus",
    defaultComponentPrefixes="protected",
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-10,4},{8,-4}},
          lineColor={255,204,51},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.1)),
    Documentation(
      info="<html>
<p>An expandable connector used as electric drive control bus which should contain signals determined in the electric drive controller. It is defined as an empty expandable connector.</p>
</html>"));
end ElectricDriveControlBus;
