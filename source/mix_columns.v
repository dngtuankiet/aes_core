module mix_columns(
input  [0:127] iState,
output [0:127] oState
);

/* Polynomial multiplication by 2*/
function [7:0] xTime2;
	input [7:0] x;
	begin 
		/* xTime2 = x << 1
		if x[7] == 1 , xor xTime2 after shifted with 0x1B = 0001.1011 */
		xTime2[7] = x[6];		 //0
		xTime2[6] = x[5];		 //0
		xTime2[5] = x[4];		 //0
		xTime2[4] = x[3] ^ x[7]; //1
		xTime2[3] = x[2] ^ x[7]; //1
		xTime2[2] = x[1];		 //0
		xTime2[1] = x[0] ^ x[7]; //1
		xTime2[0] = x[7];		 //1 
	end 	
endfunction

/* Polynomial multiplication by 3*/
function [7:0] xTime3;
	input [7:0] x;
	
	xTime3 = xTime2(x) ^ x;
endfunction
 

wire [0:127] mixing_columns;

/*Column 0*/
assign mixing_columns[0+:8]   = xTime2(iState[0+:8]) ^ xTime3(iState[8+:8]) ^ iState[16+:8]         ^ iState[24+:8];
assign mixing_columns[8+:8]   = iState[0+:8]         ^ xTime2(iState[8+:8]) ^ xTime3(iState[16+:8]) ^ iState[24+:8];
assign mixing_columns[16+:8]  = iState[0+:8]         ^ iState[8+:8] 		^ xTime2(iState[16+:8]) ^ xTime3(iState[24+:8]);
assign mixing_columns[24+:8]  = xTime3(iState[0+:8]) ^ iState[8+:8] 		^ iState[16+:8] 		^ xTime2(iState[24+:8]);

/*Column 1*/
assign mixing_columns[32+:8]  = xTime2(iState[32+:8]) ^ xTime3(iState[40+:8]) ^ iState[48+:8]         ^ iState[56+:8];
assign mixing_columns[40+:8]  = iState[32+:8]         ^ xTime2(iState[40+:8]) ^ xTime3(iState[48+:8]) ^ iState[56+:8];
assign mixing_columns[48+:8]  = iState[32+:8]         ^ iState[40+:8] 		  ^ xTime2(iState[48+:8]) ^ xTime3(iState[56+:8]);
assign mixing_columns[56+:8]  = xTime3(iState[32+:8]) ^ iState[40+:8] 		  ^ iState[48+:8] 		  ^ xTime2(iState[56+:8]);

/*Column 2*/
assign mixing_columns[64+:8]  = xTime2(iState[64+:8]) ^ xTime3(iState[72+:8]) ^ iState[80+:8]         ^ iState[88+:8];
assign mixing_columns[72+:8]  = iState[64+:8]         ^ xTime2(iState[72+:8]) ^ xTime3(iState[80+:8]) ^ iState[88+:8];
assign mixing_columns[80+:8]  = iState[64+:8]         ^ iState[72+:8] 		  ^ xTime2(iState[80+:8]) ^ xTime3(iState[88+:8]);
assign mixing_columns[88+:8]  = xTime3(iState[64+:8]) ^ iState[72+:8] 		  ^ iState[80+:8] 		  ^ xTime2(iState[88+:8]);

/*Column 3*/
assign mixing_columns[96+:8]   = xTime2(iState[96+:8]) ^ xTime3(iState[104+:8]) ^ iState[112+:8]         ^ iState[120+:8];
assign mixing_columns[104+:8]  = iState[96+:8]         ^ xTime2(iState[104+:8]) ^ xTime3(iState[112+:8]) ^ iState[120+:8];
assign mixing_columns[112+:8]  = iState[96+:8]         ^ iState[104+:8] 		^ xTime2(iState[112+:8]) ^ xTime3(iState[120+:8]);
assign mixing_columns[120+:8]  = xTime3(iState[96+:8]) ^ iState[104+:8] 		^ iState[112+:8] 		 ^ xTime2(iState[120+:8]);

assign oState = mixing_columns;

endmodule