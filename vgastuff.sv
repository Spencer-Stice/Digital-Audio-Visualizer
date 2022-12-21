`timescale 1ns/1ns

module clk_div #(parameter count = 10) (in, out, reset);
	
	input in;
	input reset;
	output reg out;
	reg [$clog2(count) - 1:0] counter; //= 0;
	
	always @ (posedge in) begin
		if (reset) begin 
			counter <= 0;
			out <= 0;
		end
		else begin
		if (counter == count - 1) begin
			counter <= 0;
			out <= ~out;
		end
		else begin
			counter <= counter + 1;
		end
		end
	end
	
endmodule

module vga640x480(
		input wire i_clk,
           // base clock
		//input wire i_rst,
		output wire o_hs,           // horizontal sync
		output wire o_vs,           // vertical sync
		output wire o_blanking,     // blanking
		output wire [10:0] o_x,      // current pixel x position
		output wire [10:0] o_y       // current pixel y position
	);

   // VGA timings https://timetoexplore.net/blog/video-timings-vga-720p-1080p
	localparam HS_STA = 639 + 16;              // horizontal sync start
   localparam HS_END = 639 + 16 + 96;         // horizontal sync end
   localparam HA_END = 639;    // horizontal active pixel end
   localparam VS_STA = 479 + 10;        // vertical sync start
   localparam VS_END = 479 + 10 + 2;    // vertical sync end
   localparam VA_END = 479;             // vertical active pixel end
   localparam LINE   = 799;             // complete line (pixels)
   localparam SCREEN = 524;             // complete screen (lines)

   reg [10:0] h_count;  // line position
   reg [10:0] v_count;  // screen position
	
	initial begin
		h_count = 0;
		v_count = 0;
	end

   // generate sync signals (active low for 640x480)
   assign o_hs = ~((h_count >= HS_STA) & (h_count < HS_END));
   assign o_vs = ~((v_count >= VS_STA) & (v_count < VS_END));

   // keep x and y bound within the active pixels
   assign o_x = h_count;
   assign o_y = v_count;
	
	// blanking: high within the blanking period
   assign o_blanking = ((h_count > HA_END) | (v_count > VA_END));

   always @ (posedge i_clk) begin
			if (h_count == LINE)  // end of line
			begin
				h_count <= 0;
            v_count <= (v_count == SCREEN) ? 0 : v_count + 1;
         end
         else begin
            h_count <= h_count + 1;
			end
	end
endmodule

module data 
(
	input clk, hblank, vblank, 
	input [10:0] horizontal_count, vertical_count, 
	input signed [23:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31,
	output reg [3:0] r, output reg [3:0] g, output reg [3:0] b
);

   //, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31,
	
	wire signed [23:0] s_d1, s_d2, s_d3, s_d4, s_d5, s_d6, s_d7, s_d8, s_d9, s_d10, s_d11, s_d12, s_d13, s_d14, s_d15, s_d16, s_d17, s_d18, s_d19, s_d20, s_d21, s_d22, s_d23, s_d24, s_d25, s_d26, s_d27, s_d28, s_d29, s_d30, s_d31;    
	//assign s_d0 = (d0*-480)/16384 + 480;
	assign s_d1 = (d1*-480)/16384 + 480;
	assign s_d2 = (d2*-480)/16384 + 480;
	assign s_d3 = (d3*-480)/16384 + 480;
	assign s_d4 = (d4*-480)/16384 + 480;
	assign s_d5 = (d5*-480)/16384 + 480;
	assign s_d6 = (d6*-480)/16384 + 480;
	assign s_d7 = (d7*-480)/16384 + 480;
	assign s_d8 = (d8*-480)/16384 + 480;
	assign s_d9 = (d9*-480)/16384 + 480;
	assign s_d10 = (d10*-480)/16384 + 480;
	assign s_d11 = (d11*-480)/16384 + 480;
	assign s_d12 = (d12*-480)/16384 + 480;
	assign s_d13 = (d13*-480)/16384 + 480;
	assign s_d14 = (d14*-480)/16384 + 480;
	assign s_d15 = (d15*-480)/16384 + 480;
	assign s_d16 = (d16*-480)/16384 + 480;
	assign s_d17 = (d17*-480)/16384 + 480;
	assign s_d18 = (d18*-480)/16384 + 480;
	assign s_d19 = (d19*-480)/16384 + 480;
	assign s_d20 = (d20*-480)/16384 + 480;
	assign s_d21 = (d21*-480)/16384 + 480;
	assign s_d22 = (d22*-480)/16384 + 480;
	assign s_d23 = (d23*-480)/16384 + 480;
	assign s_d24 = (d24*-480)/16384 + 480;
	assign s_d25 = (d25*-480)/16384 + 480;
	assign s_d26 = (d26*-480)/16384 + 480;
	assign s_d27 = (d27*-480)/16384 + 480;
	assign s_d28 = (d28*-480)/16384 + 480;
	assign s_d29 = (d29*-480)/16384 + 480;
	assign s_d30 = (d30*-480)/16384 + 480;
	assign s_d31 = (d31*-480)/16384 + 480;
	
	
	//assign square = ((horizontal_count > 100) && (vertical_count > 100) && (horizontal_count < 200) && (vertical_count < 200)) ? 1 : 0;
	
	wire b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30;
	assign b0 = (horizontal_count < 20) && (vertical_count > s_d1);
	assign b1 = (horizontal_count > 21) && (horizontal_count < 41) && (vertical_count > s_d2);
	assign b2 = (horizontal_count > 42) && (horizontal_count < 62) && (vertical_count > s_d3);
	assign b3 = (horizontal_count > 63) && (horizontal_count < 83) && (vertical_count > s_d4);
	assign b4 = (horizontal_count > 84) && (horizontal_count < 104) && (vertical_count > s_d5);
	assign b5 = (horizontal_count > 105) && (horizontal_count < 125) && (vertical_count > s_d6);
	assign b6 = (horizontal_count > 126) && (horizontal_count < 146) && (vertical_count > s_d7);
	assign b7 = (horizontal_count > 147) && (horizontal_count < 167) && (vertical_count > s_d8);
	assign b8 = (horizontal_count > 168) && (horizontal_count < 188) && (vertical_count > s_d9);
	assign b9 = (horizontal_count > 189) && (horizontal_count < 209) && (vertical_count > s_d10);
	assign b10 = (horizontal_count > 210) && (horizontal_count < 230) && (vertical_count > s_d11);
	assign b11 = (horizontal_count > 231) && (horizontal_count < 251) && (vertical_count > s_d12);
	assign b12 = (horizontal_count > 252) && (horizontal_count < 271) && (vertical_count > s_d13);
	assign b13 = (horizontal_count > 272) && (horizontal_count < 291) && (vertical_count > s_d14);
	assign b14 = (horizontal_count > 292) && (horizontal_count < 311) && (vertical_count > s_d15);
	assign b15 = (horizontal_count > 312) && (horizontal_count < 331) && (vertical_count > s_d16);
	assign b16 = (horizontal_count > 332) && (horizontal_count < 351) && (vertical_count > s_d17);
	assign b17 = (horizontal_count > 352) && (horizontal_count < 371) && (vertical_count > s_d18);
	assign b18 = (horizontal_count > 372) && (horizontal_count < 391) && (vertical_count > s_d19);
	assign b19 = (horizontal_count > 392) && (horizontal_count < 411) && (vertical_count > s_d20);
	assign b20 = (horizontal_count > 412) && (horizontal_count < 432) && (vertical_count > s_d21);
	assign b21 = (horizontal_count > 433) && (horizontal_count < 453) && (vertical_count > s_d22);
	assign b22 = (horizontal_count > 454) && (horizontal_count < 474) && (vertical_count > s_d23);
	assign b23 = (horizontal_count > 475) && (horizontal_count < 495) && (vertical_count > s_d24);
	assign b24 = (horizontal_count > 496) && (horizontal_count < 516) && (vertical_count > s_d25);
	assign b25 = (horizontal_count > 517) && (horizontal_count < 537) && (vertical_count > s_d26);
	assign b26 = (horizontal_count > 538) && (horizontal_count < 558) && (vertical_count > s_d27);
	assign b27 = (horizontal_count > 559) && (horizontal_count < 579) && (vertical_count > s_d28);
	assign b28 = (horizontal_count > 580) && (horizontal_count < 600) && (vertical_count > s_d29);
	assign b29 = (horizontal_count > 601) && (horizontal_count < 620) && (vertical_count > s_d30);
	assign b30 = (horizontal_count > 620) && (horizontal_count < 640) && (vertical_count > s_d31);
	
	always @ (posedge clk) begin
		// If we're blanking, set all colors to black
		r = 0;
		g = 0;
		b = {4{b0 || b1 || b2 || b3 || b4 || b5 || b6 || b7 || b8 || b9 || b10 || b11 || b12 || b13 || b14 || b15 || b16 || b17 || b18 || b19 || b20 || b21 || b22 || b23 || b24 || b25 || b26 || b27 || b28 || b29 || b30}};
		/*if (~hblank || ~vblank) begin
			r = 0;
			g = 0;
			b = 0;
		end
		else if (horizontal_count > 100 && vertical_count > 100 && horizontal_count < 200 && vertical_count < 200) begin
			r = 15;
			g = 15;
			b = 15;
		end*/
	end

endmodule

module VGA_generator
(
	input clk,  done,
	input [23:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31,
	output vsync, hsync,
	output [3:0] r, g, b
);
	
	wire blanking;
	wire [10:0] horizontal_count, vertical_count;
	
	reg signed [23:0] in0r, in1r, in2r, in3r, in4r, in5r, in6r, in7r, in8r, in9r, in10r, in11r, in12r, in13r, in14r, in15r, in16r, in17r, in18r, 
		in19r, in20r, in21r, in22r, in23r, in24r, in25r, in26r, in27r, in28r, in29r, in30r, in31r;
	 
	vga640x480 myScreen(.i_clk(clk), .o_hs(hsync), .o_vs(vsync), .o_blanking(blanking), .o_x(horizontal_count), .o_y(vertical_count));
	
	//.i_rst(rst), 
	
	always @ (posedge clk) begin
		if(blanking == 0 && done == 1) begin
			in0r <= in0;
			in1r <= in1;
			in2r <= in2;
			in3r <= in3;
			in4r <= in4;
			in5r <= in5;
			in6r <= in6;
			in7r <= in7;
			in8r <= in8;
			in9r <= in9;
			in10r <= in10;
			in11r <= in11;
			in12r <= in12;
			in13r <= in13;
			in14r <= in14;
			in15r <= in15;
			in16r <= in16;
			in17r <= in17;
			in18r <= in18;
			in19r <= in19;
			in20r <= in20;
			in21r <= in21;
			in22r <= in22;
			in23r <= in23;
			in24r <= in24;
			in25r <= in25;
			in26r <= in26;
			in27r <= in27;
			in28r <= in28;
			in29r <= in29;
			in30r <= in30;
			in31r <= in31;
			end
	end
	
	wire signed [23:0] in0p, in1p, in2p, in3p, in4p, in5p, in6p, in7p, in8p, in9p, in10p, in11p, in12p, in13p, in14p, in15p, in16p, in17p, in18p, in19p, in20p, in21p, in22p, in23p, in24p, in25p, in26p, in27p, in28p, in29p, in30p, in31p;
	
	assign in0p = in0r > 1'b0 ? in0r : 1'b0;
	assign in1p = in1r > 1'b0 ? in1r : 1'b0;
	assign in2p = in2r > 1'b0 ? in2r : 1'b0;
	assign in3p = in3r > 1'b0 ? in3r : 1'b0;
	assign in4p = in4r > 1'b0 ? in4r : 1'b0;
	assign in5p = in5r > 1'b0 ? in5r : 1'b0;
	assign in6p = in6r > 1'b0 ? in6r : 1'b0;
	assign in7p = in7r > 1'b0 ? in7r : 1'b0;
	assign in8p = in8r > 1'b0 ? in8r : 1'b0;
	assign in9p = in9r > 1'b0 ? in9r : 1'b0;
	assign in10p = in10r > 1'b0 ? in10r : 1'b0;
	assign in11p = in11r > 1'b0 ? in11r : 1'b0;
	assign in12p = in12r > 1'b0 ? in12r : 1'b0;
	assign in13p = in13r > 1'b0 ? in13r : 1'b0;
	assign in14p = in14r > 1'b0 ? in14r : 1'b0;
	assign in15p = in15r > 1'b0 ? in15r : 1'b0;
	assign in16p = in16r > 1'b0 ? in16r : 1'b0;
	assign in17p = in17r > 1'b0 ? in17r : 1'b0;
	assign in18p = in18r > 1'b0 ? in18r : 1'b0;
	assign in19p = in19r > 1'b0 ? in19r : 1'b0;
	assign in20p = in20r > 1'b0 ? in20r : 1'b0;
	assign in21p = in21r > 1'b0 ? in21r : 1'b0;
	assign in22p = in22r > 1'b0 ? in22r : 1'b0;
	assign in23p = in23r > 1'b0 ? in23r : 1'b0;
	assign in24p = in24r > 1'b0 ? in24r : 1'b0;
	assign in25p = in25r > 1'b0 ? in25r : 1'b0;
	assign in26p = in26r > 1'b0 ? in26r : 1'b0;
	assign in27p = in27r > 1'b0 ? in27r : 1'b0;
	assign in28p = in28r > 1'b0 ? in28r : 1'b0;
	assign in29p = in29r > 1'b0 ? in29r : 1'b0;
	assign in30p = in30r > 1'b0 ? in30r : 1'b0;
	assign in31p = in31r > 1'b0 ? in31r : 1'b0;
	
	/*assign in0p = 5000;
	assign in1p = 6000;
	assign in2p = 7000;
	assign in3p = 8000;
	assign in4p = 9000;
	assign in5p = 10000;
	assign in6p = 9000;
	assign in7p = 8000;
	assign in8p = 7000;
	assign in9p = 6000;
	assign in10p = 5000;
	assign in11p = 6000;
	assign in12p = 7000;
	assign in13p = 8000;
	assign in14p = 9000;
	assign in15p = 10000;
	assign in16p = 9000;
	assign in17p = 8000;
	assign in18p = 7000;
	assign in19p = 6000;
	assign in20p = 5000;
	assign in21p = 6000;
	assign in22p = 7000;
	assign in23p = 8000;
	assign in24p = 9000;
	assign in25p = 10000;
	assign in26p = 9000;
	assign in27p = 8000;
	assign in28p = 7000;
	assign in29p = 6000;
	assign in30p = 5000;
	assign in31p = 6000;*/
	
	
	// DONE: Instantiate data module as defined above
   //data dataModule(.clk(clk), .hblank(hsync), .vblank(vsync), .horizontal_count(horizontal_count), .vertical_count(vertical_count), .r(r), .g(g), .b(b));
	data data(.clk(clk), .hblank(hsync), .vblank(vsync), .horizontal_count(horizontal_count), 
		.vertical_count(vertical_count), .d0(in0p), .d1(in1p), .d2(in2p), .d3(in3p), .d4(in4p), .d5(in5p), .d6(in6p), .d7(in7p), .d8(in8p), .d9(in9p),
			.d10(in10p), .d11(in11p), .d12(in12p), .d13(in13p), .d14(in14p), .d15(in15p), .d16(in16p), .d17(in17p), .d18(in18p), .d19(in19p), 
			.d20(in20p), .d21(in21p), .d22(in22p), .d23(in23p), .d24(in24p), .d25(in25p), .d26(in26p), .d27(in27p), .d28(in28p), .d29(in29p),
			.d30(in30p), .d31(in31p), .r(r), .g(g), .b(b) );
endmodule

   
	
	/*data data(.clk(clk), .hblank(hsync), .vblank(vsync), .horizontal_count(horizontal_count), 
	.vertical_count(vertical_count), .d0(if0), .d1(if1), .d2(if2), .d3(if3),.d4(if4), .d5(if5),.d6(if6), 
	.d7(if7),.d8(if8), .d9(if9), .d10(if10), .d11(if11), .d12(if12), .d13(if13),.d14(if14), .d15(if15),.d16(if16), 
	.d17(if17),.d18(if18), .d19(if19), .d20(if20), .d21(if21), .d22(if22), .d23(if23),.d24(if24), .d25(if25),.d26(if26), 
	.d27(if27),.d28(if28), .d29(if29), .d30(if30), .d31(if31),
   .r(r), .g(g), .b(b) );*/
	
	/*data data(.clk(clk), .hblank(hsync), .vblank(vsync), .horizontal_count(horizontal_count), 
		.vertical_count(vertical_count), .d0(if0), .d1(if1), .d2(if2), .d3(if3), .d4(if4), .d5(if5), .d6(if6), .d7(if7), .r(r), .g(g), .b(b) );*/
