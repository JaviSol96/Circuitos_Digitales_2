/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* top =  1  *)
(* src = "Counter.v:96" *)
module Counter16(clk, enb, modo, D2, Q2, rco1, rco2, rco3, rco4);
  (* src = "Counter.v:96" *)
  wire _00_;
  (* src = "Counter.v:106" *)
  wire _01_;
  (* src = "Counter.v:107" *)
  wire _02_;
  (* src = "Counter.v:108" *)
  wire _03_;
  (* src = "Counter.v:98" *)
  wire _04_;
  (* src = "Counter.v:98" *)
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  (* src = "Counter.v:101" *)
  wire _12_;
  (* src = "Counter.v:102" *)
  wire _13_;
  (* src = "Counter.v:103" *)
  wire _14_;
  wire [1:0] _15_;
  wire _16_;
  (* src = "Counter.v:112" *)
  wire _17_;
  (* src = "Counter.v:112" *)
  wire _18_;
  (* src = "Counter.v:113" *)
  wire _19_;
  (* src = "Counter.v:114" *)
  wire _20_;
  (* src = "Counter.v:99" *)
  input [15:0] D2;
  (* src = "Counter.v:100" *)
  output [15:0] Q2;
  (* src = "Counter.v:96" *)
  input clk;
  (* src = "Counter.v:106" *)
  wire clk2;
  (* src = "Counter.v:107" *)
  wire clk3;
  (* src = "Counter.v:108" *)
  wire clk4;
  (* src = "Counter.v:97" *)
  input enb;
  (* src = "Counter.v:98" *)
  input [1:0] modo;
  (* src = "Counter.v:109" *)
  wire modo_11;
  (* src = "Counter.v:101" *)
  output rco1;
  (* src = "Counter.v:102" *)
  output rco2;
  (* src = "Counter.v:103" *)
  output rco3;
  (* src = "Counter.v:104" *)
  output rco4;
  NAND _21_ (
    .A(_04_),
    .B(_05_),
    .Y(_06_)
  );
  NOT _22_ (
    .A(_06_),
    .Y(_07_)
  );
  NAND _23_ (
    .A(_00_),
    .B(_07_),
    .Y(_08_)
  );
  NAND _24_ (
    .A(_12_),
    .B(_06_),
    .Y(_09_)
  );
  NAND _25_ (
    .A(_08_),
    .B(_09_),
    .Y(_01_)
  );
  NAND _26_ (
    .A(_13_),
    .B(_06_),
    .Y(_10_)
  );
  NAND _27_ (
    .A(_08_),
    .B(_10_),
    .Y(_02_)
  );
  NAND _28_ (
    .A(_14_),
    .B(_06_),
    .Y(_11_)
  );
  NAND _29_ (
    .A(_08_),
    .B(_11_),
    .Y(_03_)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:118" *)
  counter contador1 (
    .D(D2[3:0]),
    .Q(Q2[3:0]),
    .clk(clk),
    .enb(enb),
    .modo(modo),
    .rco(rco1)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:119" *)
  counter contador2 (
    .D(D2[7:4]),
    .Q(Q2[7:4]),
    .clk(clk2),
    .enb(enb),
    .modo(modo),
    .rco(rco2)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:120" *)
  counter contador3 (
    .D(D2[11:8]),
    .Q(Q2[11:8]),
    .clk(clk3),
    .enb(enb),
    .modo(modo),
    .rco(rco3)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:121" *)
  counter contador4 (
    .D(D2[15:12]),
    .Q(Q2[15:12]),
    .clk(clk4),
    .enb(enb),
    .modo(modo),
    .rco(rco4)
  );
  assign clk2 = _01_;
  assign _12_ = rco1;
  assign _13_ = rco2;
  assign clk3 = _02_;
  assign _00_ = clk;
  assign _14_ = rco3;
  assign clk4 = _03_;
  assign _04_ = modo[0];
  assign _05_ = modo[1];
endmodule

(* src = "flipflop.v:4" *)
module DFF_nbits_enb(clk, enb, d, q);
  (* src = "flipflop.v:12" *)
  wire _00_;
  (* src = "flipflop.v:12" *)
  wire _01_;
  (* src = "flipflop.v:8" *)
  wire _02_;
  (* src = "flipflop.v:7" *)
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  (* src = "flipflop.v:9" *)
  wire _07_;
  (* src = "flipflop.v:6" *)
  input clk;
  (* src = "flipflop.v:8" *)
  input d;
  (* src = "flipflop.v:7" *)
  input enb;
  (* src = "flipflop.v:9" *)
  output q;
  NOT _08_ (
    .A(_03_),
    .Y(_04_)
  );
  NAND _09_ (
    .A(_02_),
    .B(_03_),
    .Y(_05_)
  );
  NAND _10_ (
    .A(_07_),
    .B(_04_),
    .Y(_06_)
  );
  NAND _11_ (
    .A(_05_),
    .B(_06_),
    .Y(_01_)
  );
  (* src = "flipflop.v:12" *)
  DFF _12_ (
    .C(clk),
    .D(_00_),
    .Q(q)
  );
  assign _07_ = q;
  assign _02_ = d;
  assign _03_ = enb;
  assign _00_ = _01_;
endmodule

(* src = "Counter.v:3" *)
module counter(clk, enb, modo, D, Q, rco);
  (* src = "Counter.v:21" *)
  wire _000_;
  (* src = "Counter.v:21" *)
  wire _001_;
  (* src = "Counter.v:21" *)
  wire _002_;
  (* src = "Counter.v:21" *)
  wire _003_;
  (* src = "Counter.v:6" *)
  wire _004_;
  (* src = "Counter.v:6" *)
  wire _005_;
  (* src = "Counter.v:6" *)
  wire _006_;
  (* src = "Counter.v:6" *)
  wire _007_;
  (* src = "Counter.v:10" *)
  wire _008_;
  (* src = "Counter.v:10" *)
  wire _009_;
  (* src = "Counter.v:10" *)
  wire _010_;
  (* src = "Counter.v:10" *)
  wire _011_;
  (* src = "Counter.v:11" *)
  wire _012_;
  (* src = "Counter.v:7" *)
  wire _013_;
  (* src = "Counter.v:7" *)
  wire _014_;
  (* src = "Counter.v:7" *)
  wire _015_;
  (* src = "Counter.v:7" *)
  wire _016_;
  (* src = "Counter.v:5" *)
  wire _017_;
  (* src = "Counter.v:5" *)
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  (* src = "Counter.v:27" *)
  (* unused_bits = "4" *)
  wire [31:0] _078_;
  wire [1:0] _079_;
  wire [1:0] _080_;
  wire [1:0] _081_;
  wire [1:0] _082_;
  wire [1:0] _083_;
  wire [1:0] _084_;
  wire [1:0] _085_;
  wire [1:0] _086_;
  wire [1:0] _087_;
  wire [1:0] _088_;
  wire _089_;
  wire [1:0] _090_;
  wire _091_;
  wire _092_;
  wire [3:0] _093_;
  wire [1:0] _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  (* src = "Counter.v:52" *)
  wire _101_;
  (* src = "Counter.v:52" *)
  wire _102_;
  (* src = "Counter.v:52" *)
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  (* src = "Counter.v:62|Counter.v:22|<techmap.v>:432" *)
  wire [3:0] _108_;
  (* src = "Counter.v:62|Counter.v:22|<techmap.v>:428" *)
  wire _109_;
  (* src = "Counter.v:62|Counter.v:22|<techmap.v>:432" *)
  wire [15:0] _110_;
  (* src = "Counter.v:62|Counter.v:22|<techmap.v>:428" *)
  wire [3:0] _111_;
  (* src = "Counter.v:39" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _112_;
  (* src = "Counter.v:51" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _113_;
  (* src = "Counter.v:27|<techmap.v>:260|<techmap.v>:203" *)
  (* unused_bits = "3" *)
  wire [31:0] _114_;
  (* src = "Counter.v:62|Counter.v:22|<techmap.v>:445" *)
  wire _115_;
  (* src = "Counter.v:39|<techmap.v>:260|<techmap.v>:203" *)
  (* unused_bits = "3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _116_;
  (* src = "Counter.v:51|Counter.v:39|<techmap.v>:260|<techmap.v>:203" *)
  (* unused_bits = "3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _117_;
  (* src = "Counter.v:39|<techmap.v>:260|<techmap.v>:221" *)
  wire _118_;
  (* src = "Counter.v:39|<techmap.v>:260|<techmap.v>:229" *)
  wire _119_;
  (* src = "Counter.v:51|Counter.v:39|<techmap.v>:260|<techmap.v>:229" *)
  wire _120_;
  (* src = "Counter.v:6" *)
  input [3:0] D;
  (* src = "Counter.v:10" *)
  wire [3:0] D_In;
  (* src = "Counter.v:11" *)
  wire D_Out;
  (* src = "Counter.v:7" *)
  output [3:0] Q;
  (* src = "Counter.v:3" *)
  input clk;
  (* src = "Counter.v:4" *)
  input enb;
  (* src = "Counter.v:5" *)
  input [1:0] modo;
  (* src = "Counter.v:8" *)
  output rco;
  NOT _121_ (
    .A(_015_),
    .Y(_019_)
  );
  NOT _122_ (
    .A(_016_),
    .Y(_020_)
  );
  NOT _123_ (
    .A(_017_),
    .Y(_021_)
  );
  NOT _124_ (
    .A(_018_),
    .Y(_022_)
  );
  NOT _125_ (
    .A(_005_),
    .Y(_023_)
  );
  NOT _126_ (
    .A(_006_),
    .Y(_024_)
  );
  NOT _127_ (
    .A(_007_),
    .Y(_025_)
  );
  NAND _128_ (
    .A(_014_),
    .B(_013_),
    .Y(_026_)
  );
  NOT _129_ (
    .A(_026_),
    .Y(_027_)
  );
  NOR _130_ (
    .A(_015_),
    .B(_027_),
    .Y(_028_)
  );
  NAND _131_ (
    .A(_021_),
    .B(_018_),
    .Y(_029_)
  );
  NOR _132_ (
    .A(_014_),
    .B(_013_),
    .Y(_030_)
  );
  NOT _133_ (
    .A(_030_),
    .Y(_031_)
  );
  NOR _134_ (
    .A(_015_),
    .B(_031_),
    .Y(_032_)
  );
  NAND _135_ (
    .A(_017_),
    .B(_022_),
    .Y(_033_)
  );
  NOR _136_ (
    .A(_016_),
    .B(_033_),
    .Y(_034_)
  );
  NAND _137_ (
    .A(_032_),
    .B(_034_),
    .Y(_035_)
  );
  NOR _138_ (
    .A(_016_),
    .B(_029_),
    .Y(_036_)
  );
  NAND _139_ (
    .A(_028_),
    .B(_036_),
    .Y(_037_)
  );
  NAND _140_ (
    .A(_035_),
    .B(_037_),
    .Y(_038_)
  );
  NAND _141_ (
    .A(_017_),
    .B(_018_),
    .Y(_039_)
  );
  NOR _142_ (
    .A(_004_),
    .B(_039_),
    .Y(_040_)
  );
  NOR _143_ (
    .A(_005_),
    .B(_006_),
    .Y(_041_)
  );
  NOT _144_ (
    .A(_041_),
    .Y(_042_)
  );
  NOR _145_ (
    .A(_007_),
    .B(_042_),
    .Y(_043_)
  );
  NAND _146_ (
    .A(_040_),
    .B(_043_),
    .Y(_044_)
  );
  NOR _147_ (
    .A(_019_),
    .B(_026_),
    .Y(_045_)
  );
  NAND _148_ (
    .A(_016_),
    .B(_045_),
    .Y(_046_)
  );
  NOR _149_ (
    .A(_017_),
    .B(_018_),
    .Y(_047_)
  );
  NOT _150_ (
    .A(_047_),
    .Y(_048_)
  );
  NOR _151_ (
    .A(_046_),
    .B(_048_),
    .Y(_049_)
  );
  NOR _152_ (
    .A(_038_),
    .B(_049_),
    .Y(_050_)
  );
  NAND _153_ (
    .A(_044_),
    .B(_050_),
    .Y(_012_)
  );
  NAND _154_ (
    .A(_013_),
    .B(_039_),
    .Y(_051_)
  );
  NOT _155_ (
    .A(_051_),
    .Y(_052_)
  );
  NOR _156_ (
    .A(_040_),
    .B(_052_),
    .Y(_008_)
  );
  NOR _157_ (
    .A(_027_),
    .B(_030_),
    .Y(_053_)
  );
  NAND _158_ (
    .A(_021_),
    .B(_053_),
    .Y(_054_)
  );
  NOR _159_ (
    .A(_033_),
    .B(_053_),
    .Y(_055_)
  );
  NOR _160_ (
    .A(_023_),
    .B(_039_),
    .Y(_056_)
  );
  NOR _161_ (
    .A(_055_),
    .B(_056_),
    .Y(_057_)
  );
  NAND _162_ (
    .A(_054_),
    .B(_057_),
    .Y(_009_)
  );
  NOR _163_ (
    .A(_028_),
    .B(_045_),
    .Y(_058_)
  );
  NAND _164_ (
    .A(_047_),
    .B(_058_),
    .Y(_059_)
  );
  NOT _165_ (
    .A(_059_),
    .Y(_060_)
  );
  NOR _166_ (
    .A(_029_),
    .B(_058_),
    .Y(_061_)
  );
  NOR _167_ (
    .A(_060_),
    .B(_061_),
    .Y(_062_)
  );
  NOR _168_ (
    .A(_019_),
    .B(_030_),
    .Y(_063_)
  );
  NOR _169_ (
    .A(_024_),
    .B(_039_),
    .Y(_064_)
  );
  NOR _170_ (
    .A(_032_),
    .B(_063_),
    .Y(_065_)
  );
  NOR _171_ (
    .A(_033_),
    .B(_065_),
    .Y(_066_)
  );
  NOR _172_ (
    .A(_064_),
    .B(_066_),
    .Y(_067_)
  );
  NAND _173_ (
    .A(_062_),
    .B(_067_),
    .Y(_010_)
  );
  NOR _174_ (
    .A(_025_),
    .B(_039_),
    .Y(_068_)
  );
  NOR _175_ (
    .A(_038_),
    .B(_068_),
    .Y(_069_)
  );
  NOR _176_ (
    .A(_016_),
    .B(_045_),
    .Y(_070_)
  );
  NAND _177_ (
    .A(_046_),
    .B(_047_),
    .Y(_071_)
  );
  NOR _178_ (
    .A(_070_),
    .B(_071_),
    .Y(_072_)
  );
  NOR _179_ (
    .A(_032_),
    .B(_033_),
    .Y(_073_)
  );
  NOR _180_ (
    .A(_028_),
    .B(_029_),
    .Y(_074_)
  );
  NOR _181_ (
    .A(_073_),
    .B(_074_),
    .Y(_075_)
  );
  NOR _182_ (
    .A(_020_),
    .B(_075_),
    .Y(_076_)
  );
  NOR _183_ (
    .A(_072_),
    .B(_076_),
    .Y(_077_)
  );
  NAND _184_ (
    .A(_069_),
    .B(_077_),
    .Y(_011_)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:83" *)
  DFF_nbits_enb DFF_1bit (
    .clk(clk),
    .d(D_Out),
    .enb(enb),
    .q(rco)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:79" *)
  DFF_nbits_enb DFF_4bits1 (
    .clk(clk),
    .d(D_In[0]),
    .enb(enb),
    .q(Q[0])
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:80" *)
  DFF_nbits_enb DFF_4bits2 (
    .clk(clk),
    .d(D_In[1]),
    .enb(enb),
    .q(Q[1])
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:81" *)
  DFF_nbits_enb DFF_4bits3 (
    .clk(clk),
    .d(D_In[2]),
    .enb(enb),
    .q(Q[2])
  );
  (* module_not_derived = 32'd1 *)
  (* src = "Counter.v:82" *)
  DFF_nbits_enb DFF_4bits4 (
    .clk(clk),
    .d(D_In[3]),
    .enb(enb),
    .q(Q[3])
  );
  assign _078_[31:5] = 27'h0000000;
  assign _081_[1] = _080_[1];
  assign _088_[1] = _080_[1];
  assign _093_[0] = _078_[0];
  assign { _112_[30:4], _112_[0] } = { _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _112_[31], _078_[0] };
  assign { _113_[30:4], _113_[1:0] } = { _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _113_[31], _078_[1:0] };
  assign { _114_[31:3], _114_[0] } = { 28'h0000000, _078_[4], Q[0] };
  assign { _116_[30:3], _116_[0] } = { _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], _116_[31], Q[0] };
  assign { _117_[30:3], _117_[1:0] } = { _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _117_[31], _114_[1], Q[0] };
  assign _014_ = Q[1];
  assign _013_ = Q[0];
  assign _015_ = Q[2];
  assign _016_ = Q[3];
  assign _017_ = modo[0];
  assign _018_ = modo[1];
  assign _004_ = D[0];
  assign _005_ = D[1];
  assign _006_ = D[2];
  assign _007_ = D[3];
  assign D_Out = _012_;
  assign D_In[0] = _008_;
  assign D_In[1] = _009_;
  assign D_In[2] = _010_;
  assign D_In[3] = _011_;
endmodule
