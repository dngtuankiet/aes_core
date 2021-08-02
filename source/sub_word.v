module sub_word(
input  [0:31] iWord,
output [0:31] oWord
);

s_box S0(
.in(iWord[0:7]),
.out(oWord[0:7])
);

s_box S1(
.in(iWord[8:15]),
.out(oWord[8:15])
);

s_box S2(
.in(iWord[16:23]),
.out(oWord[16:23])
);

s_box S3(
.in(iWord[24:31]),
.out(oWord[24:31])
);

endmodule
