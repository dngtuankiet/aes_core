module std_round(
input iClk,
input iRst_n,
input iEn,
input iDo,
input  [0:127] iState,
input  [0:127] iKey,
output [0:127] oState,
output oDone
);

reg rDone;
reg [0:127] rState;
wire [0:127] wSub_byte;
wire [0:127] wShift_rows;
wire [0:127] wMix_columns;
wire [0:127] wAdd_round_key;

/*Sub Byte*/
sub_byte SUB_BYTE(
.iState(iState),
.oState(wSub_byte)
);

/*Shift Rows*/
shift_rows SHIFT_ROWS(
.iState(wSub_byte),
.oState(wShift_rows)
);

/*Mix Columns*/
mix_columns MIX_COLUMNS(
.iState(wShift_rows),
.oState(wMix_columns)
);

/*Add Round Key*/
add_round_key ADD_KEY(
.iKey(iKey),
.iState(wMix_columns),
.oState(wAdd_round_key)
);

//Passing round indicator
always @(posedge iClk) begin
	if(~iRst_n)		rDone <= 1'b0;
	else if(iEn)	rDone <= iDo;
	else			rDone <= rDone;
end

//Buffer output
always @(posedge iClk) begin
	if(~iRst_n) 	rState <= 128'd0;
	else if(iEn)	rState <= wAdd_round_key;
	else			rState <= rState;
end

//Output
assign oState = rState;
assign oDone = rDone;

endmodule
