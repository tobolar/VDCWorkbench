within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector StandardEMAControls "Do not use - Expandable connector defining signals for EMA bus"
  extends VDCWorkbenchModels.Utilities.Interfaces.EMAControls;

  Real alpha_v "Down scale vector for velocity ";
  Real alpha_AD "Front-rear allocation ratio [0-1]";
  Real alpha_TV "Torque Vector ratio (=1 means all torque applied to right motor)";
  Modelica.Units.SI.Current alpha_FC "Maximum fuel cell current";

  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines the minimum set of signals required on the <strong>eMAControls</strong> bus.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));
end StandardEMAControls;
