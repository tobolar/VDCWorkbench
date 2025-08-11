within VDCWorkbenchModels.Utilities.Blocks;
block MapControlBusSignals "Map control bus signals into Matlab's control bus"
  extends Modelica.Blocks.Icons.Block;
  Interfaces.ControlBus controlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-100,0})));
  Interfaces.MatlabControlBus matlabControlBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={100,0})));
protected
  Interfaces.ElectricDriveBus electricDriveBusFM "Signal bus of front middle electric drive" annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Interfaces.ElectricDriveBus electricDriveBusRL "Signal bus of rear left electric drive" annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Interfaces.ElectricDriveBus electricDriveBusRR "Signal bus of rear right electric drive" annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  VehicleInterfaces.Interfaces.ChassisBus chassisBus
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Interfaces.RexBus rexBus annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  VehicleInterfaces.Interfaces.BatteryBus batteryBus annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
public
  DeMultiplexElectricDriveBus deMultiplexDriveBusFM annotation (Placement(transformation(extent={{-8,80},{12,100}})));
  DeMultiplexElectricDriveBus deMultiplexDriveBusRL annotation (Placement(transformation(extent={{-8,50},{12,70}})));
  DeMultiplexElectricDriveBus deMultiplexDriveBusRR annotation (Placement(transformation(extent={{-8,20},{12,40}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough3 annotation (Placement(transformation(extent={{36,-24},{44,-16}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough4 annotation (Placement(transformation(extent={{20,-34},{28,-26}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough5 annotation (Placement(transformation(extent={{38,-44},{46,-36}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough6 annotation (Placement(transformation(extent={{20,-54},{28,-46}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough7 annotation (Placement(transformation(extent={{10,-66},{18,-58}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough8 annotation (Placement(transformation(extent={{22,-76},{30,-68}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough9 annotation (Placement(transformation(extent={{10,-86},{18,-78}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough10 annotation (Placement(transformation(extent={{22,-96},{30,-88}})));
  DeMultiplexChassisBus deMultiplexChassisBus annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(electricDriveBusFM, controlBus.electricMotorBusFM) annotation (Line(
      points={{-50,90},{-80,90},{-80,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexDriveBusFM.electricDriveBus, electricDriveBusFM) annotation (Line(
      points={{-8,90},{-50,90}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexDriveBusFM.angularVelocity, matlabControlBus.eDriveFM_angularVelocity) annotation (Line(points={{13,100},{80,100},{80,-0.1},{100.1,-0.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusFM.torque, matlabControlBus.eDriveFM_torque) annotation (Line(points={{13,96},{80,96},{80,-0.1},{100.1,-0.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusFM.mechanicPower, matlabControlBus.eDriveFM_mechanicPower) annotation (Line(points={{13,92},{80,92},{80,-0.1},{100.1,-0.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusFM.electricPower, matlabControlBus.eDriveFM_electricPower) annotation (Line(points={{13,88},{80,88},{80,-0.1},{100.1,-0.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusFM.powerLoss, matlabControlBus.eDriveFM_powerLoss) annotation (Line(points={{13,84},{80,84},{80,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusFM.I_q, matlabControlBus.eDriveFM_Iq) annotation (Line(points={{13,80},{80,80},{80,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(electricDriveBusRL, controlBus.electricMotorBusRL) annotation (Line(
      points={{-50,60},{-80,60},{-80,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexDriveBusRL.electricDriveBus, electricDriveBusRL) annotation (Line(
      points={{-8,60},{-50,60}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexDriveBusRL.angularVelocity, matlabControlBus.eDriveRL_angularVelocity) annotation (Line(points={{13,70},{80,70},{80,-0.1},{100.1,-0.1}},
                                                                                                                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRL.torque, matlabControlBus.eDriveRL_torque) annotation (Line(points={{13,66},{80,66},{80,-0.1},{100.1,-0.1}},
                                                                                                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRL.mechanicPower, matlabControlBus.eDriveRL_mechanicPower) annotation (Line(points={{13,62},{80,62},{80,-0.1},{100.1,-0.1}},
                                                                                                                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRL.electricPower, matlabControlBus.eDriveRL_electricPower) annotation (Line(points={{13,58},{80,58},{80,-0.1},{100.1,-0.1}},
                                                                                                                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRL.powerLoss, matlabControlBus.eDriveRL_powerLoss) annotation (Line(points={{13,54},{80,54},{80,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRL.I_q, matlabControlBus.eDriveRL_Iq) annotation (Line(points={{13,50},{80,50},{80,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(electricDriveBusRR, controlBus.electricMotorBusRR) annotation (Line(
      points={{-50,30},{-80,30},{-80,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexDriveBusRR.electricDriveBus, electricDriveBusRR) annotation (Line(
      points={{-8,30},{-50,30}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexDriveBusRR.angularVelocity, matlabControlBus.eDriveRR_angularVelocity) annotation (Line(points={{13,40},{80,40},{80,-0.1},{100.1,-0.1}},
                                                                                                                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRR.torque, matlabControlBus.eDriveRR_torque) annotation (Line(points={{13,36},{80,36},{80,-0.1},{100.1,-0.1}},
                                                                                                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRR.mechanicPower, matlabControlBus.eDriveRR_mechanicPower) annotation (Line(points={{13,32},{80,32},{80,-0.1},{100.1,-0.1}},
                                                                                                                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRR.electricPower, matlabControlBus.eDriveRR_electricPower) annotation (Line(points={{13,28},{80,28},{80,-0.1},{100.1,-0.1}},
                                                                                                                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRR.powerLoss, matlabControlBus.eDriveRR_powerLoss) annotation (Line(points={{13,24},{80,24},{80,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexDriveBusRR.I_q, matlabControlBus.eDriveRR_Iq) annotation (Line(points={{13,20},{80,20},{80,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(chassisBus, controlBus.chassisBus) annotation (Line(
      points={{-50,0},{-100.1,0},{-100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexChassisBus.chassisBus, chassisBus) annotation (Line(
      points={{-8,0},{-50,0}},
      color={255,204,51},
      thickness=0.5));
  connect(deMultiplexChassisBus.steeringWheelAngle, matlabControlBus.chassis_steeringWheelAngle) annotation (Line(points={{13,10},{80,10},{80,-0.1},{100.1,-0.1}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexChassisBus.longitudinalVelocity, matlabControlBus.chassis_longitudinalVelocity) annotation (Line(points={{13,6},{80,6},{80,-0.1},{100.1,-0.1}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexChassisBus.longitudinalAcceleration, matlabControlBus.chassis_longitudinalAcceleration) annotation (Line(points={{13,2},{80,2},{80,-0.1},{100.1,-0.1}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexChassisBus.lateralAcceleration, matlabControlBus.chassis_lateralAcceleration) annotation (Line(points={{13,-2},{80,-2},{80,-0.1},{100.1,-0.1}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexChassisBus.yawRate, matlabControlBus.chassis_yawRate) annotation (Line(points={{13,-6},{80,-6},{80,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(deMultiplexChassisBus.sideSlipAngle, matlabControlBus.chassis_sideSlipAngle) annotation (Line(points={{13,-10},{80,-10},{80,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rexBus, controlBus.rexBus) annotation (Line(
      points={{-50,-30},{-80,-30},{-80,0},{-100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(realPassThrough3.u, rexBus.H2Power) annotation (Line(points={{35.2,-20},{-20,-20},{-20,-30},{-50,-30}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough3.y, matlabControlBus.rex_H2Power) annotation (Line(points={{44.4,-20},{80,-20},{80,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough4.u, rexBus.H2PowerLoss) annotation (Line(points={{19.2,-30},{-50,-30}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough4.y, matlabControlBus.rex_H2PowerLoss) annotation (Line(points={{28.4,-30},{80,-30},{80,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough5.u, rexBus.H2SoC) annotation (Line(points={{37.2,-40},{-20,-40},{-20,-30},{-50,-30}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough5.y, matlabControlBus.rex_H2SoC) annotation (Line(points={{46.4,-40},{80,-40},{80,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough6.u, rexBus.H2TankContent) annotation (Line(points={{19.2,-50},{-20,-50},{-20,-30},{-50,-30}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough6.y, matlabControlBus.rex_H2TankContent) annotation (Line(points={{28.4,-50},{80,-50},{80,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(batteryBus, controlBus.batteryBus) annotation (Line(
      points={{-50,-80},{-80,-80},{-80,0.1},{-100.1,0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(realPassThrough7.u, batteryBus.SOC) annotation (Line(points={{9.2,-62},{-20,-62},{-20,-80},{-50,-80}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough7.y, matlabControlBus.battery_SOC) annotation (Line(points={{18.4,-62},{90,-62},{90,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough8.u, batteryBus.Q_flow) annotation (Line(points={{21.2,-72},{-20,-72},{-20,-80},{-50,-80}},
                                                                                                                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough8.y, matlabControlBus.battery_Qflow) annotation (Line(points={{30.4,-72},{90,-72},{90,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough9.u, batteryBus.current) annotation (Line(points={{9.2,-82},{-19.4,-82},{-19.4,-80},{-50,-80}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough9.y, matlabControlBus.battery_current) annotation (Line(points={{18.4,-82},{90,-82},{90,-0.1},{100.1,-0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(realPassThrough10.u, batteryBus.voltage) annotation (Line(points={{21.2,-92},{-20,-92},{-20,-80},{-50,-80}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realPassThrough10.y, matlabControlBus.battery_voltage) annotation (Line(points={{30.4,-92},{90,-92},{90,-0.1},{100.1,-0.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end MapControlBusSignals;
