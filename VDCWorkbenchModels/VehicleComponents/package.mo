within VDCWorkbenchModels;
package VehicleComponents "Collection of vehicle modules"
  extends Modelica.Icons.Package;

  final constant String MapDir = Modelica.Utilities.Files.loadResource(
      "modelica://VDCWorkbenchModels/Resources/Maps/")
    "Absolute path name of the directory where maps (i.e. characteristics) of MVChallengeModels library are stored";

  annotation (Documentation(info="<html>
<p>
Here are collected vehicle components and modules which are used to establish vehicle
architectures. In particular, they are chassis for planar vehicle dynamics, hybrid powertrains
and vehicle controllers.
</p>
</html>"));
end VehicleComponents;
