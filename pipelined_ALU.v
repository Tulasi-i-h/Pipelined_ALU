`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2025 19:13:55
// Design Name: 
// Module Name: pipelined_ALU
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



module pipelined_alu (
    input clk,
    input rst,
    input [15:0] A,
    input [15:0] B,
    input [3:0] opcode,
    output reg [15:0] result,
    output reg Z, C, V, N
);

    // Stage 1 Registers (Fetch)
    reg [15:0] A_reg1, B_reg1;
    reg [3:0] opcode_reg1;

    // Stage 2 Registers (Execute)
    reg [15:0] ALU_result_reg2;
    reg Z_reg2, C_reg2, V_reg2, N_reg2;

    // Stage 3 Registers (Write Back)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A_reg1 <= 0; B_reg1 <= 0; opcode_reg1 <= 0;
            ALU_result_reg2 <= 0;
            Z_reg2 <= 0; C_reg2 <= 0; V_reg2 <= 0; N_reg2 <= 0;
            result <= 0; Z <= 0; C <= 0; V <= 0; N <= 0;
        end else begin
            // Stage 1 - Fetch
            A_reg1 <= A;
            B_reg1 <= B;
            opcode_reg1 <= opcode;

            // Stage 2 - Execute
            case (opcode_reg1)
                4'b0000: {C_reg2, ALU_result_reg2} = A_reg1 + B_reg1;  // ADD
                4'b0001: {C_reg2, ALU_result_reg2} = A_reg1 - B_reg1;  // SUB
                4'b0010: ALU_result_reg2 = A_reg1 & B_reg1;            // AND
                4'b0011: ALU_result_reg2 = A_reg1 | B_reg1;            // OR
                4'b0100: ALU_result_reg2 = A_reg1 ^ B_reg1;            // XOR
                4'b0101: ALU_result_reg2 = ~A_reg1;                    // NOT A
                4'b0110: ALU_result_reg2 = A_reg1 << 1;                // LSHIFT
                4'b0111: ALU_result_reg2 = A_reg1 >> 1;                // RSHIFT
                4'b1000: ALU_result_reg2 = (A_reg1 == B_reg1) ? 16'd1 :
                                          (A_reg1 > B_reg1)  ? 16'd2 :
                                                               16'd0; // COMPARE
                default: ALU_result_reg2 = 16'd0;
            endcase

            Z_reg2 <= (ALU_result_reg2 == 16'd0);
            N_reg2 <= ALU_result_reg2[15];
            V_reg2 <= ((opcode_reg1 == 4'b0000 || opcode_reg1 == 4'b0001) &&
                       ((A_reg1[15] == B_reg1[15]) && (ALU_result_reg2[15] != A_reg1[15])));

            // Stage 3 - Write Back
            result <= ALU_result_reg2;
            Z <= Z_reg2;
            C <= C_reg2;
            V <= V_reg2;
            N <= N_reg2;
        end
    end
endmodule


