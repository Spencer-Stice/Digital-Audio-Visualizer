`timescale 1ns/1ns

module butterfly ( input [47:0] A, B, W,
						output [47:0] res1, res2);
						
	wire signed [23:0] AReal, AImag, BReal, BImag, WReal, WImag;
    assign AReal = A[47:24];
    assign AImag = A[23:0];
    assign BReal = B[47:24];
    assign BImag = B[23:0];
    assign WReal = W[47:24];
    assign WImag = W[23:0];

    //FOIL complex multiplication
    //XY = (a+jb)(c+jd) = (ac-bd) + j(bc+ad)

    wire signed [47:0] ac, bd, bc, ad;
    assign ac = WReal * BReal;
    assign bd = BImag * WImag;
    assign bc = BImag * WReal;
    assign ad = BReal * WImag;

    //Take only the important bits to truncate to 24 bits
    //Ignore MSB and lower 23 bits of both real and imaginary parts
    wire [23:0] acShift, bdShift, bcShift, adShift;
    assign acShift = ac[46:23];
    assign bdShift = bd[46:23];
    assign bcShift = bc[46:23];
    assign adShift = ad[46:23];

    wire [23:0] WBReal, WBImag;
    assign WBReal = acShift - bdShift;
    assign WBImag = bcShift + adShift;

    //Perform A+WB and A-WB, and assign outputs

    assign res1[47:24] = AReal + WBReal;
    assign res1[23:0] = AImag + WBImag;
    assign res2[47:24] = AReal - WBReal;
    assign res2[23:0] = AImag - WBImag;

endmodule 

module ThirtyTwoPointProcessor(clk, rst, new_t, 
	x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31,
	y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, y31, done);
	
	input clk, rst, new_t;
	input [17:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31;
	output [23:0] y0, y1, y2, y3, y4, y5, y6, y7, y8, y9, y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y28, y29, y30, y31;
	output done;
	
	reg [47:0] inA1, inA0, inB1, inB0, inC1, inC0, inD1, inD0, inE1, inE0, inF1, inF0, inG1, inG0, inH1, inH0, inI1, inI0, inJ1, inJ0, inK1, inK0,
        inL1, inL0, inM1, inM0, inN1, inN0, inO1, inO0, inP0, inP1, twidA, twidB, twidC, twidD, twidE, twidF, twidG, twidH, twidI, twidJ, twidK, twidL, twidM, 	
        twidN, twidO, twidP;
		  
    wire [47:0] outA1, outA0, outB1, outB0, outC1, outC0, outD1, outD0, outE1, outE0, outF1, outF0, outG1, outG0, outH1, outH0, outI1, outI0, 
        outJ1, outJ0, outK1, outK0, outL1, outL0, outM1, outM0, outN1, outN0, outO1, outO0, outP0, outP1;
	
	reg [23:0] A0, A1, B0, B1, C0, C1, D0, D1, E0, E1, F0, F1, G0, G1, H0, H1, I0, I1, J0, J1, K0, K1, L0, L1, M0, M1, N0, N1, O0, O1, P0, P1;

	
	butterfly unitA( .A(inA0), .B(inA1), .W(twidA), .res1(outA0), .res2(outA1) );
	butterfly unitB( .A(inB0), .B(inB1), .W(twidB), .res1(outB0), .res2(outB1) );
	butterfly unitC( .A(inC0), .B(inC1), .W(twidC), .res1(outC0), .res2(outC1) );
	butterfly unitD( .A(inD0), .B(inD1), .W(twidD), .res1(outD0), .res2(outD1) );
	butterfly unitE( .A(inE0), .B(inE1), .W(twidE), .res1(outE0), .res2(outE1) );
	butterfly unitF( .A(inF0), .B(inF1), .W(twidF), .res1(outF0), .res2(outF1) );
	butterfly unitG( .A(inG0), .B(inG1), .W(twidG), .res1(outG0), .res2(outG1) );
	butterfly unitH( .A(inH0), .B(inH1), .W(twidH), .res1(outH0), .res2(outH1) );
	butterfly unitI( .A(inI0), .B(inI1), .W(twidI), .res1(outI0), .res2(outI1) );
	butterfly unitJ( .A(inJ0), .B(inJ1), .W(twidJ), .res1(outJ0), .res2(outJ1) );
	butterfly unitK( .A(inK0), .B(inK1), .W(twidK), .res1(outK0), .res2(outK1) );
	butterfly unitL( .A(inL0), .B(inL1), .W(twidL), .res1(outL0), .res2(outL1) );
	butterfly unitM( .A(inM0), .B(inM1), .W(twidM), .res1(outM0), .res2(outM1) );
	butterfly unitN( .A(inN0), .B(inN1), .W(twidN), .res1(outN0), .res2(outN1) );
	butterfly unitO( .A(inO0), .B(inO1), .W(twidO), .res1(outO0), .res2(outO1) );
	butterfly unitP( .A(inP0), .B(inP1), .W(twidP), .res1(outP0), .res2(outP1) );
	
	reg isdone;
	reg [2:0] counter;
	
	`define COUNTER_MAX 5
	`define W32_0 48'b011111111111111111111111000000000000000000000000
   `define W32_1 48'b011111011000101001011110000110001111100010111000
   `define W32_2 48'b011101100100000110101110001100001111101111000101
   `define W32_3 48'b011010100110110110011000010001110001110011101100
   `define W32_4 48'b010110101000001001111001010110101000001001111001
   `define W32_5 48'b010001110001110011101100011010100110110110011000
   `define W32_6 48'b001100001111101111000101011101100100000110101110
   `define W32_7 48'b000110001111100010111000011111011000101001011110
   `define W32_8 48'b000000000000000000000000011111111111111111111111
   `define W32_9 48'b111001110000011101001000011111011000101001011110
   `define W32_10 48'b110011110000010000111011011101100100000110101110
   `define W32_11 48'b101110001110001100010100011010100110110110011000
   `define W32_12 48'b101001010111110110000111010110101000001001111001
   `define W32_13 48'b100101011001001001101000010001110001110011101100
   `define W32_14 48'b100010011011111001010010001100001111101111000101
   `define W32_15 48'b100000100111010110100010000110001111100010111000
	
	initial begin
		isdone = 1;
	end
	
	always @ (posedge clk) begin
		if (~rst) begin
			twidA = 0;
			twidB = 0;
			twidC = 0;
			twidD = 0;
			twidE = 0;
			twidF = 0;
			twidG = 0;
			twidH = 0;
			twidI = 0;
			twidJ = 0;
			twidK = 0;
			twidL = 0;
			twidM = 0;
			twidN = 0;
			twidO = 0;
			twidP = 0;
			
			inA0 = 0;
			inA1 = 0;
			inB0 = 0;
			inB1 = 0;
			inC0 = 0;
			inC1 = 0;
			inD0 = 0;
			inD1 = 0;
			inE0 = 0;
			inE1 = 0;
			inF0 = 0;
			inF1 = 0;
			inG0 = 0;
			inG1 = 0;
			inH0 = 0;
			inH1 = 0;
			inI0 = 0;
			inI1 = 0;
			inJ0 = 0;
			inJ1 = 0;
			inK0 = 0;
			inK1 = 0;
			inL0 = 0;
			inL1 = 0;
			inM0 = 0;
			inM1 = 0;
			inN0 = 0;
			inN1 = 0;
			inO0 = 0;
			inO1 = 0;
			inP0 = 0;
			inP1 = 0;
			
			isdone = 1;
			counter = `COUNTER_MAX;
		end else if (counter == `COUNTER_MAX && new_t) begin
			inA0 = { {6{x0[17]}}, x0, {24{1'b0}} };
			inA1 = { {6{x16[17]}}, x16, {24{1'b0}} };
			inB0 = { {6{x8[17]}}, x8, {24{1'b0}} };
			inB1 = { {6{x24[17]}}, x24, {24{1'b0}} };
			inC0 = { {6{x4[17]}}, x4, {24{1'b0}} };
			inC1 = { {6{x20[17]}}, x20, {24{1'b0}} };
			inD0 = { {6{x12[17]}}, x12, {24{1'b0}} };
			inD1 = { {6{x28[17]}}, x28, {24{1'b0}} };
			inE0 = { {6{x2[17]}}, x2, {24{1'b0}} };
			inE1 = { {6{x18[17]}}, x18, {24{1'b0}} };
			inF0 = { {6{x10[17]}}, x10, {24{1'b0}} };
			inF1 = { {6{x26[17]}}, x26, {24{1'b0}} };
			inG0 = { {6{x6[17]}}, x6, {24{1'b0}} };
			inG1 = { {6{x22[17]}}, x22, {24{1'b0}} };
			inH0 = { {6{x14[17]}}, x14, {24{1'b0}} };
			inH1 = { {6{x30[17]}}, x30, {24{1'b0}} };
			inI0 = { {6{x1[17]}}, x1, {24{1'b0}} };
			inI1 = { {6{x17[17]}}, x17, {24{1'b0}} };
			inJ0 = { {6{x9[17]}}, x9, {24{1'b0}} };
			inJ1 = { {6{x25[17]}}, x25, {24{1'b0}} };
			inK0 = { {6{x5[17]}}, x5, {24{1'b0}} };
			inK1 = { {6{x21[17]}}, x21, {24{1'b0}} };
			inL0 = { {6{x13[17]}}, x13, {24{1'b0}} };
			inL1 = { {6{x29[17]}}, x29, {24{1'b0}} };
			inM0 = { {6{x3[17]}}, x3, {24{1'b0}} };
			inM1 = { {6{x19[17]}}, x19, {24{1'b0}} };
			inN0 = { {6{x11[17]}}, x11, {24{1'b0}} }; 
			inN1 = { {6{x27[17]}}, x27, {24{1'b0}} }; 
			inO0 = { {6{x7[17]}}, x7, {24{1'b0}} };
			inO1 = { {6{x23[17]}}, x23, {24{1'b0}} };
			inP0 = { {6{x15[17]}}, x15, {24{1'b0}} }; // 15
			inP1 = { {6{x31[17]}}, x31, {24{1'b0}} }; // 31
			
			twidA = `W32_0;
			twidB = `W32_0;
			twidC = `W32_0;
			twidD = `W32_0;
			twidE = `W32_0;
			twidF = `W32_0;
			twidG = `W32_0;
			twidH = `W32_0;
			twidI = `W32_0;
			twidJ = `W32_0;
			twidK = `W32_0;
			twidL = `W32_0;
			twidM = `W32_0;
			twidN = `W32_0;
			twidO = `W32_0;
			twidP = `W32_0;
			
			counter = 0;
			isdone = 0;
		end else if (counter == 0) begin
			inA0 <= outA0;
			inA1 <= outB0;
			inB0 <= outA1;
			inB1 <= outB1;
			inC0 <= outC0;
			inC1 <= outD0;
			inD0 <= outC1;
			inD1 <= outD1;
			inE0 <= outE0;
			inE1 <= outF0;
			inF0 <= outE1;
			inF1 <= outF1;
			inG0 <= outG0;
			inG1 <= outH0;
			inH0 <= outG1;
			inH1 <= outH1;
			inI0 <= outI0;
			inI1 <= outJ0;
			inJ0 <= outI1;
			inJ1 <= outJ1;
			inK0 <= outK0;
			inK1 <= outL0;
			inL0 <= outK1;
			inL1 <= outL1;
			inM0 <= outM0;
			inM1 <= outN0;
			inN0 <= outM1;
			inN1 <= outN1;
			inO0 <= outO0;
			inO1 <= outP0;
			inP0 <= outO1; // Me: outO1; // S: outP1
			inP1 <= outP1;
		
			twidA = `W32_0;
			twidB = `W32_8;
			twidC = `W32_0;
			twidD = `W32_8;
			twidE = `W32_0;
			twidF = `W32_8;
			twidG = `W32_0;
			twidH = `W32_8;
			twidI = `W32_0;
			twidJ = `W32_8;
			twidK = `W32_0;
			twidL = `W32_8;
			twidM = `W32_0;
			twidN = `W32_8;
			twidO = `W32_0;
			twidP = `W32_8;
			
			counter = 1;
			
		end else if (counter == 1) begin
		
			inA0 <= outA0;
			inA1 <= outC0;
			inB0 <= outB0;
			inB1 <= outD0;
			inC0 <= outA1;
			inC1 <= outC1;
			inD0 <= outB1;
			inD1 <= outD1;
			inE0 <= outE0;
			inE1 <= outG0;
			inF0 <= outF0;
			inF1 <= outH0;
			inG0 <= outE1;
			inG1 <= outG1;
			inH0 <= outF1;
			inH1 <= outH1;
			inI0 <= outI0;
			inI1 <= outK0;
			inJ0 <= outJ0;
			inJ1 <= outL0;
			inK0 <= outI1;
			inK1 <= outK1; // Me: outK1; S: inK1 <= outJ1;	
			inL0 <= outJ1; // Me: outJ1; S: inL0 <= outK1;
			inL1 <= outL1;
			inM0 <= outM0;
			inM1 <= outO0;
			inN0 <= outN0;
			inN1 <= outP0;
			inO0 <= outM1;
			inO1 <= outO1;
			inP0 <= outN1;
			inP1 <= outP1;
			
			twidA = `W32_0;
			twidB = `W32_4;
			twidC = `W32_8;
			twidD = `W32_12;
			twidE = `W32_0;
			twidF = `W32_4;
			twidG = `W32_8;
			twidH = `W32_12;
			twidI = `W32_0;
			twidJ = `W32_4;
			twidK = `W32_8;
			twidL = `W32_12;
			twidM = `W32_0;
			twidN = `W32_4;
			twidO = `W32_8;
			twidP = `W32_12;
			
			counter = 2;
		
		end else if (counter == 2) begin
		
			inA0 <= outA0;
			inA1 <= outE0;
			inB0 <= outB0;
			inB1 <= outF0;
			inC0 <= outC0;
			inC1 <= outG0;
			inD0 <= outD0;
			inD1 <= outH0;
			inE0 <= outA1;
			inE1 <= outE1;
			inF0 <= outB1;
			inF1 <= outF1;
			inG0 <= outC1;
			inG1 <= outG1;
			inH0 <= outD1;
			inH1 <= outH1;			
			inI0 <= outI0;
			inI1 <= outM0;
			inJ0 <= outJ0;
			inJ1 <= outN0;
			inK0 <= outK0;
			inK1 <= outO0;
			inL0 <= outL0;
			inL1 <= outP0;
			inM0 <= outI1;
			inM1 <= outM1;
			inN0 <= outJ1;
			inN1 <= outN1;
			inO0 <= outK1;
			inO1 <= outO1;
			inP0 <= outL1;
			inP1 <= outP1;
			
			twidA = `W32_0;
			twidB = `W32_2;
			twidC = `W32_4;
			twidD = `W32_6;
			twidE = `W32_8;
			twidF = `W32_10;
			twidG = `W32_12;
			twidH = `W32_14;
			twidI = `W32_0;
			twidJ = `W32_2;
			twidK = `W32_4;
			twidL = `W32_6;
			twidM = `W32_8;
			twidN = `W32_10;
			twidO = `W32_12;
			twidP = `W32_14;	
			
			counter = 3;
		
		end else if (counter == 3) begin
		
			inA0 <= outA0;
			inA1 <= outI0;
			inB0 <= outB0;
			inB1 <= outJ0;
			inC0 <= outC0;
			inC1 <= outK0;
			inD0 <= outD0;
			inD1 <= outL0;
			inE0 <= outE0;
			inE1 <= outM0;
			inF0 <= outF0;
			inF1 <= outN0;
			inG0 <= outG0;
			inG1 <= outO0;
			inH0 <= outH0;
			inH1 <= outP0;
			inI0 <= outA1;
			inI1 <= outI1;
			inJ0 <= outB1;
			inJ1 <= outJ1;
			inK0 <= outC1;
			inK1 <= outK1;
			inL0 <= outD1;
			inL1 <= outL1;
			inM0 <= outE1;
			inM1 <= outM1;
			inN0 <= outF1;
			inN1 <= outN1;
			inO0 <= outG1;
			inO1 <= outO1;
			inP0 <= outH1;
			inP1 <= outP1;
			
			twidA = `W32_0;
			twidB = `W32_1;
			twidC = `W32_2;
			twidD = `W32_3;
			twidE = `W32_4;
			twidF = `W32_5;
			twidG = `W32_6;
			twidH = `W32_7;
			twidI = `W32_8;
			twidJ = `W32_9;
			twidK = `W32_10;
			twidL = `W32_11;
			twidM = `W32_12;
			twidN = `W32_13;
			twidO = `W32_14;
			twidP = `W32_15;	
			
		
			counter = 4;
			//isdone = 1;
		end else if (counter == 4) begin
			A0 <= outA0[47:24];
			A1 <= outA1[47:24];
			B0 <= outB0[47:24];
			B1 <= outB1[47:24];
			C0 <= outC0[47:24];
			C1 <= outC1[47:24];
			D0 <= outD0[47:24];
			D1 <= outD1[47:24];
			E0 <= outE0[47:24];
			E1 <= outE1[47:24];
			F0 <= outF0[47:24];
			F1 <= outF1[47:24];
			G0 <= outG0[47:24];
			G1 <= outG1[47:24];
			H0 <= outH0[47:24];
			H1 <= outH1[47:24];
			I0 <= outI0[47:24];
			I1 <= outI1[47:24];
			J0 <= outJ0[47:24];
			J1 <= outJ1[47:24];
			K0 <= outK0[47:24];
			K1 <= outK1[47:24];
			L0 <= outL0[47:24];
			L1 <= outL1[47:24];
			M0 <= outM0[47:24];
			M1 <= outM1[47:24];
			N0 <= outN0[47:24];
			N1 <= outN1[47:24];
			O0 <= outO0[47:24];
			O1 <= outO1[47:24];
			P0 <= outP0[47:24];
			P1 <= outP1[47:24];
			
			counter = 5;
			isdone = 1;
		end
		
	end
	/*
	assign y0 = outA0[47:24];
	assign y1 = outB0[47:24];
	assign y2 = outC0[47:24];
	assign y3 = outD0[47:24];
	assign y4 = outE0[47:24];
	assign y5 = outF0[47:24];
	assign y6 = outG0[47:24];
	assign y7 = outH0[47:24];
	assign y8 = outI0[47:24];
	assign y9 = outJ0[47:24];
	assign y10 = outK0[47:24];
	assign y11 = outL0[47:24];
	assign y12 = outM0[47:24];
	assign y13 = outN0[47:24];
	assign y14 = outO0[47:24];
	assign y15 = outP0[47:24];
	
	assign y16 = outA1[47:24];
	assign y17 = outB1[47:24];
	assign y18 = outC1[47:24];
	assign y19 = outD1[47:24];
	assign y20 = outE1[47:24];
	assign y21 = outF1[47:24];
	assign y22 = outG1[47:24];
	assign y23 = outH1[47:24];
	assign y24 = outI1[47:24];
	assign y25 = outJ1[47:24];
	assign y26 = outK1[47:24];
	assign y27 = outL1[47:24];
	assign y28 = outM1[47:24];
	assign y29 = outN1[47:24];
	assign y30 = outO1[47:24];
	assign y31 = outP1[47:24];*/
	
	assign y0 = A0;
	assign y1 = B0;
	assign y2 = C0;
	assign y3 = D0;
	assign y4 = E0;
	assign y5 = F0;
	assign y6 = G0;
	assign y7 = H0;
	assign y8 = I0;
	assign y9 = J0;
	assign y10 = K0;
	assign y11 = L0;
	assign y12 = M0;
	assign y13 = N0;
	assign y14 = O0;
	assign y15 = P0;
	
	assign y16 = A1;
	assign y17 = B1;
	assign y18 = C1;
	assign y19 = D1;
	assign y20 = E1;
	assign y21 = F1;
	assign y22 = G1;
	assign y23 = H1;
	assign y24 = I1;
	assign y25 = J1;
	assign y26 = K1;
	assign y27 = L1;
	assign y28 = M1;
	assign y29 = N1;
	assign y30 = O1;
	assign y31 = P1;

	assign done = isdone;
									
endmodule
