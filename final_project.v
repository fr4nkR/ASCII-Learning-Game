module final_project(CLOCK_50,SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX6, HEX5, HEX4,HEX7, LEDR, LEDG);
    /////////////////////////////////////////////////////////
    /////////////////General Parameters
	input [17:0]SW;
	input [3:0]KEY;
	output [6:0]HEX0, HEX1,HEX2, HEX3, HEX7, HEX6, HEX5, HEX4;
	output [17:0] LEDR;
	output [7:0] LEDG;
	
	
	input CLOCK_50;
    //assign LEDR[7:0] = SW[7:0];
    //////////////////////////////////////////////////////////////////////////
    /////////////////Getting the ascii code according to the random number
	ascii_random u0(random_number, ascii_code[7:0]);
	wire [7:0] ascii_code;

    ///////////////////////////////
	////////////SCORE UPDATED


    score_updater su1(SW[7:0], stop, ascii_code[7:0], LEDG[7:0], LEDR[17:0]);

	//////////////////////
	
    ////////////////////////////////////////////
	/////////////////////TIMER
    wire clock_1Hz;
	wire [6:0]temp_m0,temp_s1,temp_s0;
	clock1Hz M0(CLOCK_50, 25000000, clock_1Hz);
	wire stop;
	timer t1(CLOCK_50, SW[15], clock_1Hz, stop, temp_m0, temp_s1, temp_s0);
    display_numbers x1(temp_m0, HEX6);
    display_numbers x2(temp_s1/10, HEX5);
    display_numbers x3(temp_s0%10, HEX4);
	//////////////////////////////////////////////////
	//////////////////// Ramdom Number/Data type
	wire [5:0]random_number;
	random_generator r1(random_number, SW[16], SW[17], CLOCK_50);
	hex2seg7_letter u1(random_number, HEX0);
	data_type u2(random_number, HEX1);	
endmodule

module score_updater(switches, stop, ascii_code, ledgreen, ledred);
	input stop;
	output reg [7:0]ledgreen;
	output reg [17:0] ledred;
	input [7:0]ascii_code;
	input [7:0] switches;
	always@(*)
                if(switches == ascii_code)
                    begin
                      if(stop!=1)
                        begin
                        ledgreen = 8'b11111111;//green lights on
                        end
                    end
                else if (switches != ascii_code)
                    begin
                      if(stop!=1)
                        begin
                        ledred = 18'b111111111111111111;//red lights on
                        end
                    end
                else
                    begin
                        ledgreen = 8'b00000000;
                        ledred = 18'b000000000000000000;
                    end
  
endmodule


module display_numbers(number, seg7);
    input [3:0] number;
    output reg [6:0]seg7;
    always @(*)
        case(number)
            4'b0000: seg7 <= 7'b 1000000; // letter 0
    		4'b0001: seg7 <= 7'b 1111001; // letter 1
    		4'b0010: seg7 <= 7'b 0100100; // letter 2
    		4'b0011: seg7 <= 7'b 0110000; // letter 3
    		4'b0100: seg7 <= 7'b 0011001; // letter 4
    		4'b0101: seg7 <= 7'b 0010010; // letter 5
    		4'b0110: seg7 <= 7'b 0000010; // letter 6
    		4'b0111: seg7 <= 7'b 1111000; // letter 7
    		4'b1000: seg7 <= 7'b 0000000; // letter 8
    		4'b1001: seg7 <= 7'b 0011000; // letter 9
		endcase
		
endmodule
module ascii_random(random_number, ascii_code);
	input [5:0] random_number;
	output reg  [7:0] ascii_code;

	always @(*)
	
	case(random_number)
		//Numbers 1-9
		0: ascii_code <= 8'b 00110000; // letter 0
		1: ascii_code <= 8'b 00110001; // letter 1
		2: ascii_code <= 8'b 00110010; // letter 2
		3: ascii_code <= 8'b 00110011; // letter 3
		4: ascii_code <= 8'b 00110100; // letter 4
		5: ascii_code <= 8'b 00110101; // letter 5
		6: ascii_code <= 8'b 00110110; // letter 6
		7: ascii_code <= 8'b 00110111; // letter 7
		8: ascii_code <= 8'b 00111000; // letter 8
		9: ascii_code <= 8'b 00111001; // letter 9
		//lowercase letters a-z
		10: ascii_code <= 8'b 01100001; // letter a
		11: ascii_code <= 8'b 01100010; // letter b
		12: ascii_code <= 8'b 01100011; // letter c
		13: ascii_code <= 8'b 01100100; // letter d
		14: ascii_code <= 8'b 01100101; // letter e
		15: ascii_code <= 8'b 01100110; // letter f
		16: ascii_code <= 8'b 01100111; // letter g
		17: ascii_code <= 8'b 01101000; // letter h
		18: ascii_code <= 8'b 01101001; // letter i
		19: ascii_code <= 8'b 01101010; // letter j
		20: ascii_code <= 8'b 01101100; // letter l
		21: ascii_code <= 8'b 01101110; // letter n
		22: ascii_code <= 8'b 01101111; // letter o
		23: ascii_code <= 8'b 01110000; // letter p
		24: ascii_code <= 8'b 01110001; // letter q
		25: ascii_code <= 8'b 01110010; // letter r
		26: ascii_code <= 8'b 01110011; // letter s
		27: ascii_code <= 8'b 01110100; // letter t
		28: ascii_code <= 8'b 01110101; // letter u
		29: ascii_code <= 8'b 01111001; // letter y
		//UPPERCASE LETTERS A-Z
		30: ascii_code <= 8'b 01000001; // letter A
		31: ascii_code <= 8'b 01000010; // letter B
		32: ascii_code <= 8'b 01000011; // letter C
		33: ascii_code <= 8'b 01000101; // letter E
		34: ascii_code <= 8'b 01000110; // letter F
		35: ascii_code <= 8'b 01000111; // letter G
		36: ascii_code <= 8'b 01001000; // letter H
		37: ascii_code <= 8'b 01001001; // letter I		
		38: ascii_code <= 8'b 01001010; // letter J
		39: ascii_code <= 8'b 01001100; // letter L
		40: ascii_code <= 8'b 01001111; // letter O
		41: ascii_code <= 8'b 01010000; // letter P
		42: ascii_code <= 8'b 01010011; // letter S
		43: ascii_code <= 8'b 01010101; // letter U
		44: ascii_code <= 8'b 01011001; // letter Y
		default : ascii_code <=-1;
	endcase
endmodule

module hex2seg7_letter(random_number,seg7);
	input [5:0] random_number;
	output reg [6:0] seg7;
	always @(*)
	case(random_number)
		//Numbers 1-9
		0: seg7 <= 7'b 1000000; // letter 0
		1: seg7 <= 7'b 1111001; // letter 1
		2: seg7 <= 7'b 0100100; // letter 2
		3: seg7 <= 7'b 0110000; // letter 3
		4: seg7 <= 7'b 0011001; // letter 4
		5: seg7 <= 7'b 0010010; // letter 5
		6: seg7 <= 7'b 0000010; // letter 6
		7: seg7 <= 7'b 1111000; // letter 7
		8: seg7 <= 7'b 0000000; // letter 8
		9: seg7 <= 7'b 0011000; // letter 9
		10: seg7 <= 7'b 0011000; // letter a
		11: seg7 <= 7'b 0000011; // letter b
		12: seg7 <= 7'b 1000110; // letter c
		13: seg7 <= 7'b 0100001; // letter d
		14: seg7 <= 7'b 0000100; // letter e
		15: seg7 <= 7'b 0001110; // letter f
		16: seg7 <= 7'b 0010000; // letter g
		17: seg7 <= 7'b 0001011; // letter h
		18: seg7 <= 7'b 1111001; // letter i
		19: seg7 <= 7'b 1110001; // letter j
		20: seg7 <= 7'b 1001111; // letter l
		21: seg7 <= 7'b 0101011; // letter n
		22: seg7 <= 7'b 1000000; // letter o
		23: seg7 <= 7'b 0001100; // letter p
		24: seg7 <= 7'b 0011000; // letter q
		25: seg7 <= 7'b 0001111; // letter r
		26: seg7 <= 7'b 0010010; // letter s
		27: seg7 <= 7'b 0000111; // letter t
		28: seg7 <= 7'b 1000001; // letter u
		29: seg7 <= 7'b 0010001; // letter y
		
		//UPPERCASE LETTERS A-Z
		30: seg7 <= 7'b 0001000; // letter A
		31: seg7 <= 7'b 0000000; // letter B
		32: seg7 <= 7'b 1000110; // letter C
		33: seg7 <= 7'b 0000110; // letter E
		34: seg7 <= 7'b 0001110; // letter F
		35: seg7 <= 7'b 0000010; // letter G
		36: seg7 <= 7'b 0001001; // letter H
		37: seg7 <= 7'b 1111001; // letter I		
		38: seg7 <= 7'b 0010010; // letter J
		39: seg7 <= 7'b 1000111; // letter L
		40: seg7 <= 7'b 1000000; // letter O
		41: seg7 <= 7'b 0001100; // letter P
		42: seg7 <= 7'b 0010010; // letter S
		43: seg7 <= 7'b 1000001; // letter U
		44: seg7 <= 7'b 0010001; // letter Y
		default : seg7 <= 7'b 1111111;
	endcase
endmodule

module data_type(random_number,seg7);
	input [5:0]random_number;
	output reg [6:0] seg7;
	always @(*)
	case(random_number)
		//Numbers 1-9
		0: seg7 <= 7'b 0101011; // letter 0
		1: seg7 <= 7'b 0101011; // letter 1
		2: seg7 <= 7'b 0101011; // letter 2
		3: seg7 <= 7'b 0101011; // letter 3
		4: seg7 <= 7'b 0101011; // letter 4
		5: seg7 <= 7'b 0101011; // letter 5
		6: seg7 <= 7'b 0101011; // letter 6
		7: seg7 <= 7'b 0101011; // letter 7
		8: seg7 <= 7'b 0101011; // letter 8
		9: seg7 <= 7'b 0101011; // letter 9
		
		10: seg7 <= 7'b 1000111; // letter a
		11: seg7 <= 7'b 1000111; // letter b
		12: seg7 <= 7'b 1000111; // letter c
		13: seg7 <= 7'b 1000111; // letter d
		14: seg7 <= 7'b 1000111; // letter e
		15: seg7 <= 7'b 1000111; // letter f
		16: seg7 <= 7'b 1000111; // letter g
		17: seg7 <= 7'b 1000111; // letter h
		18: seg7 <= 7'b 1000111; // letter i
		19: seg7 <= 7'b 1000111; // letter j
		20: seg7 <= 7'b 1000111; // letter l
		21: seg7 <= 7'b 1000111; // letter n
		22: seg7 <= 7'b 1000111; // letter o
		23: seg7 <= 7'b 1000111; // letter p
		24: seg7 <= 7'b 1000111; // letter q
		25: seg7 <= 7'b 1000111; // letter r
		26: seg7 <= 7'b 1000111; // letter s
		27: seg7 <= 7'b 1000111; // letter t
		28: seg7 <= 7'b 1000111; // letter u
		29: seg7 <= 7'b 1000111; // letter y
		
		//UPPERCASE LETTERS A-Z
		30: seg7 <= 7'b 1000001; // letter A
		31: seg7 <= 7'b 1000001; // letter B
		32: seg7 <= 7'b 1000001; // letter C
		33: seg7 <= 7'b 1000001; // letter E
		34: seg7 <= 7'b 1000001; // letter F
		35: seg7 <= 7'b 1000001; // letter G
		36: seg7 <= 7'b 1000001; // letter H
		37: seg7 <= 7'b 1000001; // letter I		
		38: seg7 <= 7'b 1000001; // letter J
		39: seg7 <= 7'b 1000001; // letter L
		40: seg7 <= 7'b 1000001; // letter O
		41: seg7 <= 7'b 1000001; // letter P
		42: seg7 <= 7'b 1000001; // letter S
		43: seg7 <= 7'b 1000001; // letter U
		44: seg7 <= 7'b 1000001; // letter Y
		default : seg7 <= 7'b 1111111;

	endcase
endmodule



module timer(clock_in, on_switch, clock_1Hz, stop, temp_m0, temp_s1, temp_s0);
	input clock_in;
	input [0:0] on_switch;
	input clock_1Hz;
	output reg [6:0]temp_m0,temp_s1,temp_s0;
    output reg [0:0] stop;

	always @(posedge clock_1Hz)
		begin
			if(on_switch)
				begin
                    stop <= 0;
					temp_m0 <= 0;
					temp_s0 <= 0;
					temp_s1 <= 0;
				end
			else
                begin
                if (temp_m0 !=2)
                begin
                if(temp_s0+1 < 60 && temp_s1+1 < 60)
                begin
                    temp_s0 = temp_s0+1;
                    temp_s1 = temp_s1+1;
                end
                else
                begin
                    temp_s0 = 0;
                    temp_s1 = 0;
                    temp_m0 = temp_m0+1;
                    if(temp_m0==2)
                    begin
                        stop =1;
                    end
                end
                end
                end
		end
endmodule

module clock1Hz(input clk_in, input[31:0] clkscale, output reg clk_out);
	reg[31:0] clkq=0;// 2^32-1>25M

		always@(posedge clk_in)
			begin
				clkq = clkq+1;// add 1, every cycle of clk_in
					if(clkq==clkscale)
						begin//toggle every clckscale cycles
								clk_out=~clk_out;
								clkq=0;//reset counter
						end
			end
endmodule

module random_generator(inwire,reset,enable,clock); 
    output reg [5:0]inwire;
    input reset;
    input clock;
    input enable;
    always @(posedge clock)
    if(reset)
        begin
        inwire <= 0;
        end
    else if(enable)
        begin
        inwire <= inwire + 1;
        if(inwire > 44)
            begin
            inwire <= 0;
            end
        end
endmodule
		