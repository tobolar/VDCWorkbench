within VDCWorkbenchModels.Examples.VehicleDrivetrains.VariantsVehicleDrivetrains;
model ROMOSingleMotor
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
    includeHeatPort=true) annotation (Placement(transformation(extent={{-40,-50},{-60,-30}})));
  VehicleComponents.Powertrain.Components.ParameterizedModels.ROMOTractionMotor tractionMotor(
    useHeatPort=true) annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  Modelica.Blocks.Continuous.Integrator E_loss_total
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor P_loss
    annotation (Placement(transformation(extent={{50,-80},{70,-100}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor infinityHeatCapacitor(
    C=10000000000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-90})));
equation
  connect(battery.pin_p, tractionMotor.pin_p) annotation (Line(points={{-40,-34},{-30.2,-34}}, color={0,0,255}));
  connect(battery.pin_n, tractionMotor.pin_n) annotation (Line(points={{-40,-46},{-30,-46}}, color={0,0,255}));
  connect(tractionMotor.torque_dem, tMTorqueDemand.y) annotation (Line(points={{-26,-52},{-26,-80},{-79,-80}}, color={0,0,127}));
  connect(P_loss.port_b, infinityHeatCapacitor.port) annotation (Line(points={{70,-90},{80,-90}}, color={191,0,0}));
  connect(battery.heatPort, P_loss.port_a) annotation (Line(points={{-46,-50},{-46,-70},{30,-70},{30,-90},{50,-90}}, color={191,0,0}));
  connect(tractionMotor.heatPort, P_loss.port_a) annotation (Line(points={{-14,-50},{-14,-70},{30,-70},{30,-90},{50,-90}}, color={191,0,0}));
  connect(E_loss_total.u, P_loss.Q_flow) annotation (Line(points={{78,-60},{60,-60},{60,-79}},
        color={0,0,127}));
  connect(tractionMotor.electricMotorBus, controlBus.electricMotorBusRR) annotation (Line(
      points={{-10,-46},{-8,-46},{-8,-60},{30,-60},{30,-0.1},{100.1,-0.1}},
      color={255,204,51},
      thickness=0.5));
  connect(battery.controlBus, controlBus) annotation (Line(
      points={{-56,-50},{-56,-60},{30,-60},{30,0},{100,0}},
      color={255,204,51},
      thickness=0.5));
  connect(tractionMotor.torque, vehicle.flangeDriveRear) annotation (Line(points={{-10,-40},{0,-40},{0,-10}}, color={0,0,0}));
  annotation (
    experiment(
      StopTime=20,
      Interval=0.1));
end ROMOSingleMotor;
