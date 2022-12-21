`timescale 1ns/1ns

module top (
	input clk, reset, DOUT,
	output vsync, hsync, LRCLK, BCLK,
	output [3:0] r, g, b
);

	wire vga_clk;
	wire fft_clk;
	//reg done = 1;
	//reg new_t = 1;
	wire done;
	wire new_t;
	
	clk_div #(1) c (.in(clk), .out(vga_clk), .reset(~reset));
	
	clk_div #(200) cd (.in(clk), .out(fft_clk), .reset(~reset));
	
	reg [17:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27, x28, x29, x30, x31;
	
	reg [23:0] f0, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f26, f27, f28, f29, f30, f31;
	
	/*initial begin
		  x0 = 690;
		  x1 = 4200;
        x2 = 6969;
        x3 = 4242;
        x4 = 1337;
        x5 = 922;
        x6 = 5896;
        x7 = 1028;
		  x8 = 4444;
        x9 = 2222;
        x10 = 2654;
        x11 = 3158;
        x12 = 777;
        x13 = 215;
        x14 = 1543;
        x15 = 2904;
        x16 = 2304;
        x17 = 1302;
        x18 = 1337;
        x19 = 3498;
        x20 = 3308;
        x21 = 2195;
        x22 = 1234;
        x23 = 1592;
        x24 = 1000;
        x25 = 1492;
        x26 = 1888;
        x27 = 888;
        x28 = 927;
        x29 = 2000;
        x30 = 2002;
        x31 = 1632;

	end*/
	
	mic_translator(.clk(fft_clk), .reset(reset), .DOUT(DOUT), .LRCLK(LRCLK), .BCLK(BCLK), .new_t(new_t),
							 .t0(x0), .t1(x1), .t2(x2), .t3(x3), .t4(x4), .t5(x5), .t6(x6), .t7(x7), .t8(x8), .t9(x9), .t10(x10), .t11(x11), .t12(x12), 
							 .t13(x13), .t14(x14), .t15(x15), .t16(x16), .t17(x17), .t18(x18), .t19(x19), .t20(x20), .t21(x21), .t22(x22), .t23(x23), 
							 .t24(x24), .t25(x25), .t26(x26), .t27(x27), .t28(x28), .t29(x29), .t30(x30), .t31(x31) );
	
	ThirtyTwoPointProcessor f( .clk(fft_clk), .rst(reset), .new_t(new_t), .x0(x0), .x1(x1), .x2(x2), .x3(x3), .x4(x4), .x5(x5), .x6(x6), .x7(x7), .x8(x8), 
        .x9(x9), .x10(x10), .x11(x11), .x12(x12), .x13(x13), .x14(x14), .x15(x15), .x16(x16), .x17(x17), .x18(x18), .x19(x19), .x20(x20), .x21(x21),
        .x22(x22), .x23(x23), .x24(x24), .x25(x25), .x26(x26), .x27(x27), .x28(x28), .x29(x29), .x30(x30), .x31(x31), .y0(f0), .y1(f1), .y2(f2), 
        .y3(f3), .y4(f4), .y5(f5), .y6(f6), .y7(f7), .y8(f8), .y9(f9), .y10(f10), .y11(f11), .y12(f12), .y13(f13), .y14(f14), .y15(f15), .y16(f16),
        .y17(f17), .y18(f18), .y19(f19), .y20(f20), .y21(f21), .y22(f22), .y23(f23), .y24(f24), .y25(f25), .y26(f26), .y27(f27), .y28(f28), .y29(f29),
        .y30(f30), .y31(f31), .done(done) );
	
	/*initial begin
		f0 = 1000;
		f1 = 2000;
		f2 = 3000;
		f3 = 4000;
		f4 = 5000;
		f5 = 6000;
		f6 = 7000;
		f7 = 8000;
		f8 = 9000;
		f9 = 10000;
		f10 = 1000;
		f11 = 2000;
		f12 = 3000;
		f13 = 4000;
		f14 = 5000;
		f15 = 6000;
		f16 = 7000;
		f17 = 8000;
		f18 = 9000;
		f19 = 10000;
		f20 = 1000;
		f21 = 2000;
		f22 = 3000;
		f23 = 4000;
		f24 = 5000;
		f25 = 6000;
		f26 = -7000;
		f27 = 8000;
		f28 = 9000;
		f29 = 10000;
		f30 = 1000;
		f31 = 2000;
	end*/
	
		
	VGA_generator v (.clk(vga_clk), .done(done), .in0(f0), .in1(f1), .in2(f2), .in3(f3), .in4(f4), .in5(f5), .in6(f6), .in7(f7), .in8(f8), .in9(f9),
		.in10(f10), .in11(f11), .in12(f12), .in13(f13), .in14(f14), .in15(f15), .in16(f16), .in17(f17), .in18(f18), .in19(f19), .in20(f20), .in21(f21), .in22(f22),
		.in23(f23), .in24(f24), .in25(f25), .in26(f26), .in27(f27), .in28(f28), .in29(f29), .in30(f30), .in31(f31), .vsync(vsync), .hsync(hsync), .r(r), .g(g), .b(b));


endmodule