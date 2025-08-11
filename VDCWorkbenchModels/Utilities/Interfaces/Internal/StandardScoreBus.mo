within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector StandardScoreBus "Do not use - Expandable connector defining signals for  score bus"
  extends VDCWorkbenchModels.Utilities.Interfaces.ScoreBus;

  Real J_total "Total energy performance metric";
  Real J_energy "Energy performance metric";
  Real J_v "Velocity derating performance metric";
  Real J_SoC "Battery and FC SoC performance metric";
  Real J_Temp "Temperature performance metric";
  Real J_batAging "Lost battery capacity due to battery aging";
  Real J_tire "Tire losses performance metric";
  Real J_loss "Total loss performance metric";
  Real StopSim "Trigger simulation termination";

  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines the minimum set of signals required on the <strong>scoreBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));
end StandardScoreBus;
