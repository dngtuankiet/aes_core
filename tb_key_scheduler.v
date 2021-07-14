module tb_key_scheduler();
reg CLK;
reg RST;
reg EN;
reg [0:255] KEY;
reg [3:0] ROUND;
wire [0: ((256*7)-1)] OKEY;

wire [0:127] LSB_KEY1, LSB_KEY3, LSB_KEY5, LSB_KEY7, LSB_KEY9, LSB_KEY11, LSB_KEY13;
wire [0:127] MSB_KEY1, MSB_KEY3, MSB_KEY5, MSB_KEY7, MSB_KEY9, MSB_KEY11, MSB_KEY13;
wire [0:255] wKey1, wKey3, wKey5, wKey7, wKey9, wKey11, wKey13;

assign wKey1  = OKEY[0:255];
assign wKey3  = OKEY[256:511];
assign wKey5  = OKEY[512:767];
assign wKey7  = OKEY[768:1023];
assign wKey9  = OKEY[1024:1279];
assign wKey11 = OKEY[1280:1535];
assign wKey13 = OKEY[1536:1791];

assign LSB_KEY1 = wKey1[0:127];
assign LSB_KEY3 = wKey3[0:127];
assign LSB_KEY5 = wKey5[0:127];
assign LSB_KEY7 = wKey7[0:127];
assign LSB_KEY9 = wKey9[0:127];
assign LSB_KEY11 = wKey11[0:127];
assign LSB_KEY13 = wKey13[0:127];

assign MSB_KEY1 = wKey1[128:255];
assign MSB_KEY3 = wKey3[128:255];
assign MSB_KEY5 = wKey5[128:255];
assign MSB_KEY7 = wKey7[128:255];
assign MSB_KEY9 = wKey9[128:255];
assign MSB_KEY11 = wKey11[128:255];
assign MSB_KEY13 = wKey13[128:255];


round_key_gen ROUND_KEY_GEN(
.iClk(CLK),
.iRst_n(RST),
.iEn(EN),
.iKey(KEY),
.oGen_Key(OKEY) //Contains all gen key for 14 rounds
);

initial begin 
CLK = 0;
RST = 0;
KEY = 0;
EN = 0;
ROUND = 0;
end

always #5 CLK = ~CLK;

always @(posedge CLK) begin
if(~RST) ROUND <= 0;
else if(EN) ROUND <= ROUND + 1;
else ROUND <= ROUND;
end

initial begin
#50
@(posedge CLK);
RST = 1;
KEY = 256'h603deb10_15ca71be_2b73aef0_857d7781_1f352c07_3b6108d7_2d9810a3_0914dff4;
EN = 1;
@(posedge CLK)
KEY = 256'd0;
#200
$finish;
end

endmodule
