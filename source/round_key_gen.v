module round_key_gen(
input iClk,
input iRst_n,
input iEn,
input 	[0:255] iKey,
output  [0: ((256*7)-1)] oGen_Key //Contains all gen key for 14 rounds
//output [0:127] oLSB_Key1, oLSB_Key3, oLSB_Key5, oLSB_Key7, oLSB_Key9, oLSB_Key11, oLSB_Key13,
//output [0:127] oMSB_Key1, oMSB_Key3, oMSB_Key5, oMSB_Key7, oMSB_Key9, oMSB_Key11, oMSB_Key13
);

wire [0:127] wLSB_Key1, wLSB_Key3, wLSB_Key5, wLSB_Key7, wLSB_Key9, wLSB_Key11, wLSB_Key13;
wire [0:127] wMSB_Key1, wMSB_Key3, wMSB_Key5, wMSB_Key7, wMSB_Key9, wMSB_Key11, wMSB_Key13;
wire [0:255] wKEY1, wKEY3, wKEY5, wKEY7, wKEY9, wKEY11, wKEY13;
wire [3:0] rcon [0:6]; //TODO: can be optimized

// Need to gen 7 keys, each key for 2 rounds
key_expansion KEY_EXPAND1(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(iKey),
.cnt_rcon(rcon[0]),
.oLSB_Key(wLSB_Key1),
.oMSB_Key(wMSB_Key1),
.oKey(wKEY1)
);

key_expansion KEY_EXPAND3(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(wKEY1),
.cnt_rcon(rcon[1]),
.oLSB_Key(wLSB_Key3),
.oMSB_Key(wMSB_Key3),
.oKey(wKEY3)
);

key_expansion KEY_EXPAND5(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(wKEY3),
.cnt_rcon(rcon[2]),
.oLSB_Key(wLSB_Key5),
.oMSB_Key(wMSB_Key5),
.oKey(wKEY5)
);

key_expansion KEY_EXPAND7(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(wKEY5),
.cnt_rcon(rcon[3]),
.oLSB_Key(wLSB_Key7),
.oMSB_Key(wMSB_Key7),
.oKey(wKEY7)
);

key_expansion KEY_EXPAND9(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(wKEY7),
.cnt_rcon(rcon[4]),
.oLSB_Key(wLSB_Key9),
.oMSB_Key(wMSB_Key9),
.oKey(wKEY9)
);

key_expansion KEY_EXPAND11(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(wKEY9),
.cnt_rcon(rcon[5]),
.oLSB_Key(wLSB_Key11),
.oMSB_Key(wMSB_Key11),
.oKey(wKEY11)
);

key_expansion KEY_EXPAND13(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(wKEY11),
.cnt_rcon(rcon[6]),
.oLSB_Key(wLSB_Key13),
.oMSB_Key(wMSB_Key13),
.oKey(wKEY13)
);

assign rcon[0] = 4'd1;
assign rcon[1] = 4'd2;
assign rcon[2] = 4'd3;
assign rcon[3] = 4'd4;
assign rcon[4] = 4'd5;
assign rcon[5] = 4'd6;
assign rcon[6] = 4'd7;

//output LSB Key
// assign oLSB_Key1 = wLSB_Key1;
// assign oLSB_Key3 = wLSB_Key3;
// assign oLSB_Key5 = wLSB_Key5;
// assign oLSB_Key7 = wLSB_Key7;
// assign oLSB_Key9 = wLSB_Key9;
// assign oLSB_Key11 = wLSB_Key11;
// assign oLSB_Key13 = wLSB_Key13;

//output MSB Key
// assign oMSB_Key1 = wMSB_Key1;
// assign oMSB_Key3 = wMSB_Key3;
// assign oMSB_Key5 = wMSB_Key5;
// assign oMSB_Key7 = wMSB_Key7;
// assign oMSB_Key9 = wMSB_Key9;
// assign oMSB_Key11 = wMSB_Key11;
// assign oMSB_Key13 = wMSB_Key13;

//contains all key
assign oGen_Key = {wLSB_Key1, wMSB_Key1, wLSB_Key3, wMSB_Key3, wLSB_Key5, wMSB_Key5, wLSB_Key7, wMSB_Key7, wLSB_Key9, wMSB_Key9, wLSB_Key11, wMSB_Key11, wLSB_Key13, wMSB_Key13};
//use for debug
//assign oGen_key = {wKEY1, wKEY3, wKEY5, wKEY7, wKEY9, wKEY11, wKEY13};


endmodule