within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector BatteryBus "Do not use - Expandable connector defining signals for energy storage bus"
  extends VehicleInterfaces.Interfaces.BatteryBus;

  VDCWorkbenchModels.Utilities.Types.StateOfCharge SOC "Battery state of charge (0..1)";
  Modelica.Units.SI.Voltage voltage
    "Battery pack terminal voltage (= pin_p.v - pin_n.v)";
  Modelica.Units.SI.Current current "Battery pack current (= pin_n.i)";
  Modelica.Units.SI.HeatFlowRate Q_flow "Heat flow from battery";

  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines the minimum set of signals required on the <strong>batteryBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));
end BatteryBus;
