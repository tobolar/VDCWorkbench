within VDCWorkbenchModels.Data.BaseRecords;
record TractionMotor "Basic record containing template data of traction motor"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;

  parameter String variantName= "" "Name of identification variant";
  parameter Integer p=19 "Pole pair number" annotation(Dialog(tab="Motor"));
  parameter Modelica.Units.SI.Voltage V0=273/sqrt(3)/sqrt(2)
    "Open circuit voltage at w_nominal"
    annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.MagneticFlux psi_PM=sqrt(2)*V0/(2*pi*fNominal)
    "Magnets flux" annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.Frequency fNominal=320
    "Nominal frequency " annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.Current INominal=16
    "Nominal phase current" annotation (Dialog(tab="Motor"));
  parameter Modelica.Units.SI.AngularVelocity wNominal=2*pi*fNominal/p
    "Nominal speed" annotation (Dialog(group="Load"));
  parameter Modelica.Units.SI.Torque tauNominal=160 "Nominal torque"
    annotation (Dialog(group="Load"));

  parameter Modelica.Units.SI.Inertia J_r=0.07
    "Rotor's moment of inertia" annotation (Dialog(tab="Motor"));

  //------------------------------------------------------------------------------------------------
  // nominal inductances and resistances

  parameter Modelica.Units.SI.Resistance R_s=0.099
    "Warm stator resistance per phase"
    annotation (Dialog(tab="Motor", group="Impedances"));
  parameter Modelica.Units.SI.Inductance L_1=0.00081
    "Main motor inductance"
    annotation (Dialog(tab="Motor", group="Impedances"));

  //------------------------------------------------------------------------------------------------
  // Constants for modelling losses

  parameter Modelica.Units.SI.Torque tauFricRef=0.2
    "Friction torque of motor in Nm at wNominal"
    annotation (Dialog(tab="Motor", group="Losses"));
  parameter Real kHyst(unit="W.s/rad")=0.095 "Hysteresis losses constant" annotation (Dialog(tab="Motor",group="Losses"));
  parameter Real kEddy(unit="W.s2/rad2")=9e-5 "Eddy current losses constant"  annotation (Dialog(tab="Motor",group="Losses"));
  parameter Real kfric(unit="W.s/rad")=0.155 "Motor friction constant"  annotation (Dialog(tab="Motor",group="Losses"));
  parameter Modelica.Units.SI.Power InverterLossConstant=95 "Constant inverter losses" annotation (Dialog(tab="Motor",group="Losses"));
  parameter Real InverterLossCoefficient(unit="W/A")=5 "Inverter losses proportional to Iq/torque"
    annotation (Dialog(tab="Motor",group="Losses"));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-140,-100},{140,-130}},
          textColor={0,0,0},
          textString="%variantName")}),
    Documentation(
      info="<html>
<p>
This record contains template data of a&nbsp;traction motor.
Extend from this record to create a&nbsp;new record of particular range extender.
</p>
</html>"));
end TractionMotor;
