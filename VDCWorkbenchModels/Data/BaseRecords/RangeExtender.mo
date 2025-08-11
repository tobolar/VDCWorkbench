within VDCWorkbenchModels.Data.BaseRecords;
record RangeExtender "Basic record containing template data of H2 range extender"
  extends Modelica.Icons.Record;

  parameter String variantName= "" "Name of identification variant";
  parameter Modelica.Units.SI.Mass H2_tank_level=40 "Initial level of H2 tank";
  parameter Real H2efficiency[:,:]=[0.0,0.01; 10000,0.52; 30000,0.58; 50000,0.5]
    "Efficiency of range extender (col. 2) over it's output power (col. 1)";
  parameter Real H2consumption[:,:]=[0.0,0.0; 100,0.3; 1000,0.09; 20000,0.07]
    "H2 consumption of range extender (col. 2) over it's output power (col. 1)";

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
end RangeExtender;
