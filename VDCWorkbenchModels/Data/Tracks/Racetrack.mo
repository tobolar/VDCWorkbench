within VDCWorkbenchModels.Data.Tracks;
record Racetrack "Race track by DLR"
  extends BaseTrack(
    variantName="Racetrack",
    filePath=ModelicaServices.ExternalReferences.loadResource("modelica://VDCWorkbenchModels/Resources/Maps/Racetrack.mat"),
    pathName="path",
    isClosed=true,
    maxArcLength=150);

end Racetrack;
