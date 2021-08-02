module add_round_key(
input  [0:127] iKey ,
input  [0:127] iState,
output [0:127] oState
);

assign oState = iState ^ iKey;

endmodule
