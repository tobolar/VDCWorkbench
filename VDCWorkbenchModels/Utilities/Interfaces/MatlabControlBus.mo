within VDCWorkbenchModels.Utilities.Interfaces;
expandable connector MatlabControlBus "Control bus collecting all signals needed for FMU in Matlab"
//  extends Modelica.Icons.SignalBus;

  // Signals of battery
  VDCWorkbenchModels.Utilities.Types.StateOfCharge battery_SOC "Battery state of charge (0..1)";
  Modelica.Units.SI.Voltage battery_voltage
    "Battery pack terminal voltage (= pin_p.v - pin_n.v)";
  Modelica.Units.SI.Current battery_current "Battery pack current (= pin_n.i)";
  Modelica.Units.SI.HeatFlowRate battery_Qflow "Heat flow from battery";

  // Signals of three electric drives
  Modelica.Units.SI.AngularVelocity eDriveFM_angularVelocity "Electric drive front: angular velocity";
  Modelica.Units.SI.Torque eDriveFM_torque "Electric drive front: torque";
  Modelica.Units.SI.Power eDriveFM_mechanicPower "Electric drive front: mechanical power";
  Modelica.Units.SI.Power eDriveFM_electricPower "Electric drive front: electrical power";
  Modelica.Units.SI.Power eDriveFM_powerLoss "Electric drive front: power losses";
  Modelica.Units.SI.Current eDriveFM_Iq "Electric drive front: Current on stator's q-axis denoted in the rotor reference frame";

  Modelica.Units.SI.AngularVelocity eDriveRL_angularVelocity "Electric drive rear left: angular velocity";
  Modelica.Units.SI.Torque eDriveRL_torque "Electric drive rear left: torque";
  Modelica.Units.SI.Power eDriveRL_mechanicPower "Electric drive rear left: mechanical power";
  Modelica.Units.SI.Power eDriveRL_electricPower "Electric drive rear left: electrical power";
  Modelica.Units.SI.Power eDriveRL_powerLoss "Electric drive rear left: power losses";
  Modelica.Units.SI.Current eDriveRL_Iq "Electric drive rear left: Current on stator's q-axis denoted in the rotor reference frame";

  Modelica.Units.SI.AngularVelocity eDriveRR_angularVelocity "Electric drive rear right: angular velocity";
  Modelica.Units.SI.Torque eDriveRR_torque "Electric drive rear right: torque";
  Modelica.Units.SI.Power eDriveRR_mechanicPower "Electric drive rear right: mechanical power";
  Modelica.Units.SI.Power eDriveRR_electricPower "Electric drive rear right: electrical power";
  Modelica.Units.SI.Power eDriveRR_powerLoss "Electric drive rear right: power losses";
  Modelica.Units.SI.Current eDriveRR_Iq "Electric drive rear right: Current on stator's q-axis denoted in the rotor reference frame";

  // Signals of range extender
  Modelica.Units.SI.Power rex_H2Power "Range extender: Current power of hydrogen range extender";
  Modelica.Units.SI.Power rex_H2PowerLoss "Range extender: Power losses of hydrogen range extender";
  Modelica.Units.SI.Volume rex_H2TankContent(displayUnit="l") "Range extender: Content of the hydrogen tank";
  VDCWorkbenchModels.Utilities.Types.StateOfCharge rex_H2SoC "Range extender: state of charge (0..1)";

  // Signals of chassis
  Modelica.Units.SI.Angle chassis_steeringWheelAngle "Chassis: Steering wheel angle";
  Modelica.Units.SI.AngularVelocity chassis_yawRate "Chassis: Yaw rate of chassis";
  Modelica.Units.SI.Angle chassis_sideSlipAngle "Chassis: Side slip angle of chassis";
  // Modelica.Units.SI.Distance chassis_travelledDistance "Chassis: Travelled distance of chassis";
  Modelica.Units.SI.Velocity chassis_longitudinalVelocity "Chassis: Longitudinal velocity of chassis";
  Modelica.Units.SI.Velocity chassis_longitudinalVelocity_start
    "Chassis: Initial longitudinal velocity of chassis";
  Modelica.Units.SI.Acceleration chassis_longitudinalAcceleration
    "Chassis: Longitudinal acceleration of chassis";
  Modelica.Units.SI.Acceleration chassis_lateralAcceleration
    "Chassis: Lateral acceleration of chassis";
  // Modelica.Units.SI.Position chassis_position_0[3] "Chassis: Absolute position of chassis (x, y, phi) resolved in world frame";
  // Modelica.Units.SI.Velocity chassis_velocity_0[3] "Chassis: Absolute velocity of chassis (dx, dy, dphi) resolved in world frame";
  // Modelica.Units.SI.Acceleration chassis_acceleration_0[3] "Chassis: Absolute acceleration of chassis (dx, dy, dphi) resolved in world frame";

  // Signals of chassis control
  Modelica.Units.SI.Angle chassisDemand_steeringWheelAngle "Chassis control: Demanded steering wheel angle";
  Modelica.Units.SI.Torque chassisDemand_torque "Chassis control: Demanded overall drive torque";

  annotation (
    Documentation(info="<html>
<p>An empty expandable connector used as the top-level control signal bus in VehicleInterfaces.</p>
</html>"),
    Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}, initialScale=0.2),
      graphics={
          Rectangle(
            lineColor={85,170,255},
            lineThickness=0.5,
            extent={{-20,-2},{20,2}}),
          Polygon(
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid,
            points={{-80,50},{80,50},{100,30},{80,-40},{60,-50},{-60,-50},{-80,-40},{-100,30}},
            smooth=Smooth.Bezier),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-65,15},{-55,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-5,15},{5,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{55,15},{65,25}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{-35,-25},{-25,-15}}),
          Ellipse(
            fillPattern=FillPattern.Solid,
            extent={{25,-25},{35,-15}})}),
    Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}, initialScale=0.2),
      graphics={
        Polygon(
          points={{-40,25},{40,25},{50,15},{40,-20},{30,-25},{-30,-25},{-40,-20},{-50,15}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          smooth=Smooth.Bezier),
        Ellipse(
          extent={{-32.5,7.5},{-27.5,12.5}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2.5,12.5},{2.5,7.5}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{27.5,12.5},{32.5,7.5}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-17.5,-7.5},{-12.5,-12.5}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{12.5,-7.5},{17.5,-12.5}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,70},{150,40}},
          textString="%name")}));
end MatlabControlBus;
