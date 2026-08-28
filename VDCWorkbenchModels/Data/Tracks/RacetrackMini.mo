within VDCWorkbenchModels.Data.Tracks;
record RacetrackMini "Race track by DLR for miniAFM"
  extends BaseTrack(
    variantName="Racetrack Mini",
    filePath=ModelicaServices.ExternalReferences.loadResource("modelica://VDCWorkbenchModels/Resources/Maps/RacetrackMini.mat"),
    pathName="path",
    isClosed=true,
    maxArcLength=22.737000000000002);

end RacetrackMini;
