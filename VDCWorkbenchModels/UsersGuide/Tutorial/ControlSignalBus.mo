within VDCWorkbenchModels.UsersGuide.Tutorial;
class ControlSignalBus "Control signal bus"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
Every subsystem has access to the control signal bus which is modelled using expandable
connectors. This means that the actual bus content is defined by connecting signals
to the bus to suit a&nbsp;particular application.
An instance of this bus is called <strong>controlBus</strong> and has the
following icon:
</p>

<div>
<img src=\"modelica://VDCWorkbenchModels/Resources/Images/UsersGuide/Tutorial/ControlSignalBus/controlBusIcon.png\" alt=\"Control bus icon\">
</div>

<p>
The controlBus collects further sub-buses which typically contain sensed or actuation signals.
The names of the sub-buses start with the name of the subsystem that is outputting the signal
on to the bus, followed by the word &quot;Bus.&quot; (if signal is sensed) or
&quot;ControlBus.&quot; (if signal is actuated).
For example, <a href=\"modelica://VDCWorkbenchModels.Utilities.Interfaces.RexBus\">RexBus</a>
is the sub-bus for sensor signals of range extender.
All used buses can be find in the package
<a href=\"modelica://VDCWorkbenchModels.Utilities.Interfaces\">Interfaces</a>.
The commonly used signals are predefined in the package
<a href=\"modelica://VDCWorkbenchModels.Utilities.Interfaces.Internal\">Interfaces.Internal</a>.
These internal definitions shall not be used directly in models but serve only for GUI purposes.
</p>

<p>
For further details, please refer to
<a href=\"modelica://VehicleInterfaces.UsersGuide.SignalBus\">VehicleInterfaces.UsersGuide.SignalBus</a>.
Note, that a&nbsp;user can add easily further signals to the controlBus by connecting signals to it.
</p>
</html>"));
end ControlSignalBus;
