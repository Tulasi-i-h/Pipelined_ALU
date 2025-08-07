`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025 19:14:58
// Design Name: 
// Module Name: pipelined_ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module pipelined_alu_tb;

    reg clk, rst;
    reg [15:0] A, B;
    reg [3:0] opcode;
    wire [15:0] result;
    wire Z, C, V, N;

    pipelined_alu UUT (
        .clk(clk), .rst(rst),
        .A(A), .B(B), .opcode(opcode),
        .result(result), .Z(Z), .C(C), .V(V), .N(N)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $dumpfile("pipelined_alu_tb.vcd");
        $dumpvars(0, pipelined_alu_tb);

        clk = 0;
        rst = 1; A = 0; B = 0; opcode = 0;
        #10 rst = 0;

        // ADD
        A = 16'd12; B = 16'd34; opcode = 4'b0000; #10;

        // SUB
        A = 16'd100; B = 16'd40; opcode = 4'b0001; #10;

        // AND
        A = 16'hF0F0; B = 16'h0FF0; opcode = 4'b0010; #10;

        // OR
        A = 16'h0F0F; B = 16'h00FF; opcode = 4'b0011; #10;

        // XOR
        A = 16'hAAAA; B = 16'h5555; opcode = 4'b0100; #10;

        // NOT
        A = 16'h00FF; B = 0; opcode = 4'b0101; #10;

        // LSHIFT
        A = 16'h0003; opcode = 4'b0110; #10;

        // RSHIFT
        A = 16'h000C; opcode = 4'b0111; #10;

        // COMPARE: A == B
        A = 16'd20; B = 16'd20; opcode = 4'b1000; #10;

        // COMPARE: A > B
        A = 16'd30; B = 16'd20; opcode = 4'b1000; #10;

        // COMPARE: A < B
        A = 16'd15; B = 16'd20; opcode = 4'b1000; #10;

        $finish;
    end
endmodule

