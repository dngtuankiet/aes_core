module AES_Block(
input 	iClk,
input 	iRst_n,
input 	iEn,			//Enable signal
input 	[0:127] iPtext, //Plaintext
input 	iValid_Ptext,	//Input valid Plaintext
input 	[0:255] iKey,	//Key
input 	iValid_Key,		//Input valid Key
output 	[0:127] oCtext, //Ciphertext 
output  oValid_Ctext	//Output valid Ciphertext
);
//For input data management
reg [0:127] rPT;  							//reg Plaintext
reg [0:255] rKey; 							//reg Key
reg  rDo;									//initial Do signal

//For key generation
wire [0: ((256*7)-1)] wGen_key; //contains all gen key
wire [0:255] wKey1, wKey3, wKey5, wKey7, wKey9, wKey11, wKey13;

//For rounds
reg  [0:127] rAlign;																		//1 clock align text path with key path 
wire [0:127] wIn_r1;																		//input first round
wire [0:127] wOut_r1, wOut_r2, wOut_r3, wOut_r4, wOut_r5, wOut_r6, wOut_r7;					//output each round
wire [0:127] wOut_r8, wOut_r9, wOut_r10, wOut_r11, wOut_r12, wOut_r13, wOut_r14; 			//output each round
wire wDone1, wDone2, wDone3, wDone4, wDone5, wDone6, wDone7;								//done signal indicate output data from a round is valid, this signal travels along with State from the begining
wire wDone8, wDone9, wDone10, wDone11, wDone12, wDone13, wDone14;							//pair (State-Done),  (State-1): valid State, (State-0): dump State


/*----------------KEY GENERATION-----------------*/
round_key_gen GEN_KEY(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iKey(rKey),
.oGen_Key(wGen_key)
);


/*----------------ROUND START-----------------*/
//Add round key before start round - Using Original key LSB 0-127
/* ---Original Key---*/
add_round_key ADD_ROUND_KEY(
.iState(rPT),
.iKey(rKey[0:127]),
.oState(wIn_r1)
);

/*----------------STANDARD ROUND-----------------*/

/* ---Key Gen 1---*/
std_round R1(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(rDo),
.iState(wIn_r1),
.iKey(rKey[128:255]),
.oState(wOut_r1),
.oDone(wDone1)
);
std_round R2(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone1),
.iState(wOut_r1),
.iKey(wKey1[0:127]),
.oState(wOut_r2),
.oDone(wDone2)
);

/* ---Key Gen 3---*/
std_round R3(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone2), 
.iState(wOut_r2),
.iKey(wKey1[128:255]),
.oState(wOut_r3),
.oDone(wDone3)
);
std_round R4(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone3), 
.iState(wOut_r3),
.iKey(wKey3[0:127]),
.oState(wOut_r4),
.oDone(wDone4)
);

/* ---Key Gen 5---*/
std_round R5(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone4),
.iState(wOut_r4),
.iKey(wKey3[128:255]),
.oState(wOut_r5),
.oDone(wDone5)
);
std_round R6(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone5),
.iState(wOut_r5),
.iKey(wKey5[0:127]),
.oState(wOut_r6),
.oDone(wDone6)
);

/* ---Key Gen 7---*/
std_round R7(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone6), 
.iState(wOut_r6),
.iKey(wKey5[128:255]),
.oState(wOut_r7),
.oDone(wDone7)
);
std_round R8(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone7),
.iState(wOut_r7),
.iKey(wKey7[0:127]),
.oState(wOut_r8),
.oDone(wDone8)
);

/* ---Key Gen 9---*/
std_round R9(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone8),
.iState(wOut_r8),
.iKey(wKey7[128:255]),
.oState(wOut_r9),
.oDone(wDone9)
);
std_round R10(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone9),
.iState(wOut_r9),
.iKey(wKey9[0:127]),
.oState(wOut_r10),
.oDone(wDone10)
);

/* ---Key Gen 11---*/
std_round R11(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone10),
.iState(wOut_r10),
.iKey(wKey9[128:255]),
.oState(wOut_r11),
.oDone(wDone11)
);
std_round R12(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone11),
.iState(wOut_r11),
.iKey(wKey11[0:127]),
.oState(wOut_r12),
.oDone(wDone12)
);

/* ---Key Gen 13---*/
std_round R13(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone12),
.iState(wOut_r12),
.iKey(wKey11[128:255]),
.oState(wOut_r13),
.oDone(wDone13)
);
/*----------------LAST ROUND-----------------*/
last_round R14(
.iClk(iClk),
.iRst_n(iRst_n),
.iEn(iEn),
.iDo(wDone13),
.iState(wOut_r13),
.iKey(wKey13[0:127]),
.oState(wOut_r14),
.oDone(wDone14) //TODO: FSM takes this for processing output
);



//Key split after get output key from round_gen_key
assign wKey1  = wGen_key[0:255];
assign wKey3  = wGen_key[256:511];
assign wKey5  = wGen_key[512:767];
assign wKey7  = wGen_key[768:1023];
assign wKey9  = wGen_key[1024:1279];
assign wKey11 = wGen_key[1280:1535];
assign wKey13 = wGen_key[1536:1791];

/*---------------------TEXT-----------------------*/

//Sample Plaintext
always @(posedge iClk) begin
	if(~iRst_n)						rPT <= 128'd0; 	
	else if(iEn & iValid_Ptext)		rPT <= iPtext;		
	else 							rPT <= rPT;
end

/* Alignment is needed when ignorde MSB of Original Key, since the FIRST round use the FIRST generated key */
/*
//Align PT (after add_round_key) with key generation
always @(posedge iClk) begin
	if(~iRst_n)						rAlign <= 128'd0; 	
	else							rAlign <= wIn_r1;
end
*/

//Buffer Do signal with PT 
always @(posedge iClk) begin
	if(~iRst_n)						rDo <= 1'b0; 	
	else							rDo <= iValid_Key & iValid_Ptext; //Both valid signals indicate a pair of (State-Done)
end


/*---------------------KEY-----------------------*/

//Sample Key
always @(posedge iClk) begin
	if(~iRst_n)						rKey <= 256'd0; 	
	else if(iEn & iValid_Key)		rKey <= iKey;	
	else 							rKey <= rKey;
end

//Output
assign oCtext = wOut_r14;
assign oValid_Ctext = wDone14;


endmodule
