within VDCWorkbenchModels.Data.Tracks;
record Techlab2SBahnTIPI "Track from DLR's TechLab to S-Bahn (NonOpt)"
  extends BaseTrack(
    variantName="DLR TechLab to S-Bahn (NonOpt)",
    filePath=ModelicaServices.ExternalReferences.loadResource("modelica://VDCWorkbenchModels/Resources/Maps/Techlab2SBahn-NonOpt_TIPI.mat"),
    pathName="path_TIPI",
    isClosed=false,
    maxArcLength=2.312560625428274e+03);

end Techlab2SBahnTIPI;
