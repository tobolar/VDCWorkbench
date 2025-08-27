within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector StandardReferenceBus "Do not use - Expandable connector collecting reference signals"
  extends VDCWorkbenchModels.Utilities.Interfaces.RefBus;

  Real refCurv "Reference curvature of track";
  Modelica.Units.SI.Velocity refSpeed "Reference velocity of vehicle";

  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines the minimum set of signals required on the <strong>refBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));
end StandardReferenceBus;
