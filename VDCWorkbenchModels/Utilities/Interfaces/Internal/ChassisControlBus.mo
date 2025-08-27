within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector ChassisControlBus "Do not use - Expandable connector defining signals for chassis control bus"
  extends VehicleInterfaces.Interfaces.ChassisControlBus;

  Modelica.Units.SI.Angle steeringWheelAngle "Demanded steering wheel angle";
  Modelica.Units.SI.Torque torque "Demanded overall drive torque";
  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines the minimum set of signals required on the <strong>chassisControlBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));

end ChassisControlBus;
