within VDCWorkbenchModels.VehicleComponents.Chassis.BaseClasses;
partial model InterfacesAxle "Interface definition for vehicle's axle"
  extends Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort;

  PlanarMechanics.Interfaces.Frame_b frameChassis "Chassis reference frame" annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={0,-100})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flangeWheelLeft
    "Flange of left wheel" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flangeWheelRight
    "Flange of right wheel" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Utilities.Interfaces.ControlBus controlBus annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={100,60})));
  annotation (
    Documentation(info="<html>
<p>
This partial model defines the interfaces required for the vehicle&apos;s
axle.
</p>
</html>"));
end InterfacesAxle;
