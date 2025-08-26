within VDCWorkbenchModels.Utilities.Interfaces.Internal;
expandable connector ElectricMotorBus "Do not use - Expandable connector defining signals for electric traction motor bus"
  extends VDCWorkbenchModels.Utilities.Interfaces.ElectricDriveBus;

  Modelica.Units.SI.AngularVelocity angularVelocity "Electric drive angular velocity";
  Modelica.Units.SI.Torque torque "Electric drive torque";
  Modelica.Units.SI.Power mechanicPower "Mechanical power";
  Modelica.Units.SI.Power electricPower "Electrical power";
  Modelica.Units.SI.Power powerLoss "Power losses of electric drive";
  Modelica.Units.SI.Current I_q "Current on stator's q-axis denoted in the rotor reference frame";

  annotation (
    Documentation(info="<html>
<p>
An expandable connector that defines signals required on the <strong>electricDriveBus</strong>.
This connector shall <strong>not</strong> be used in models and is included here to enable
connection dialog (i.e. the GUI) for signal buses.
</p>
</html>"),
    Diagram(graphics={
        Text(
          extent={{-100,-40},{100,-80}},
          textColor={255,0,0},
          textString="Do not use!")}));
end ElectricMotorBus;
