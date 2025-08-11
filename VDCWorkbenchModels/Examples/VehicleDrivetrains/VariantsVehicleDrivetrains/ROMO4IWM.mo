within VDCWorkbenchModels.Examples.VehicleDrivetrains.VariantsVehicleDrivetrains;
model ROMO4IWM
  extends BaseConfigurations.BaseRomo(
    v_Start=0,
    redeclare replaceable Modelica.Blocks.Sources.Constant steeringWheelAngleDemand(k=0),
    redeclare replaceable Modelica.Blocks.Sources.TimeTable tMTorqueDemand(
      table=[0.0,0.0; 5,160; 10,160; 12,-160; 20,-160]),
    vehicle(
      axleFront(
        wheelRight(
          stateSelect=StateSelect.always,
          phi_roll(start=0, fixed=true), w_roll(fixed=true)),
        wheelLeft(
          stateSelect=StateSelect.always)),
      axleRear(
        wheelRight(
          stateSelect=StateSelect.always,
          phi_roll(start=0, fixed=true), w_roll(fixed=true)),
        wheelLeft(
          stateSelect=StateSelect.always))));
  VehicleComponents.Powertrain.Components.ParameterizedModels.ROMOBatteryPack90s1p battery(
    includeGround=true,
    includeHeatPort=true) annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
  VehicleComponents.Powertrain.Components.ParameterizedModels.ROMOTractionMotor tractionMotorFL(
    useHeatPort=true) annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  VehicleComponents.Powertrain.Components.ParameterizedModels.ROMOTractionMotor tractionMotorFR(
    useHeatPort=true) annotation (Placement(transformation(extent={{40,20},{20,40}})));
  VehicleComponents.Powertrain.Components.ParameterizedModels.ROMOTractionMotor tractionMotorRL(
    useHeatPort=true) annotation (Placement(transformation(extent={{-40,-40},{-20,-60}})));
  VehicleComponents.Powertrain.Components.ParameterizedModels.ROMOTractionMotor tractionMotorRR(
    useHeatPort=true) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Continuous.Integrator E_loss_total
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor P_loss
    annotation (Placement(transformation(extent={{50,-80},{70,-100}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor infinityHeatCapacitor(
    C=10000000000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-90})));
  Modelica.Blocks.Math.Gain torqueSplit(
    k=1/4)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(battery.pin_p, tractionMotorRL.pin_p) annotation (Line(points={{-60,6},{-48,6},{-48,-56},{-40.2,-56}}, color={0,0,255}));
  connect(battery.pin_n, tractionMotorRL.pin_n) annotation (Line(points={{-60,-6},{-46,-6},{-46,-44},{-40,-44}}, color={85,85,255}));
  connect(P_loss.port_b, infinityHeatCapacitor.port) annotation (Line(points={{70,-90},{80,-90}}, color={191,0,0}));
  connect(battery.heatPort, P_loss.port_a) annotation (Line(points={{-66,-10},{-66,-32},{10,-32},{10,-90},{50,-90}}, color={191,0,0}));
  connect(tractionMotorRL.heatPort, P_loss.port_a) annotation (Line(points={{-24,-40},{-24,-32},{10,-32},{10,-90},{50,-90}}, color={191,0,0}));
  connect(E_loss_total.u, P_loss.Q_flow) annotation (Line(points={{78,-60},{60,-60},{60,-79}},
        color={0,0,127}));
  connect(tractionMotorRR.heatPort, P_loss.port_a) annotation (Line(points={{24,-40},{24,-32},{10,-32},{10,-90},{50,-90}}, color={191,0,0}));
  connect(tractionMotorFR.heatPort, P_loss.port_a) annotation (Line(points={{24,20},{24,16},{-24,16},{-24,-32},{10,-32},{10,-90},{50,-90}}, color={191,0,0}));
  connect(tractionMotorFL.heatPort, P_loss.port_a) annotation (Line(points={{-24,20},{-24,-32},{10,-32},{10,-90},{50,-90}}, color={191,0,0}));
  connect(tMTorqueDemand.y, torqueSplit.u)
    annotation (Line(points={{-79,-80},{-70,-80},{-70,-80},{-62,-80}},
        color={0,0,127}));
  connect(battery.pin_p, tractionMotorRR.pin_p) annotation (Line(points={{-60,6},{-48,6},{-48,-16},{48,-16},{48,-56},{40.2,-56}}, color={0,0,255}));
  connect(battery.pin_p, tractionMotorFR.pin_p) annotation (Line(points={{-60,6},{-48,6},{-48,-16},{48,-16},{48,36},{40.2,36}}, color={0,0,255}));
  connect(battery.pin_p, tractionMotorFL.pin_p) annotation (Line(points={{-60,6},{-48,6},{-48,36},{-40.2,36}}, color={0,0,255}));
  connect(battery.pin_n, tractionMotorRR.pin_n) annotation (Line(points={{-60,-6},{-46,-6},{-46,-14},{46,-14},{46,-44},{40,-44}}, color={85,85,255}));
  connect(battery.pin_n, tractionMotorFR.pin_n) annotation (Line(points={{-60,-6},{-46,-6},{-46,-14},{46,-14},{46,24},{40,24}}, color={85,85,255}));
  connect(battery.pin_n, tractionMotorFL.pin_n) annotation (Line(points={{-60,-6},{-46,-6},{-46,24},{-40,24}}, color={85,85,255}));
  connect(torqueSplit.y, tractionMotorRL.torque_dem) annotation (Line(points={{-39,-80},{-10,-80},{-10,-26},{-36,-26},{-36,-38}}, color={0,0,127}));
  connect(torqueSplit.y, tractionMotorRR.torque_dem) annotation (Line(points={{-39,-80},{-10,-80},{-10,-26},{36,-26},{36,-38}}, color={0,0,127}));
  connect(torqueSplit.y, tractionMotorFL.torque_dem) annotation (Line(points={{-39,-80},{-10,-80},{-10,-26},{-36,-26},{-36,18}}, color={0,0,127}));
  connect(torqueSplit.y, tractionMotorFR.torque_dem) annotation (Line(points={{-39,-80},{-10,-80},{-10,-26},{36,-26},{36,18}}, color={0,0,127}));
  connect(battery.controlBus, controlBus) annotation (Line(
      points={{-76,-10},{-76,-20},{30,-20},{30,0},{100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotorFL.torque, vehicle.flangeWheelFL) annotation (Line(points={{-20,30},{-16,30},{-16,4},{-10,4}}, color={0,0,0}));
  connect(tractionMotorFR.torque, vehicle.flangeWheelFR) annotation (Line(points={{20,30},{16,30},{16,4},{10,4}}, color={0,0,0}));
  connect(tractionMotorRL.torque, vehicle.flangeWheelRL) annotation (Line(points={{-20,-50},{-16,-50},{-16,-6},{-10,-6}}, color={0,0,0}));
  connect(tractionMotorRR.torque, vehicle.flangeWheelRR) annotation (Line(points={{20,-50},{16,-50},{16,-6},{10,-6}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=20,
      Interval=0.1));
end ROMO4IWM;
