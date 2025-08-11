within VDCWorkbenchModels.Utilities.Interfaces;
expandable connector RexBus "Bus of VDCWorkbenchModels.Utilities.Interfaces: Range extender sensor signals bus"
  extends Modelica.Icons.SignalSubBus;

  annotation (
    defaultComponentPrefixes="protected",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-20,2},{20,-2}},
          lineColor={255,204,51},
          lineThickness=0.5)}),
    Documentation(info="<html>
<p>
Should be used to contain signals measured in the range extender subsystem.
It is defined as an empty expandable connector.
</p>
</html>"));
end RexBus;
