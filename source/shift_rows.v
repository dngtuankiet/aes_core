module shift_rows (
input  [0:127] iState,
output [0:127] oState
);

wire  [0:127] shiftted_data;

/* row 0 shifts 0 */
assign shiftted_data[0+:8]   = iState[0+:8];
assign shiftted_data[32+:8]  = iState[32+:8];
assign shiftted_data[64+:8]  = iState[64+:8];
assign shiftted_data[96+:8]  = iState[96+:8];

/* row 1 shifts 1*/
assign shiftted_data[8+:8]   = iState[40+:8];
assign shiftted_data[40+:8]  = iState[72+:8];
assign shiftted_data[72+:8]  = iState[104+:8];
assign shiftted_data[104+:8] = iState[8+:8];

/* row 2 shifts 2*/
assign shiftted_data[16+:8]  = iState[80+:8];
assign shiftted_data[48+:8]  = iState[112+:8];
assign shiftted_data[80+:8]  = iState[16+:8];
assign shiftted_data[112+:8] = iState[48+:8];

/* row 3 shifts 3*/
assign shiftted_data[24+:8]  = iState[120+:8];
assign shiftted_data[56+:8]  = iState[24+:8];
assign shiftted_data[88+:8]  = iState[56+:8];
assign shiftted_data[120+:8] = iState[88+:8];

assign oState = shiftted_data;

endmodule
