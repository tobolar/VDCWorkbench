within VDCWorkbenchModels.UsersGuide.Tutorial;
class OverView "Overview of the library"
  extends Modelica.Icons.Information;
  annotation (
    Documentation(
      info="<html>
<p>
The library is a&nbsp;<strong>free</strong> Modelica package providing models for a&nbsp;planar
vehicle motion and control.
The features is designed as follows.
</p>
<ul>
  <li>
    <a href=\"modelica://VDCWorkbenchModels.VehicleArchitectures\">VehicleArchitectures</a> collect
    architectures which typically consist of a&nbsp;vehicle dynamics model, a&nbsp;powertrain
    and a&nbsp;controller. There is also some information on vehicle&apos;s environment.
  </li>
  <li>
    <a href=\"modelica://VDCWorkbenchModels.VehicleComponents\">VehicleComponents</a> collect
    models of
    <a href=\"modelica://VDCWorkbenchModels.VehicleComponents.Chassis\">planar chassis</a>,
    <a href=\"modelica://VDCWorkbenchModels.VehicleComponents.Powertrain\">powertrains</a> and
    <a href=\"modelica://VDCWorkbenchModels.VehicleComponents.Controllers\">controllers</a>.
    which are used in the vehicle architectures.
  </li>
  <li>
    <a href=\"modelica://VDCWorkbenchModels.Data\">Data</a> are parameter records. There are basic
    records of parameter declarations to summarize parameters of abovementioned vehicle
    subsystems. Additionally, records of parameters for a&nbsp;particular vehicle are present.
    The latter are used in chassis, powertrain or controller to set proper parameter values and,
    when connecting together, to build up the particular vehicle.
    In this library, the parameters of the
    <a href=\"https://vsdc.de/en/robomobil-timeline/\">DLR&apos;s robotic vehicle ROboMObil</a>
    are widely used.
  </li>
  <li>
    <a href=\"modelica://VDCWorkbenchModels.FMUs\">FMUs</a> accommodate both models intended for
    a&nbsp;FMU export and imported FMUs.
  </li>
  <li>
    <a href=\"modelica://VDCWorkbenchModels.Examples\">Examples</a> show how to use models and
    architectures in simulatable demos. Note, there are also additional examples all over the
    library for components&apos; demonstrations.
  </li>
</ul>
</html>"));
end OverView;
