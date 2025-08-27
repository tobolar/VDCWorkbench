within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector ElectricMotorControlBus "Do not use - Expandable connector defining signals for electric traction motor control bus"
  extends VDCWorkbenchModels.Utilities.Interfaces.ElectricDriveControlBus;

  Modelica.Units.SI.Torque torque "Demanded torque of electric drive" annotation (Dialog);
  annotation (
    Documentation(
      info="<html>
<p>
An expandable connector that defines signals required on the <strong>electricDriveControlBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-10,4},{8,-4}},
          lineColor={255,204,51},
          lineThickness=0.5)}));
end ElectricMotorControlBus;
