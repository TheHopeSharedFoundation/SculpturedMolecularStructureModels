#********************************************START USER INPUT**************************************************
$PrjNme = "2zu5_SARS_3CL_protease";
$RBLY = "untitled.obj";
$WrkDir = "C:/Users/Ben Samudio/Desktop/PDB_2ZU5_SARS_CoV_3CL_protease/";
$ImgNme = "PDB_2ZU5_SARS_CoV_3CL_protease_";
$ImgExt = ".png";
$MolIdn = 0;
$MolIdn2 = 1;


open(ImgOut,">$PrjNme.VMDclippingCommands.txt");
    print ImgOut "display depthcue off\n";
    print ImgOut "display nearclip set 0\n";
    print ImgOut "display farclip set 100\n";
    print ImgOut "display projection orthographic\n";
    print ImgOut "mol clipplane status 0 0 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 0 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 0 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane status 1 0 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane normal 0 0 " . $MolIdn . " \"0 1 0\"\n";
    print ImgOut "mol clipplane normal 1 0 " . $MolIdn . " \"0 -1 0\"\n";
    print ImgOut "mol clipplane center 0 0 " . $MolIdn . " \"0.0 50.0 0.0\"\n";
    print ImgOut "mol clipplane center 1 0 " . $MolIdn . " \"0.0 -50.0 0.0\"\n";


    print ImgOut "mol clipplane status 0 1 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 1 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 1 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane status 1 1 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane normal 0 1 " . $MolIdn . " \"0 1 0\"\n";
    print ImgOut "mol clipplane normal 1 1 " . $MolIdn . " \"0 -1 0\"\n";
    print ImgOut "mol clipplane center 0 1 " . $MolIdn . " \"0.0 50.0 0.0\"\n";
    print ImgOut "mol clipplane center 1 1 " . $MolIdn . " \"0.0 -50.0 0.0\"\n";


    print ImgOut "mol clipplane status 0 2 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 2 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 2 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane status 1 2 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane normal 0 2 " . $MolIdn . " \"0 1 0\"\n";
    print ImgOut "mol clipplane normal 1 2 " . $MolIdn . " \"0 -1 0\"\n";
    print ImgOut "mol clipplane center 0 2 " . $MolIdn . " \"0.0 50.0 0.0\"\n";
    print ImgOut "mol clipplane center 1 2 " . $MolIdn . " \"0.0 -50.0 0.0\"\n";

    print ImgOut "mol clipplane status 0 3 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 3 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 3 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane status 1 3 " . $MolIdn . " 1\n";
    print ImgOut "mol clipplane normal 0 3 " . $MolIdn . " \"0 1 0\"\n";
    print ImgOut "mol clipplane normal 1 3 " . $MolIdn . " \"0 -1 0\"\n";
    print ImgOut "mol clipplane center 0 3 " . $MolIdn . " \"0.0 50.0 0.0\"\n";
    print ImgOut "mol clipplane center 1 3 " . $MolIdn . " \"0.0 -50.0 0.0\"\n";


#GRID BOX SIDE DISTANCE (units of Angstroms)

$GrdSdeSze = 40;

#GRID INCREMENTS (units of Angstroms)

$GrdIncSze = 1;


#HALF OF GRID BOX SIDE DISTANCE (units of Angstroms)

$GrdHlfSze = $GrdSdeSze / 2;


#MARKER SHELLS

$NumMkrShl = 7;

#DISTANCE BETWEEN SCALING MARKERS IN VMD (units of Angstrom)

$VmdDst = 10;
print "VMD distance: $VmdDst\n";

#DISTANCE BETWEEN SCALING MARKERS IN BLENDER (Blender units)


$BldDst = 0.605855;
print "BLENDER distance: $BldDst\n";

#NORMAL VECTOR OF SEGMENTATION PLANES (Blender units)

$Xsrt = 0.0;
$Ysrt = -2.0;
$Zsrt = 0.0;
$Xend = 0.0;
$Yend = 2.0;
$Zend = 0.0;

#NORMAL VECTOR LENGTH (Blender units)

$NrmVctLng = 4;

#RESOLUTION FACTOR (The higher the value, the greater the resolution.  Resolution factor of 2 equals 0.5 Angstrom or 0.5 inch separation between the middle of segments)

$ResFctSet = 2;
$SegOffSet = 1 / ($ResFctSet * 2);

$SclFct = $VmdDst / $BldDst;
$CnvFct = $BldDst / $VmdDst;
$MkrShlInc = $SclFct / $NumMkrShl;


print "Scale factor: $SclFct\n";
print "Conversion factor (Blender units per VMD units [Angstroms]): $CnvFct\n";
$AngInc = $ResFctSet * $NrmVctLng / $CnvFct;

$NumSeg = sprintf("%.0f", $AngInc);

print "Number of segments: $NumSeg\n";

#*******************************************END USER INPUT****************************************************


$XsrtOut = $Xsrt * $SclFct;
$YsrtOut = $Ysrt * $SclFct;
$ZsrtOut = $Zsrt * $SclFct;

$XnrmOut = ($Xend - $Xsrt) * $SclFct;
$YnrmOut = ($Yend - $Ysrt) * $SclFct;
$ZnrmOut = ($Zend - $Zsrt) * $SclFct;

open(NrmOut,">$PrjNme.LogFile.txt");

print NrmOut "Distance between scaling markers in VMD (Angstroms): $VmdDst\n";
print NrmOut "Distance between scaling markers in Blender (Blender units): $BldDst\n";
print NrmOut "Number of marker shells: $NumMkrShl\n";
print NrmOut "Normal vector starting coordinates, non-scaled (X Y Z): $Xsrt $Ysrt $Zsrt\n";
print NrmOut "Normal vector ending coordinates, non-scaled (X Y Z): $Xend $Yend $Zend\n";
print NrmOut "Normal vector starting coordinates, scaled (X Y Z): $XsrtOut $YsrtOut $ZsrtOut\n";
print NrmOut "Normal vector ending coordinates (X Y Z): $XnrmOut $YnrmOut $ZnrmOut\n";
print NrmOut "Normal vector length (Blender units): $NrmVctLng\n";
print NrmOut "Resolution factor (The higher the value, the greater the resolution.  Resolution factor of 1 equals 1 Angstrom or 1 inch separation between segments): $ResFctSet\n"; 
print NrmOut "Scaling factor: $SclFct\n";
print NrmOut "Conversion factor (Blender units per VMD units [Angstroms]): $CnvFct\n";
print NrmOut "Total number of segments:$NumSeg\n";




$Xnrm = $Xend - $Xsrt;
$Ynrm = $Yend - $Ysrt;
$Znrm = $Zend - $Zsrt;



$A = $Xnrm;
$B = $Ynrm;
$C = $Znrm;
@SegAry;
$MtlIdn = "";
$ElmIdn = "";
@ClrAry;
@RgbAry;
@VctAry;
$VctAryCnt = 0;

#*************************************************INITIALIZE THE NUMBER OF SEGMENTS********************************************

for($i = 0; $i < $NumSeg; $i++)
    {
$SegAry[$i] = ($A * ($Xsrt + ($Xend-$Xsrt)*$i/$NumSeg) +  $B * ($Ysrt + ($Yend-$Ysrt)*$i/$NumSeg) + $C * ($Zsrt + ($Zend-$Zsrt)*$i/$NumSeg) );
print "$i $SegAry[$i]\n";
    }

#**********************************EXTRACT MATERIAL COLORS AND VECTORS FROM OBJECT MLT FILE*************************************

open(ClrInp,"$RBLY");
while(<ClrInp>)
{ #OPEN_01
   if($_ =~ m/usemtl\s+vmd_mat_cindex_(\d+)/)
      { #OPEN_02
      $MtlIdn = $1;
      if($MtlIdn == 0)
        { #OPEN_03
        $ElmIdn = "N";
        $RgbIdn = "BLUE";
        } #CLOSE_03
      if($MtlIdn == 1)
        { #OPEN_04
        $ElmIdn = "O";
        $RgbIdn = "RED";
        } #CLOSE_04
      if($MtlIdn == 4)
         { #OPEN_05
         $ElmIdn = "S";
         $RgbIdn = "YELLOW";
         } #CLOSE_05
     if($MtlIdn == 8)
        { #OPEN_06
        $ElmIdn = "H";
        $RgbIdn = "WHITE";
        } #CLOSE_06
     if($MtlIdn == 10)
        { #OPEN_07
        $ElmIdn = "He";
        $RgbIdn = "CYAN";
        } #CLOSE_07
     if($MtlIdn == 16)
        { #OPEN_07
        $ElmIdn = "C";
        $RgbIdn = "BLACK";
        } #CLOSE_07
     if($MtlIdn == 7)
        { #OPEN_03
        $ElmIdn = "Cl";
        $RgbIdn = "GREEN";
        } #CLOSE_03
      if($MtlIdn == 11)
        { #OPEN_04
        $ElmIdn = "Na";
        $RgbIdn = "PURPLE";
        } #CLOSE_04
      if($MtlIdn == 5)
         { #OPEN_05
         $ElmIdn = "P";
         $RgbIdn = "TAN";
         } #CLOSE_05
      if($MtlIdn == 3)
         { #OPEN_05
         $ElmIdn = "P";
         $RgbIdn = "ORANGE";
         } #CLOSE_05
     if($MtlIdn == 25)
        { #OPEN_06
        $ElmIdn = "K";
        $RgbIdn = "VIOLET";
        } #CLOSE_06
     if($MtlIdn == 6)
        { #OPEN_07
        $ElmIdn = "Ti";
        $RgbIdn = "GRAY";
        } #CLOSE_07
     if($MtlIdn == 28)
        { #OPEN_08
        $ElmIdn = "Md";
        $RgbIdn = "MAGENTA";
        } #CLOSE_08


#print "1. CINDEX: $MtlIdn  ELEMENT: $ElmIdn\n";
      } #CLOSE_02



    if($_ =~ m/f\s+(\d+)\/\/\d+\s+(\d+)\/\/\d+\s+(\d+)\/\/\d+/)
     { #OPEN_08 
     $VrtThr = $1;
     $VrtTwo = $2;
     $VrtOne = $3;
     $ClrAry[$VrtOne - 1] = $ElmIdn;
     $ClrAry[$VrtTwo - 1] = $ElmIdn;
     $ClrAry[$VrtThr - 1] = $ElmIdn;
     $RgbAry[$VrtOne - 1] = $RgbIdn;
     $RgbAry[$VrtTwo - 1] = $RgbIdn;
     $RgbAry[$VrtThr - 1] = $RgbIdn;

#print "2. $VrtOne  $VrtTwo  $VrtThr  $ElmIdn\n";
     } #CLOSE_08

   if($_ =~ m/(v\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+)/)
     {
     $VctAry[$VctAryCnt] = $1;
     $VctAryCnt++;
   
#print "3. $VctAryCnt $_";
     }

} #CLOSE_01
close(ClrInp);

#*************************************************START SEGMENTATION********************************************************


$VctArySze = @VctAry;
$VctAryMax = $VctArySze - 1;
$ClrArySze = @ClrAry;
print "COLOR ARRAY SIZE: $ClrArySze\n";

print "VECT ARY SZE: $VctArySze VECT ARY MAX: $VctAryMax\n";

$AllCnt = 0;
$SegIdn = 0;
$XYZ = 0;
$CSV = 0;
$XYZallArySze = 0;
@XYZallAry = "";
@CSVallAry = "";
$CSVallOut = "";
$XYZallOut = "";
$D = "";
@SegSlcAry = "";

foreach $D (@SegAry)
{ #OPEN_09
$a = "";
$b = "";
$c = "";
$x1 = "";
$x2 = "";
$y1 = "";
$y2 = "";
$z1 = "";
$z2 = "";
$X = "";
$Y = "";
$Z = "";
@XYZoutAry = ();
@CSVoutAry = ();
$CSVout = "";
$XYZout = "";
$XYZonly = "";
$VrtCnt = 0;
$LneCnt = 0;
$PasCnt = 0;
$SegIdn++;
@XYZsegAry = ();
@CSVsegAry = ();
$XYZsegArySze = 0;
$CrtCrd = "";
$CmaSep = "";
$XYZsegOut = "";
@BLACK = ();
@RED = ();
@BLUE = ();
@YELLOW = ();
@WHITE = ();
@GREEN = ();
@PURPLE = ();
@ORANGE = ();
@VIOLET = ();
$BlkSze = 0;
$RedSze = 0;
$BluSze = 0;
$YelSze = 0;
$XYZsegFleNme = "";

for($n=0;$n<$VctAryMax;$n++)
    { #OPEN_10
    if($VctAry[$n] =~ m/^v\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
      { #OPEN_11
      chomp($x1 = $1);
      chomp($y1 = $2);
      chomp($z1 = $3);
     $VrtCnt++;
#print "5. $VrtCnt FIRST POINT: $x1, $y1, $z1\n";
      } #CLOSE_11
    if($VctAry[$n + 1] =~ m/^v\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
      { #OPEN_12
      chomp($x2 = $1);
      chomp($y2 = $2);
      chomp($z2 = $3);
     
#print "6. $VrtCnt SECOND POINT: $x2, $y2, $z2\n";
      } #CLOSE_12

$a = $x2 - $x1;
$b = $y2 - $y1;
$c = $z2 - $z1;

   if(($A*$a+$B*$b+$C*$c) != 0)
     { #OPEN_13
     $t = -1 * ($A*$x1 + $B*$y1 + $C*$z1 + $D) / ($A*$a+$B*$b+$C*$c);
     } #CLOSE_13
   else
    { #OPEN_14
    next;
    } #CLOSE_14

#print "7. PARAMETER: $t\n";

  if(($t < 1 && $t > 0) || $t == 0 || $t == 1) 
     { #OPEN_15
     $LneCnt++;
     $AllCnt++;
     $PasCnt++;
#print "8. ******************MATCH***************************\n";

$X = $x1 - ($a*($A*$x1 + $B*$y1 + $C*$z1 + $D)/($A*$a + $B*$b+$C*$c));
$Y = $y1 - ($b*($A*$x1 + $B*$y1 + $C*$z1 + $D)/($A*$a + $B*$b+$C*$c));
$Z = $z1 - ($c*($A*$x1 + $B*$y1 + $C*$z1 + $D)/($A*$a + $B*$b+$C*$c));

$Xtrn = sprintf("%.8f",$X) * $SclFct;
$Ytrn = sprintf("%.8f",$Y) * $SclFct;
$Ztrn = sprintf("%.8f",$Z) * $SclFct;

if($Xtrn eq "0" || $Xtrn =~ m/e-/)
  {
  $Xtrn = "0.00000";
  }

if($Ytrn eq "0" || $Ytrn =~ m/e-/)
  {
  $Ytrn = "0.00000";
  }

if($Ztrn eq "0" || $Ztrn =~ m/e-/)
  {
  $Ztrn = "0.00000";
  }

#print "$SegIdn $PasCnt $VrtCnt $ClrAry[$VrtCnt] $x1 $y1 $z1 $x2 $y2 $z2 $Xtrn $Ytrn $Ztrn $t\n";
#print "9. $VrtCnt $ClrAry[$VrtCnt] $Xtrn $Ytrn $Ztrn\n"; 

if($ClrAry[$VrtCnt] =~ m/\w+/)
  {
$XYZallOut = "$ClrAry[$VrtCnt] $Xtrn $Ytrn $Ztrn\n";
$XYZsegOut = "$ClrAry[$VrtCnt] $Xtrn $Ytrn $Ztrn\n";
  }


push(@XYZsegAry,$XYZsegOut);
push(@XYZallAry,$XYZallOut);


     } #CLOSE_15
    else
     { #OPEN_16
     next;
     } #CLOSE_16


    } #CLOSE_10

if($Ytrn =~ m/\D?\d+\.\d+/ || $Ytrn eq "0" )
  {

# $CntMkr = "C 0.0 $Ytrn 0.0\n";
# push(@XYZsegAry,$CntMkr);
# push(@XYZallAry,$CntMkr);
print NrmOut "Segment $SegIdn center marker coordinates (X Y Z): 0.0 $Ytrn 0.0\n";

$Yost = $Ytrn + $SegOffSet;
push(@SegSlcAry,$Yost);


$ZgrdCrd = $GrdSdeSze;
$XgrdCrd = $GrdSdeSze;

for($ZgrdCnt = 0; $ZgrdCnt < $GrdSdeSze; $ZgrdCnt++)
    {
    $ZgrdCrd = sprintf("%.8f",$GrdHlfSze - $ZgrdCnt);
    for($XgrdCnt = 0; $XgrdCnt < $GrdSdeSze; $XgrdCnt++)
        {  
         $XgrdCrd = sprintf("%.8f",$GrdHlfSze - $XgrdCnt);
 
         if($XgrdCrd == 0 && $ZgrdCrd == 0)
            {
            $GrdMkrCrd = "Ga $XgrdCrd $Ytrn $ZgrdCrd\n";
            }
         elsif($XgrdCrd == $GrdHlfSze)
            {
            $GrdMkrCrd = "Ge $XgrdCrd $Ytrn $ZgrdCrd\n";
            }
         elsif($ZgrdCrd == -$GrdHlfSze + 1)
            {
            $GrdMkrCrd = "As $XgrdCrd $Ytrn $ZgrdCrd\n";
            }         
         elsif($ZgrdCrd == $GrdHlfSze)
            {
            $GrdMkrCrd = "Se $XgrdCrd $Ytrn $ZgrdCrd\n";
            }
         elsif($XgrdCrd == -$GrdHlfSze + 1)
            {
            $GrdMkrCrd = "Br $XgrdCrd $Ytrn $ZgrdCrd\n";
            }
         else
            {
         $GrdMkrCrd = "Kr $XgrdCrd $Ytrn $ZgrdCrd\n";
             }

         push(@XYZsegAry,$GrdMkrCrd);
         push(@XYZallAry,$GrdMkrCrd);
print "GRID COORDINATES: $XgrdCrd $Ytrn $ZgrdCrd\n";
        }   
  
   }





}   

$XYZsegArySze = @XYZsegAry;


$XYZsegFleNme = $PrjNme . "_" . $SegIdn . ".xyz";
open(XYZsegPnt,">$XYZsegFleNme");
print XYZsegPnt "$XYZsegArySze\n";
print XYZsegPnt "\n";
foreach $CrtCrd (@XYZsegAry)
{
print XYZsegPnt "$CrtCrd";
}
close(XYZsegPnt);




} #CLOSE_09

$XYZallArySze = @XYZallAry - 1;

$XYZallFleNme = $PrjNme . "_" . "All.xyz";
open(XYZallPnt,">$XYZallFleNme");
print XYZallPnt "$XYZallArySze\n";
print XYZallPnt "\n";
foreach $XYZ (@XYZallAry)
{
print XYZallPnt "$XYZ";
}

$SegSlcSze = @SegSlcAry;


for($SlcCnt = 1; $SlcCnt < $SegSlcSze - 1; $SlcCnt++)
     {
     print ImgOut "mol clipplane center 0 0 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt + 1]  . " 0.0\"\n";
     print ImgOut "mol clipplane center 1 0 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt]  . " 0.0\"\n";

     print ImgOut "mol clipplane center 0 1 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt + 1]  . " 0.0\"\n";
     print ImgOut "mol clipplane center 1 1 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt]  . " 0.0\"\n";


     print ImgOut "mol clipplane center 0 2 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt + 1]  . " 0.0\"\n";
     print ImgOut "mol clipplane center 1 2 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt]  . " 0.0\"\n";

     print ImgOut "mol clipplane center 0 3 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt + 1]  . " 0.0\"\n";
     print ImgOut "mol clipplane center 1 3 " . $MolIdn . " \"0.0 " . $SegSlcAry[$SlcCnt]  . " 0.0\"\n";



     print ImgOut "render snapshot \"" . $WrkDir . $ImgNme . $SlcCnt . $ImgExt . "\"\n";
     }

    print ImgOut "mol clipplane status 0 0 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 0 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 1 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 1 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 2 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 2 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 0 3 " . $MolIdn . " 0\n";
    print ImgOut "mol clipplane status 1 3 " . $MolIdn . " 0\n";

close(ImgOut);
close(XYZallPnt);
close(NrmOut);