use List::MoreUtils qw(uniq);

 $MaxNumLne = 132;
 $BseFleNme = "2zu5_SARS_3CL_protease";

 for($FltLneCnt = 0; $FltLneCnt < $MaxNumLne; $FltLneCnt++)
    { # MASTER LOOP OPEN

 $FleIdxNum = $FltLneCnt + 1;
 $InpFleNme = $BseFleNme . "_" . $FleIdxNum;  
 print "TEST WORKING ON: $InpFleNme\n";

# ************************************************** Initiate

@ActAry = ();
@CntAry = ();
@CntTrm = ();
@CntTrmAry = ();
%DstUnsNeg = ();
%DstUnsPos = ();
@CntTrmRed = ();
@CntNegAry = ();
@CntPosAry = ();
# @OutAry = ();

# ************************************************** Populate arrays

open(CntInp,"$InpFleNme.xyz");
open(TstOut,">TestContourOutput.xyz");
while(<CntInp>)
     {
     if($_ =~ m/(?:O|S)\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+/)
        {
        chomp($ActMmb = $_);
        push(@ActAry,$ActMmb);
        }
     if($_ !~ m/(?:O|S|Ga|Kr|Br|As|Ge|Se)\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+/)
        {
        if($_ =~ m/\w+\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
          {
          $WhlCntX = $1;
          $WhlCntY = $2;
          $WhlCntZ = $3;
          $NewWhlStg = "";
          $NewWhlStg = "B $WhlCntX $WhlCntY $WhlCntZ";
          chomp($CntMmb = $_);
          push(@CntAry,$CntMmb);
          push(@WhlCnt,$NewWhlStg);
           }
        }
     if($_ =~ m/(?:O|S|Ga|Kr|Br|As|Ge|Se)\s+\D?\d+\.\d+\s+\D?\d+\.\d+\s+\D?\d+\.\d+/)
        {
        chomp($OutMmb = $_);
        push(@OutAry,$OutMmb);
        }
     }
close(CntInp);


$ActArySze = @ActAry;
$CntArySze = @CntAry;
$OutMmbSze = @OutAry;

print "ActAry Size: $ActArySze\n";
print "CntAry Size: $CntArySze\n";
print "MmbAry Size: $OutMmbSze\n";

# print "$OutAry[0]\n";
# print "$OutAry[1]\n";
# print "$OutAry[2]\n";
# print "$OutAry[3]\n";
# print "$OutAry[4]\n";


# ************************************************* Trim contours



      for($ActCnt = 0; $ActCnt < $ActArySze; $ActCnt++)
          { # OPEN 3
          #  print "Contour count: $CntCnt Active count: $ActCnt\n";
          $AryX = "";
          $AryY = "";
          $AryZ = "";
          $DstActCnt = "";
          if($ActAry[$ActCnt] =~ m/\w+\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)  
            { # OPEN 4
            chomp($AryX = $1);
            chomp($AryY = $2);
            chomp($AryZ = $3);
            $MaxShlRad = 3;
            $ShlWdtSze = 0.1;
            $MaxShlNum = $MaxShlRad / $ShlWdtSze;
            $DstMchFlg = 0;
            for($ShlExpCnt = 0; $ShlExpCnt < $MaxShlNum; $ShlExpCnt++)
                {
                $MinShlRad = ($ShlExpCnt * $ShlWdtSze);
                $MaxShlRad = ($ShlExpCnt * $ShlWdtSze) + $ShlWdtSze;
                for($CntCnt = 0; $CntCnt < $CntArySze; $CntCnt++)
                   { # OPEN 1
                   $CntX = "";
                   $CntY = "";
                   $CntZ = "";
                   # print "Contour count: $CntCnt\n";
                   if($CntAry[$CntCnt] =~ m/\w+\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)     
                     { # OPEN 2
                     chomp($CntX = $1);
                     chomp($CntY = $2);
                     chomp($CntZ = $3); 
                     $DstActCnt = sqrt(($CntX - $AryX)**2 + ($CntY - $AryY)**2 + ($CntZ - $AryZ)**2);
                     if($DstActCnt < $MaxShlRad && $DstActCnt >= $MinShlRad)
                        {
                        $DstMchFlg = 1; 
                        push(@CntTrmRed,$CntAry[$CntCnt]);
                        print TstOut "$CntAry[$CntCnt]\n";
                        }
                      }
                     }
                   if($DstMchFlg == 1)
                     {
                     last;
                     }
                   }
                 }
               }


#foreach $ActAryVal (@ActAry)
#      {
#      print TstOut "$ActAryVal";
#      }

@CntTrm = uniq @CntTrmRed;
$CntTrmSze = @CntTrm;
print "Contour Trim Size: $CntTrmSze\n";
close(TstOut);

# ************************************************** Define reference point


$OldPosX = 1000000;
$OldNegX = -1000000;

for($CntCnt = 0; $CntCnt < $CntTrmSze; $CntCnt++)
    {
    $NewX = "";
    $NewY = "";
    $NewZ = ""; 
    $NewElm = "";
    if($CntTrm[$CntCnt] =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)     
      { # OPEN 2
      chomp($NewElm = $1);
      chomp($NewX = $2);
      chomp($NewY = $3);
      chomp($NewZ = $4);
      # print "$NewX\n";
      if($NewX > 0)
        {
        if($NewX < $OldPosX)
          {
          $OldPosX = $NewX;
          $OldPosY = $NewY;
          $OldPosZ = $NewZ;
          $OldPosElm = $NewElm;
          $PosOutStg = "$OldPosX $OldPosY $OldPosZ $OldPosElm ";
          push(@CntPosAry,$PosOutStg);
          }
        }
      if($NewX < 0)   
        {
        if($NewX > $OldNegX)
           {
           $OldNegX = $NewX;
           $OldNegY = $NewY;
           $OldNegZ = $NewZ;
           $OldNegElm = $NewElm;
          $NegOutStg = "$OldNegX $OldNegY $OldNegZ $OldNegElm ";
          push(@CntNegAry,$NegOutStg);
           }
        }
      }
     }


@SrtNegAry = sort @CntNegAry;
@SrtPosAry = sort @CntPosAry;


$AvgZ = ($OldPosZ + $OldNegZ)/2;
$RefX = 0.0;
$RefY = $OldNegY;
$RefZ = $AvgZ;

# *******************************************New code begin - 29SEP2019

$NewRefZ = $RefZ;

if($FltLneCnt == 0)
  {
  $OldRefZ = $NewRefZ;
  }


$DifRefZ = 0.5 + abs($OldRefZ - $NewRefZ);
$SumRefZ = $SumRefZ + $DifRefZ;

print "TEST NEW REFERENCE POINTS: $FltLneCnt $RefX $RefY $NewRefZ $OldRefZ $DifRefZ $SumRefZ\n";



$OldRefZ = $NewRefZ;
 
# ********************************************New code end - 29SEP2019




@CrdLst = "C $RefX $RefY $RefZ;C 0.0 $OldNegY 0.0";
$FstPosDst = sqrt(($OldPosX - 0.0)**2 + ($OldPosZ - $AvgZ)**2);
$FstNegDst = -1 * sqrt(($OldNegX - 0.0)**2 + ($OldNegZ - $AvgZ)**2);

#open(TrmOut,">ContourPlotsOutput.xyz");
#    print TrmOut "C 0.0 $OldNegY 0.0\n";
#    print TrmOut "$OldNegElm $FstNegDst $OldNegY 0.0\n";
#    print TrmOut "$OldPosElm $FstPosDst $OldPosY 0.0\n";

#******************************************************************Create nearest neighbor list

$NghRefElm = $OldPosElm;
$NghRefX = $OldPosX;
$NghRefY = $OldPosY;
$NghRefZ = $OldPosZ;

@NerNgh = @CntTrm;
$NerNghSze = @NerNgh;
$OldNghDst = 1000000;

print "NerNghSze: $NerNghSze\n";
print "CntTrmSze: $CntTrmSze\n";

open(TstOut,">TestOut.txt");

for($b = 0; $b < $CntTrmSze; $b++)
    { #OPEN1
     $OldNghDst = 1000000;
     $NewNghDst = "";
     $NghOutStg = "";
     $RefNghElm = "";
     $RefNghX = "";
     $RefNghY = "";
     $RefNghZ = "";
     $NghOutStg = "";
    if($CntTrm[$b] =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/) 
      { #OPEN2
      chomp($RefNghElm = $1);
      chomp($RefNghX = $2);
      chomp($RefNghY = $3);
      chomp($RefNghZ = $4);
      } #CLOSE2  
      for($a = 0; $a < $NerNghSze; $a++)
         { #OPEN3
         $PrpNghElm = "";
         $PrpNghX = "";
         $PrpNghY = "";
         $PrpNghZ = "";
         $NewNghDst = "";
         if($NerNgh[$a] =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/ && $NerNgh[$a] !~ m/NULL/) 
           { #OPEN4
           chomp($PrpNghElm = $1);
           chomp($PrpNghX = $2);
           chomp($PrpNghY = $3);
           chomp($PrpNghZ = $4); 
    #       print "$b $a $PrpNghElm\n";
           
          $NewNghDst = sqrt(($RefNghX - $PrpNghX)**2 + ($RefNghY - $PrpNghY)**2 + ($RefNghZ - $PrpNghZ)**2);
#            print "OUTSIDE: $b $a  $RefNghElm $RefNghX $RefNghY $RefNghZ $PrpNghElm $PrpNghX $PrpNghY $PrpNghZ $NewNghDst\n";
           if($NewNghDst < $OldNghDst && $NewNghDst > 0 && $NewNghDst !~ m/e-/)
             {
    #        $NghOutStg = "$PrpNghElm $NewNghDst $PrpNghY 0.0\n";
              $NghOutStg = "$RefNghElm $RefNghX $RefNghY $RefNghZ;$PrpNghElm $PrpNghX $PrpNghY $PrpNghZ;$NewNghDst";
          #     $NghOutStg = "$RefNghElm $RefNghX $RefNghY $RefNghZ";
#              print "INSIDE: $b $a  $RefNghElm $RefNghX $RefNghY $RefNghZ $PrpNghElm $PrpNghX $PrpNghY $PrpNghZ $NewNghDst\n";
              $OldNghDst = $NewNghDst;
             $ErsIdx = $b;
             }
           } #CLOSE4
        } #CLOSE3
        $EndPntCnt++;
#     print  "$EndPntCnt $NghOutStg\n";
#      print "PRINT: $EndPntCnt $b $a $NghOutStg\n";
      push(@FnlNgh,$NghOutStg);
   #  delete $NerNgh[$ErsIdx];
  #   splice(@NerNgh,$ErsIdx,1);
  #    print "ERASE: $ErsIdx\n";
      $NerNgh[$ErsIdx] = "NULL";
 #    print "$NerNgh[0];$NerNgh[1];$NerNgh[2];$NerNgh[3];$NerNgh[4];$NerNgh[5];$NerNgh[6]\n";
     $NerNghSze = @NerNgh;
 #    print "NerNghSze = $NerNghSze\n";
    } #CLOSE1

close(TstOut);


# **************************************************************************************************Initiate left-ward and right-ward arrays

$NumPntStr = 1;

open(PntOut,">FlattenedContour.xyz");
    print PntOut "C $RefX $RefY 0.0\n";
#  print "C $RefX $RefY $RefZ\n";
close(PntOut);


open(UnfOut,">UnFlattenedContour.xyz");
    print UnfOut "C $RefX $RefY $RefZ\n";
close(UnfOut);


# **********************************************************************************************************Pathfinder





# ************************************Pathfinder positive

$PthDstSum = 0; 

foreach $CntTrmVal (@CntTrm)
      {
      if($CntTrmVal =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
        {
        $AtmCrdElm = $1;
        $AtmCrdX = $2;
        $AtmCrdY = $3;
        $AtmCrdZ = $4;
        $AtmCrdStg = "$AtmCrdElm $AtmCrdX $AtmCrdY $AtmCrdZ";
        if($AtmCrdX > 0)
           {
        $DstUnsPos{$AtmCrdStg} = 1000000;
           }
    #   print "$DstUnsPos{$AtmCrdStg} $AtmCrdStg\n";
        $AtmCrdElm = "";
        $AtmCrdX = "";
        $AtmCrdY = "";
        $AtmCrdZ = "";
        $AtmCrdStg = "";
        }
      }

for($PthCntOut = -1; $PthCntOut < $CntTrmSze; $PthCntOut++)
   {
   if($PthCntOut == -1)
      {
      $PthStrElm = "C";
      $PthStrX = $RefX;
      $PthStrY = $RefY;
      $PthStrZ = $RefZ;
      }
#     print "OUTER LOOP: $PthStrElm $PthStrX $PthStrY $PthStrZ\n";

      foreach $PthFndStg (keys %DstUnsPos)
         {
         if($PthFndStg =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
           {
           $PthEndElm = $1;
           $PthEndX = $2;
           $PthEndY = $3;
           $PthEndZ = $4;
           $PthFndDst = sqrt(($PthEndX - $PthStrX)**2 + ($PthEndY - $PthStrY)**2 + ($PthEndZ - $PthStrZ)**2); 
    #      print "INNER LOOP: $PthStrElm $PthStrX $PthStrY $PthStrZ $PthEndElm $PthEndX $PthEndY $PthEndZ $PthFndDst\n";
           if($PthFndDst == 0 || $PthFndDst =~ m/e-/ || $PthCntOut > -1 && $DstUnsPos{$PthFndStg} == 1000000)
             {
             $DstUnsPos{$PthFndStg} = 1000000;
             }
             else 
             {
             $DstUnsPos{$PthFndStg} = $PthFndDst;
    #         print "$PthCntOut $DstUnsPos{$PthFndStg} $PthFndStg\n";
             }
           }
         }
       $DstHshCnt = 0;
       $MinDstStg = "";
       foreach $name (sort { $DstUnsPos{$a} <=> $DstUnsPos{$b} } keys %DstUnsPos)
          {
          $DstHshCnt++;
  #         print PntOut "PROPOSED: $DstUnsPos{$name} $name\n"; 
           if($DstHshCnt == 1)
             {
  #          print PntOut "ACCEPTED: $DstUnsPos{$name} $name\n";
            $MinDstStg = "$DstUnsPos{$name} $name\n";
             $DstUnsPos{$name} = 1000000;
             }
          }
#     print "$MinDstStg";
     if($MinDstStg =~ m/(\D?\d+\.\d+)\s+(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
       {
       $PthDstAdd = $1;
       $PthStrElm = $2;
       $PthStrX = $3;
       $PthStrY = $4;
       $PthStrZ = $5;
       $PthDstSum = $PthDstSum + $PthDstAdd;
#       print "$PthStrElm $PthDstSum $PthStrY 0.0\n";
#       print PntOut "$PthStrElm $PthDstSum $PthStrY 0.0\n";
         $UnfAryStg = "$PthStrElm $PthStrX $PthStrY $PthStrZ\n";
         push(@UnfAry,$UnfAryStg);

# ************************* The line of code below was changed so that $SumRefZ was substituted for $PthStrY -- 29SEP2019


         $FltAryStg = "$PthStrElm $PthDstSum $SumRefZ 0.0\n";
         push(@FltAry,$FltAryStg);
#        print "$PthStrElm $PthStrX $PthStrY $PthStrZ\n";
#        print PntOut "$PthStrElm $PthStrX $PthStrY $PthStrZ\n";
       }
    #  print "$PthStrElm $PthDstSum $PthStrY 0.0\n";
      }


# *********************************Pathfinder negative

$PthDstSum = 0;
$PthFndStg = "";

foreach $CntTrmVal (@CntTrm)
      {
      if($CntTrmVal =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
        {
        $AtmCrdElm = $1;
        $AtmCrdX = $2;
        $AtmCrdY = $3;
        $AtmCrdZ = $4;
        $AtmCrdStg = "$AtmCrdElm $AtmCrdX $AtmCrdY $AtmCrdZ";
        if($AtmCrdX < 0)
           {
        $DstUnsNeg{$AtmCrdStg} = 1000000;
    #    print "$DstUnsNeg{$AtmCrdStg} $AtmCrdStg\n"
           }
    #   print "$DstUnsNeg{$AtmCrdStg} $AtmCrdStg\n";
        $AtmCrdElm = "";
        $AtmCrdX = "";
        $AtmCrdY = "";
        $AtmCrdZ = "";
        $AtmCrdStg = "";
        }
      }

for($PthCntOut = -1; $PthCntOut < $CntTrmSze; $PthCntOut++)
   {
   if($PthCntOut == -1)
      {
      $PthStrElm = "C";
      $PthStrX = $RefX;
      $PthStrY = $RefY;
      $PthStrZ = $RefZ;
      }
 #    print "OUTER LOOP: $PthStrElm $PthStrX $PthStrY $PthStrZ\n";

      foreach $PthFndStg (keys %DstUnsNeg)
         {
         if($PthFndStg =~ m/(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
           {
           $PthEndElm = $1;
           $PthEndX = $2;
           $PthEndY = $3;
           $PthEndZ = $4;
           $PthFndDst = sqrt(($PthEndX - $PthStrX)**2 + ($PthEndY - $PthStrY)**2 + ($PthEndZ - $PthStrZ)**2); 
    #      print "INNER LOOP: $PthStrElm $PthStrX $PthStrY $PthStrZ $PthEndElm $PthEndX $PthEndY $PthEndZ $PthFndDst\n";
           if($PthFndDst == 0 || $PthFndDst =~ m/e-/ || $PthCntOut > -1 && $DstUnsNeg{$PthFndStg} == 1000000)
             {
             $DstUnsNeg{$PthFndStg} = 1000000;
             }
             else 
             {
             $DstUnsNeg{$PthFndStg} = $PthFndDst;
    #         print "$PthCntOut $DstUnsNeg{$PthFndStg} $PthFndStg\n";
             }
           }
         }
       $DstHshCnt = 0;
       $MinDstStg = "";
       foreach $name (sort { $DstUnsNeg{$a} <=> $DstUnsNeg{$b} } keys %DstUnsNeg)
          {
          $DstHshCnt++;
  #         print "PROPOSED: $DstUnsNeg{$name} $name\n"; 
           if($DstHshCnt == 1)
             {
  #          print "ACCEPTED: $DstUnsNeg{$name} $name\n";
            $MinDstStg = "$DstUnsNeg{$name} $name\n";
             $DstUnsNeg{$name} = -1000000;
             }
          }
#     print "$MinDstStg";
     if($MinDstStg =~ m/(\D?\d+\.\d+)\s+(\w+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)\s+(\D?\d+\.\d+)/)
       {
       $PthDstAdd = $1;
       $PthStrElm = $2;
       $PthStrX = $3;
       $PthStrY = $4;
       $PthStrZ = $5;
       $PthDstSum = $PthDstSum + (-1 * $PthDstAdd);
       $UnfAryStg = "$PthStrElm $PthStrX $PthStrY $PthStrZ\n";
       push(@UnfAry,$UnfAryStg);

# ************************* The line of code below was changed so that $SumRefZ was substituted for $PthStrY -- 29SEP2019


       $FltAryStg = "$PthStrElm $PthDstSum $SumRefZ 0.0\n";
       push(@FltAry,$FltAryStg);

#       print "$PthStrElm $PthDstSum $PthStrY 0.0\n";
#       print PntOut "$PthStrElm $PthDstSum $PthStrY 0.0\n";
#        print "$PthStrElm $PthStrX $PthStrY $PthStrZ\n";
#        print PntOut "$PthStrElm $PthStrX $PthStrY $PthStrZ\n";
       }
    #  print "$PthStrElm $PthDstSum $PthStrY 0.0\n";
      }


# **********************************************************************************


   if($RefY != 0 && $RefY ne "")
     {

# ********************************************* The line of code below was changed so that $SumRefZ was substituted for $RefY -- 29SEP2019

   $CrbFltStg = "C 0.0 $SumRefZ 0.0\n";
   push(@CrbFltAry,$CrbFltStg);
   $CrbUnfStg = "C $RefX $RefY $RefZ\n";
   push(@CrbUnfAry,$CrbUnfStg);
#   print "$CrbFltStg $CrbUnfStg\n";
     }

   if($RefY == 0 && $RefY ne "")
     {

# ******************************************** The line of code below was changed so that $SumRefZ was substituted for $RefY -- 29SEP2019

   $CrbFltStg = "Cs 0.0 $SumRefZ 0.0\n";
   push(@CrbFltAry,$CrbFltStg);
   $CrbUnfStg = "Cs $RefX $RefY $RefZ\n";
   push(@CrbUnfAry,$CrbUnfStg);
#   print "$CrbFltStg $CrbUnfStg\n";
     }


} # MASTER LOOP CLOSE

 @CrbFltUnq = uniq @CrbFltAry;
 @CrbUnfUnq = uniq @CrbUnfAry;


push(@FltAry,@CrbFltUnq);
push(@UnfAry,@CrbUnfUnq);
# push(@UnfAry,@OutAry);

$OutOutSze = @OutAry;
$FltArySze = @FltAry;
$UnfArySze = @UnfAry;
$WhlArySze = @WhlCnt;

$UnfAddSze = $OutOutSze + $UnfArySze + $WhlArySze;

open(PntOut,">FlattenedContour_$BseFleNme.xyz");
open(UnfOut,">UnFlattenedContour_$BseFleNme.xyz");
    
print PntOut "$FltArySze\n";
print PntOut "\n";
print UnfOut "$UnfAddSze\n";
print UnfOut "\n";

close(PntOut);
close(UnfOut);

open(PntOut,">>FlattenedContour_$BseFleNme.xyz");
open(UnfOut,">>UnFlattenedContour_$BseFleNme.xyz");

# foreach $CrbRefVal (@CrbRefAry)
#      {
#      print PntOut "$CrbRefVal\n";
#      print UnfOut "$CrbRefVal\n";
#      }

foreach $FltAryOut (@FltAry)
      {
      print PntOut "$FltAryOut";
      }

foreach $UnfAryOut (@UnfAry)
      {
      print UnfOut "$UnfAryOut";
      }

foreach $OutAryOut (@OutAry)
      {
      print UnfOut "$OutAryOut\n";
      }

foreach $WhlAryOut (@WhlCnt)
      {
      print UnfOut "$WhlAryOut\n";
      }

close(PntOut);
close(UnfOut);



# close(TrmOut);
print "Waiting to terminate\n";
sleep(300);

















