module key_expansion(
input iClk,
input iRst_n,
input iEn,
input  [0:255] iKey,
input  [3:0] cnt_rcon,
output [0:127] oLSB_Key,
output [0:127] oMSB_Key,
output [0:255] oKey
);

reg [0:255] rKey1;
reg [0:255] rKey2;
//wire [0:255] expanded_key;
wire [0:31] w0, w1, w2, w3, w4, w5, w6, w7; //input
wire [0:31] xW0, xW1, xW2, xW3, xW4, xW5, xW6, xW7; //expanded

wire [0:31] wRot_w0;
wire [0:31] wSub_w0;
wire [0:31] wRcon;
wire [0:31] wXor_rcon;
wire [0:31] wSub_w4;

/* process word 0*/
rot_word ROTW0(
.iWord(w7),
.oWord(wRot_w0)
);

sub_word SUBW0(
.iWord(wRot_w0),
.oWord(wSub_w0)
);

//Get RCON
r_con RCONW0(
.in(cnt_rcon),
.out(wRcon)
);

assign wXor_rcon = wSub_w0 ^ wRcon;
assign xW0 = wXor_rcon ^ w0;

/* process word 1*/
assign xW1 = xW0 ^ w1;

/* process word 2*/
assign xW2 = xW1 ^ w2;

/* process word 3*/
assign xW3 = xW2 ^ w3;

/* process word 4*/

sub_word SUBW4(
.iWord(xW3),
.oWord(wSub_w4)
);

assign xW4 = wSub_w4 ^ w4;

/* process word 5*/
assign xW5 = xW4 ^ w5;

/* process word 6*/
assign xW6 = xW5 ^ w6;

/* process word 7*/
assign xW7 = xW6 ^ w7;

//word creation from input key
assign w0 = {iKey[0+:8], iKey[8+:8], iKey[16+:8], iKey[24+:8]};
assign w1 = {iKey[32+:8], iKey[40+:8], iKey[48+:8], iKey[56+:8]};
assign w2 = {iKey[64+:8], iKey[72+:8], iKey[80+:8], iKey[88+:8]};
assign w3 = {iKey[96+:8], iKey[104+:8], iKey[112+:8], iKey[120+:8]};
assign w4 = {iKey[128+:8], iKey[136+:8], iKey[144+:8], iKey[152+:8]};
assign w5 = {iKey[160+:8], iKey[168+:8], iKey[176+:8], iKey[184+:8]};
assign w6 = {iKey[192+:8], iKey[200+:8], iKey[208+:8], iKey[216+:8]};
assign w7 = {iKey[224+:8], iKey[232+:8], iKey[240+:8], iKey[248+:8]};
//assign expand_key =

//Delay key output 2 clock for 2 rounds
always @(posedge iClk) begin
	if(~iRst_n) 	rKey1 <= 256'd0;
	else if(iEn) 	rKey1 <= {xW0, xW1, xW2, xW3, xW4, xW5, xW6, xW7};
	else			rKey1 <= rKey1;
end 

always @(posedge iClk) begin
	if(~iRst_n) 	rKey2 <= 256'd0;
	else if(iEn) 	rKey2 <= rKey1;
	else			rKey2 <= rKey2;
end 

//output partial key

assign oLSB_Key = rKey1[0:127];
assign oMSB_Key = rKey2[128:255];
assign oKey = rKey2;

endmodule