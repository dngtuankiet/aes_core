module rot_word(
input  [0:31] iWord,
output [0:31] oWord
);

assign oWord[0:7]   = iWord[8:15];
assign oWord[8:15]  = iWord[16:23];
assign oWord[16:23] = iWord[24:31];
assign oWord[24:31] = iWord[0:7];

endmodule
