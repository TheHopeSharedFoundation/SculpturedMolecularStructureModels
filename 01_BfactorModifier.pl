$PrePdbCmb = '2zu5_HollowAndLigandAdded.pdb';
$PstPdbCmb = '2zu5_B-FactorModified.pdb';

open(PrePdb,"$PrePdbCmb");
open(PstPdb,">$PstPdbCmb");

$PdbLneFlg = 0;

while(<PrePdb>)
   {
$ElmIdn = "";
# SET FIRST ATOM TO MAXIMUM B-FACTOR VALUE OF 9.00
if($PdbLneFlg == 0 && $_ =~ m/^ATOM\s+\d+\s+\w+\d*\s*\w+\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
   {
   $RplTxt = $1;
   $ElmIdn = $2;
   $_ =~ s/$RplTxt/ 1.00 9.00/;
   $PdbLneFlg = 1;
   }
elsif($_ =~ m/^HETATM\s+\d+\s+\w+\d*\s*\w+\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
   {
   $RplTxt = $1;
   $ElmIdn = $2;
   $_ =~ s/$RplTxt/ 1.00 9.00/;
   }
elsif($_ =~ m/^(ATOM\s+\d+\s+O\s+HOH\s+\w+\d+)\s+(\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
   {
   $FstPrtStg = $1;
   $LstPrtStg = $2;
   $FstPrtRep = "$FstPrtStg $LstPrtStg";
   $LstPrtRep =  $FstPrtStg . $LstPrtStg;
   $_ =~ s/$FstPrtRep/$LstPrtRep/;
   }
else
   {  
# HYDROPHOBIC RESIDUES ARE COLORED SILVER
  if($_ =~ m/^ATOM\s+\d+\s+\w+\d*\s*(?:ALA|GLY|ILE|LEU|PRO|VAL|MET)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 1.00/;
    }
# AROMATIC RESIDUES ARE COLORED LIGHT BLUE
  if($_ =~ m/^ATOM\s+\d+\s+\w+\d*\s*(?:PHE|TRP|TYR|HIS|HID|HIE)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 2.50/;
    }
# POLAR RESIDUES ARE COLORED GREEN
  if($_ =~ m/^ATOM\s+\d+\s+\w+\d*\s*(?:ASP|ASH|GLU|GLH|ARG|LYS|SER|THR|CYS|CYX|ASN|GLN)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 3.50/;
    }
# OXYGEN ATOMS (HBA) ARE COLORED VIOLET
  if($_ =~ m/^ATOM\s+\d+\s+O\w*\d*\s*\w+\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/ && $_ !~ m/^ATOM\s+\d+\s+O\w*\d*\s*(?:WAT|HOH)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+/ )
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 4.50/;
    }
# NITROGEN ATOMS (HBA) ARE COLORED VIOLET
  if($_ =~ m/^ATOM\s+\d+\s+N\w*\d*\s*\w+\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 4.50/;
    }
# WATER MOLECULE OXYGEN ATOMS (HBA) ARE COLORED MAGENTA
  if($_ =~ m/^ATOM\s+\d+\s+O\s*(?:WAT|HOH)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+(\D?\d+\.\d+)(\s+\D?\d+\.\d+)/)
    {
    $OccVal = $1;
    $BfcVal = $2;
  $_ =~ s/\s+$OccVal$BfcVal/ $OccVal 6.50/;
    }
# POLAR HYDROGENS CONNECTED TO BACKBONE NITROGENS (HBD) ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+H\s+\w+\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# WATER MOLECULE HYDROGEN ATOMS (HBD) ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:H1|H2)\s*(?:WAT|HOH)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+(\D?\d+\.\d+)(\s+\D?\d+\.\d+)/)
    {
    $OccVal = $1;
    $BfcVal = $2;
  $_ =~ s/\s+$OccVal$BfcVal/ $OccVal 7.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO TRP SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+HE1\s*TRP\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO TYR SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+HH\s*TYR\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO ASP SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HD1|HD2)\s*(?:ASP|ASH)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO GLU SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HE1|HE2)\s*(?:GLU|GLH)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO HIS SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HD1|HE2)\s*(?:HIS|HIE|HID)\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO SER SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+HG\s*SER\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO THR SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+HG1\s*THR\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO ASN SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HD11|HD12|HD21|HD22)\s*ASN\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO GLN SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HE11|HE12|HE21|HE22)\s*GLN\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO ARG SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HE|HE1|HH11|HH12|HH21|HH22)\s*ARG\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
  $_ =~ s/$RplTxt/ 1.00 5.50/;
    }
# POLAR HYDROGEN (HBD) CONNECTED TO LYS SIDECHAIN ARE COLORED ORANGE
  if($_ =~ m/^ATOM\s+\d+\s+(?:HZ1|HZ2|HZ3)\s*LYS\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
    {
    $RplTxt = $1;
    $ElmIdn = $2;
    $_ =~ s/$RplTxt/ 1.00 5.50/;
    if($_ =~ m/^ATOM\s+\d+\s+HZ3\s*LYS\s+\w*\s*\D?\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+/)
      {
      $LysStr = $_;
      push(@LysAry,$LysStr);     
      }
    }
  }
  $PdbOutStg = $_;
  push(@PdbOutAry,$PdbOutStg);
#  print "$PdbOutStg";
}


$LysArySze = @LysAry;
$PdbOutSze = @PdbOutAry;
# print "LYS ARY SIZE: $LysArySze\n";
# print "PDB ARY SIZE: $PdbOutSze\n";

    foreach $PdbOutLne (@PdbOutAry)
       { # 1
       $ResNumPdb = "";
       $ResNumLys = "";
       if($PdbOutLne =~ m/^ATOM\s+\d+\s+NZ\s*LYS\s+\w*\s*(\D?\d+)\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+(\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
         { # 2
         $ResNumPdb = $1;
         $RplTxt = $2;
         } # 2
         foreach $LysOutLne (@LysAry)
            { # 3
# If lysine is protonated, then the amine nitrogen should be colored green
           if($LysOutLne =~ m/^ATOM\s+\d+\s+HZ3\s*LYS\s+\w*\s*(\D?\d+)\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+/)
            { # 4
            $ResNumLys = $1;
            if($ResNumLys == $ResNumPdb)
              { # 5
              $PdbOutLne =~ s/$RplTxt/ 1.00 3.50/;
              $ResNumLys = "";
              } # 5

            } # 4

           } # 3
       print PstPdb "$PdbOutLne";
       print "$PdbOutLne";
       } # 1


close(PrePdb);
close(PstPdb);















 

        
close(PrePdb);
close(PstPdb);