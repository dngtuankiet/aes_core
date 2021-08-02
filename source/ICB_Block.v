module ICB_Block(
input iCLk,
input iRst_n,
input iEn,
input iStart_cnt,
input [0:95] iIV,
input iValid_IV,
output [0:127] oICB
);

reg [0:96] rIV;
reg [0:13] cnt;
wire wOverFlow;

//counter
always @(posedge iClk) begin
	if(~iRst_n | wOverFlow)		cnt <= 32'd0;
	else if(iEn)				cnt <= cnt + 1'd1;
	else 						cnt <= cnt;
end

assign wOverFlow = cnt[31]; //TODO: modify later

//sample IV
always @(posedge iClk) begin
	if(~iRst_n)		rIV <= 96'd0;
	else if(iEn)	rIV <= iIV;
	else 			rIV <= rIV;
end

//Output
assign oICB = {rIV, cnt};

endmodule
