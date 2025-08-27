within VDCWorkbenchModels.Data.BaseRecords;
record Chassis "Basic record containing template chassis parameters"
  extends Modelica.Icons.Record;

  // Vehicle parameters
  parameter String variantName= "" "Name of identification variant";

  parameter Modelica.Units.SI.Mass m_vehicle=1046 "Total mass of vehicle";
  parameter Modelica.Units.SI.Mass m_body=690 "Mass of vehicle's body";
  parameter Modelica.Units.SI.Inertia Jz_vehicle=1130 "Yaw inertia of vehicle";

  parameter Modelica.Units.SI.Length wheelBase=2.398 "Wheel base of vehicle";
  parameter Modelica.Units.SI.Length trackWidth=1.45 "Track width of vehicle";
  parameter Modelica.Units.SI.Inertia J_steer=5 "Total rack pinion steering inertia";
  parameter Real steeringRatio = 16 "Steering gearbox ratio";

  parameter Real c_W(min=0) = 0.55 "Drag coefficient" annotation (Dialog(group="Resistances"));
  parameter Modelica.Units.SI.Area area(min=0) = 1.95 "Frontal cross area of vehicle" annotation (Dialog(group="Resistances"));

  // Wheel parameters
  parameter Modelica.Units.SI.Length R0=0.27 "Undeflected radius of the wheel" annotation (Dialog(tab="Wheel and tire"));
  parameter Modelica.Units.SI.Inertia J_wheel=0.9
    "Wheel inertia in driving direction" annotation (Dialog(tab="Wheel and tire"));
  parameter Real cf(unit="N/rad")=50e3 "Front cornering stiffness"
    annotation(Dialog(tab="Wheel and tire"));
  parameter Real cr(unit="N/rad")=50e3 "Rear cornering stiffness"
    annotation(Dialog(tab="Wheel and tire"));
  parameter Modelica.Units.SI.Velocity vAdhesion=2.66 "Adhesion velocity" annotation (Dialog(tab="Wheel and tire"));
  parameter Real mu_A = 2671/(m_vehicle*9.81/4) "Friction coefficient at adhesion" annotation (Dialog(tab="Wheel and tire"));
  parameter Modelica.Units.SI.Velocity vSlide=21 "Sliding velocity" annotation (Dialog(tab="Wheel and tire"));
  parameter Real mu_S = 1758/(m_vehicle *9.81/4) "Friction coefficient at sliding" annotation (Dialog(tab="Wheel and tire"));
  parameter Real s[2] = {1,0} "Driving direction of wheel in vehicle's coordinate system" annotation (Dialog(tab="Wheel and tire"));

  // Drivetrain parameters
  parameter Modelica.Units.SI.Torque Torque_max_frontMotor=320 "Maximum torque front motor" annotation (Dialog(group="Drivetrain parameters"));
  parameter Modelica.Units.SI.Torque Torque_max_rearMotor=160 "Maximum torque rear motor" annotation (Dialog(group="Drivetrain parameters"));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-140,-100},{140,-130}},
          textColor={0,0,0},
          textString="%variantName")}),
    Documentation(info="<html>
<p>
This record contains template data of a&nbsp;hydrogen (H<sub>2</sub>) range extender.
Extend from this record to create a&nbsp;new record of particular range extender.
</p>
</html>"));
end Chassis;
