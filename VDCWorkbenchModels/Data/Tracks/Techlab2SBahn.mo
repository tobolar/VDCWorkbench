within VDCWorkbenchModels.Data.Tracks;
record Techlab2SBahn "Track from DLR's TechLab to S-Bahn (NonOpt) - for GeoPFC"
  extends BaseTrack(
    variantName="DLR TechLab to S-Bahn (NonOpt)",
    filePath=ModelicaServices.ExternalReferences.loadResource("modelica://VDCWorkbenchModels/Resources/Maps/Techlab2SBahn-NonOpt.mat"),
    pathName="path",
    isClosed=false,
    maxArcLength=2.312560625428274e+03);

end Techlab2SBahn;
