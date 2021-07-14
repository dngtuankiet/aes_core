module sub_byte(
input [0:127] iState,
input [0:127] oState
);

/* Lookup S-Box*/

/* Column 0*/
s_box SB00(
.in(iState[0:7]),
.out(oState[0:7])
);

s_box SB10(
.in(iState[8:15]),
.out(oState[8:15])
);

s_box SB20(
.in(iState[16:23]),
.out(oState[16:23])
);

s_box SB30(
.in(iState[24:31]),
.out(oState[24:31])
);

/* Column 1*/
s_box SB01(
.in(iState[32:39]),
.out(oState[32:39])
);

s_box SB11(
.in(iState[40:47]),
.out(oState[40:47])
);

s_box SB21(
.in(iState[48:55]),
.out(oState[48:55])
);

s_box SB31(
.in(iState[56:63]),
.out(oState[56:63])
);

/* Column 2*/
s_box SB02(
.in(iState[64:71]),
.out(oState[64:71])
);

s_box SB12(
.in(iState[72:79]),
.out(oState[72:79])
);

s_box SB22(
.in(iState[80:87]),
.out(oState[80:87])
);

s_box SB32(
.in(iState[88:95]),
.out(oState[88:95])
);

/* Column 3*/
s_box SB03(
.in(iState[96:103]),
.out(oState[96:103])
);

s_box SB13(
.in(iState[104:111]),
.out(oState[104:111])
);

s_box SB23(
.in(iState[112:119]),
.out(oState[112:119])
);

s_box SB33(
.in(iState[120:127]),
.out(oState[120:127])
);

endmodule
