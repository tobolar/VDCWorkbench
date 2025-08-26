within VDCWorkbenchModels.Utilities.Interfaces;
expandable connector MotionDemandBus "Bus of VDCWorkbenchModels.Utilities.Interfaces: Bus for controlling the PFC problem"
  extends Modelica.Icons.SignalSubBus;
annotation (
    defaultComponentName="motionDemandBus",
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
    <p>An expandable connector used for PFC signal bus which should contain signals measured in the path following. It is defined as an empty expandable connector.</p>
</html>"));
end MotionDemandBus;
