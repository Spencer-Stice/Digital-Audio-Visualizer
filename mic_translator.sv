`define _NUM_DATA_BITS 31
`define _NUM_SAMPLE_BITS 18
`define _CALIBRATION {13'd226, 5'd0}

module mic_translator(input clk, input reset, input DOUT, output reg LRCLK, output reg BCLK, output reg new_t,
							 output reg [17:0] t0, output reg [17:0] t1, output reg [17:0] t2, output reg [17:0] t3, 
							 output reg [17:0] t4, output reg [17:0] t5, output reg [17:0] t6, output reg [17:0] t7, 
							 output reg [17:0] t8, output reg [17:0] t9, output reg [17:0] t10, output reg [17:0] t11, 
							 output reg [17:0] t12, output reg [17:0] t13, output reg [17:0] t14, output reg [17:0] t15,
							 output reg [17:0] t16, output reg [17:0] t17, output reg [17:0] t18, output reg [17:0] t19,
							 output reg [17:0] t20, output reg [17:0] t21, output reg [17:0] t22, output reg [17:0] t23, 
							 output reg [17:0] t24, output reg [17:0] t25, output reg [17:0] t26, output reg [17:0] t27, 
							 output reg [17:0] t28, output reg [17:0] t29, output reg [17:0] t30, output reg [17:0] t31	 
							 );
	
	reg [17:0] data_buffer;
	reg [6:0] data_counter;
	reg [31:0] bit_cnt;
	reg [17:0] calibrated_data_buffer;
	
	assign calibrated_data_buffer = data_buffer + `_CALIBRATION;
	
	always @ (clk) begin
		if (reset == 1'b0) begin
			BCLK <= 1'b1;
		end
		else begin
			BCLK <= clk;
		end
	end
	
	always @ (negedge clk) begin
		if (reset == 1'b0) begin
			LRCLK <= 1'b1;
			bit_cnt <= 32'b0;
		end
		else if (bit_cnt < `_NUM_DATA_BITS) begin
			LRCLK <= LRCLK;
			bit_cnt <= bit_cnt + 32'b1;
		end
		else begin
			LRCLK <= ~LRCLK;
			bit_cnt <= 32'b0;
		end
	end
	
	always @ (posedge clk) begin
		if (reset == 1'b0) begin
			data_counter <= 7'b0;
			data_buffer <= 18'b0;
			new_t <= 1'b0;
			t31 <= 18'b0;
			t30 <= 18'b0;
			t29 <= 18'b0;
			t28 <= 18'b0;
			t27 <= 18'b0;
			t26 <= 18'b0;
			t25 <= 18'b0;
			t24 <= 18'b0;
			t23 <= 18'b0;
			t22 <= 18'b0;
			t21 <= 18'b0;
			t20 <= 18'b0;
			t19 <= 18'b0;
			t18 <= 18'b0;
			t17 <= 18'b0;
			t16 <= 18'b0;
			t15 <= 18'b0;
			t14 <= 18'b0;
			t13 <= 18'b0;
			t12 <= 18'b0;
			t11 <= 18'b0;
			t10 <= 18'b0;
			t9 <= 18'b0;
			t8 <= 18'b0;
			t7 <= 18'b0;
			t6 <= 18'b0;
			t5 <= 18'b0;
			t4 <= 18'b0;
			t3 <= 18'b0;
			t2 <= 18'b0;
			t1 <= 18'b0;
			t0 <= 18'b0;
		end
		else if (data_counter < `_NUM_SAMPLE_BITS) begin
			data_counter <= data_counter + 6'b1;
			data_buffer <= {data_buffer[16:0], DOUT};
			new_t <= 1'b0;
			t31 <= t31;
			t30 <= t30;
			t29 <= t29;
			t28 <= t28;
			t27 <= t27;
			t26 <= t26;
			t25 <= t25;
			t24 <= t24;
			t23 <= t23;
			t22 <= t22;
			t21 <= t21;
			t20 <= t20;
			t19 <= t19;
			t18 <= t18;
			t17 <= t17;
			t16 <= t16;
			t15 <= t15;
			t14 <= t14;
			t13 <= t13;
			t12 <= t12;
			t11 <= t11;
			t10 <= t10;
			t9 <= t9;
			t8 <= t8;
			t7 <= t7;
			t6 <= t6;
			t5 <= t5;
			t4 <= t4;
			t3 <= t3;
			t2 <= t2;
			t1 <= t1;
			t0 <= t0;
		end
		else if (data_counter == `_NUM_SAMPLE_BITS) begin
			data_counter <= data_counter + 6'b1;
			data_buffer <= 17'b0;
			if (LRCLK == 0) begin
				new_t <= 1'b1;
				t31 <= t30;
				t30 <= t29;
				t29 <= t28;
				t28 <= t27;
				t27 <= t26;
				t26 <= t25;
				t25 <= t24;
				t24 <= t23;
				t23 <= t22;
				t22 <= t21;
				t21 <= t20;
				t20 <= t19;
				t19 <= t18;
				t18 <= t17;
				t17 <= t16;
				t16 <= t15;
				t15 <= t14;
				t14 <= t13;
				t13 <= t12;
				t12 <= t11;
				t11 <= t10;
				t10 <= t9;
				t9 <= t8;
				t8 <= t7;
				t7 <= t6;
				t6 <= t5;
				t5 <= t4;
				t4 <= t3;
				t3 <= t2;
				t2 <= t1;
				t1 <= t0;
				t0 <= calibrated_data_buffer; //FFT Processor takes 18 bit 2's complement //use calibrated to remove base offset
			end
			else begin
				new_t <= 1'b0;
				t31 <= t31;
				t30 <= t30;
				t29 <= t29;
				t28 <= t28;
				t27 <= t27;
				t26 <= t26;
				t25 <= t25;
				t24 <= t24;
				t23 <= t23;
				t22 <= t22;
				t21 <= t21;
				t20 <= t20;
				t19 <= t19;
				t18 <= t18;
				t17 <= t17;
				t16 <= t16;
				t15 <= t15;
				t14 <= t14;
				t13 <= t13;
				t12 <= t12;
				t11 <= t11;
				t10 <= t10;
				t9 <= t9;
				t8 <= t8;
				t7 <= t7;
				t6 <= t6;
				t5 <= t5;
				t4 <= t4;
				t3 <= t3;
				t2 <= t2;
				t1 <= t1;
				t0 <= t0;
			end
		end
		else if (data_counter >= `_NUM_DATA_BITS) begin
			data_counter <= 0;
			data_buffer <= 10'b0;
			new_t <= 1'b0;
		end
		else begin
			data_counter <= data_counter + 6'b1;
			t31 <= t31;
			t30 <= t30;
			t29 <= t29;
			t28 <= t28;
			t27 <= t27;
			t26 <= t26;
			t25 <= t25;
			t24 <= t24;
			t23 <= t23;
			t22 <= t22;
			t21 <= t21;
			t20 <= t20;
			t19 <= t19;
			t18 <= t18;
			t17 <= t17;
			t16 <= t16;
			t15 <= t15;
			t14 <= t14;
			t13 <= t13;
			t12 <= t12;
			t11 <= t11;
			t10 <= t10;
			t9 <= t9;
			t8 <= t8;
			t7 <= t7;
			t6 <= t6;
			t5 <= t5;
			t4 <= t4;
			t3 <= t3;
			t2 <= t2;
			t1 <= t1;
			t0 <= t0;
		end
	end
	
endmodule 