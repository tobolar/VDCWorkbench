within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector RexBus
  "Do not use - Expandable connector defining signals for range extender bus"
  extends VDCWorkbenchModels.Utilities.Interfaces.RexBus;

  Modelica.Units.SI.Power H2Power "Current power of hydrogen range extender";
  Modelica.Units.SI.Power H2PowerLoss "Power losses of hydrogen range extender";
  Modelica.Units.SI.Volume H2TankContent(displayUnit="l") "Content of the hydrogen tank";
  VDCWorkbenchModels.Utilities.Types.StateOfCharge H2SoC "Range extender state of charge (0..1)";

  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines the minimum set of signals required on the <strong>rexBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));
end RexBus;
