module tb_key_expansion();
reg CLK;
reg RST;
reg EN;
reg [0:255] KEY;
reg [3:0] CNT_RCON;
wire [0:127] LSB_KEY;
wire [0:127] MSB_KEY;
wire [0:255] XKEY;

key_expansion KEY_EXPANSION(
.iClk(CLK),
.iRst_n(RST),
.iEn(EN),
.iKey(KEY),
.cnt_rcon(CNT_RCON),
.oLSB_Key(LSB_KEY),
.oMSB_Key(MSB_KEY)
);

assign XKEY = {LSB_KEY, MSB_KEY};

initial begin
CLK = 0;
RST = 0;
EN = 0;
KEY = 0;
CNT_RCON = 0;
end

always #5 CLK = ~CLK;

initial begin
#50
@(posedge CLK);
EN = 1;
RST = 1;
KEY = 256'h603deb10_15ca71be_2b73aef0_857d7781_1f352c07_3b6108d7_2d9810a3_0914dff4;
CNT_RCON = 4'd1;
@(posedge CLK);
@(posedge CLK);
KEY = XKEY;
CNT_RCON = 4'd2;
@(posedge CLK);
@(posedge CLK);
KEY = XKEY;
CNT_RCON = 4'd3;
@(posedge CLK);
@(posedge CLK);
KEY = XKEY;
CNT_RCON = 4'd4;
@(posedge CLK);
@(posedge CLK);
KEY = XKEY;
CNT_RCON = 4'd5;
@(posedge CLK);
@(posedge CLK);
KEY = XKEY;
CNT_RCON = 4'd6;
#100
$finish;
end

endmodule