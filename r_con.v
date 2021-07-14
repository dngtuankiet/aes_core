module r_con(
input      [0:3] in,
output reg [0:31] out
);
//TODO: can be optimized
always @(*)
 case(in)
	4'h1: out = 32'h01000000;
	4'h2: out = 32'h02000000;
	4'h3: out = 32'h04000000;
	4'h4: out = 32'h08000000;
	4'h5: out = 32'h10000000;
	4'h6: out = 32'h20000000;
	4'h7: out = 32'h40000000;
    default: out = 32'h0000_0000;
  endcase
endmodule

/*
    4'h1: out = 32'h0100_0000;
    4'h2: out = 32'h0100_0000;
    4'h3: out = 32'h0200_0000;
    4'h4: out = 32'h0200_0000;
    4'h5: out = 32'h0400_0000;
    4'h6: out = 32'h0400_0000;
    4'h7: out = 32'h0800_0000;
    4'h8: out = 32'h0800_0000;
    4'h9: out = 32'h1000_0000;
    4'hA: out = 32'h1000_0000;
	4'hB: out = 32'h2000_0000;
	4'hC: out = 32'h2000_0000;
	4'hD: out = 32'h4000_0000;
	4'hE: out = 32'h4000_0000;
*/
/*
4'h1: out = 32'h01000000;
4'h2: out = 32'h02000000;
4'h3: out = 32'h04000000;
4'h4: out = 32'h08000000;
4'h5: out = 32'h10000000;
4'h6: out = 32'h20000000;
4'h7: out = 32'h40000000;
4'h8: out = 32'h80000000;
4'h9: out = 32'h1b000000;
4'ha: out = 32'h36000000;
4'hB: out = 32'h6c000000;
4'hC: out = 32'hd8000000;
4'hD: out = 32'hab000000;
4'hE: out = 32'h4d000000;
4'hF: out = 32'h9a000000;
*/