within VDCWorkbenchModels.Data;
record ROMOTractionMotor "ROMO: rear traction motor's parameter set"
  extends BaseRecords.TractionMotor(
    variantName = "ROMO",
    InverterLossCoefficient=5,
    InverterLossConstant=95,
    kfric=0.155,
    kEddy=9e-5,
    kHyst=0.095,
    tauFricRef=0.2,
    L_1=0.00081,
    R_s=0.099,
    J_r=0.07,
    tauNominal=160,
    wNominal=2*Modelica.Constants.pi*fNominal/p,
    INominal=16,
    fNominal=320,
    psi_PM=sqrt(2)*V0/(2*Modelica.Constants.pi*fNominal),
    V0=273/sqrt(3)/sqrt(2),
    p=19);
  annotation (
    Documentation(
      info="<html>
<p>
Set of parameters for the <em>ROMO&apos;s in-wheel</em> traction motor.
</p>
</html>"));
end ROMOTractionMotor;
