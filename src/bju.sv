module bju(
    input [5:0]  i_mnemonic,
    input [31:0] i_src1,
    input [31:0] i_src2,
    input [31:0] i_fw_rs1_data,
    input [31:0] i_imm,
    input [31:0] i_pc,
    output logic o_branch,
    output logic [31:0] o_branch_addr

);

    always_comb begin
        unique case (i_mnemonic)
            `BEQ: begin
                o_branch = (i_src1 == i_src2) ? 1'b1 : 1'b0;
                o_branch_addr = i_pc + i_imm;
            end
            `BNE: begin
                o_branch = (i_src1 != i_src2) ? 1'b1 : 1'b0;
                o_branch_addr = i_pc + i_imm;
            end
            `BLT: begin
                o_branch = ($signed(i_src1) < $signed(i_src2)) ? 1'b1 : 1'b0;
                o_branch_addr = i_pc + i_imm;
            end
            `BGE: begin
                o_branch = ($signed(i_src1) >= $signed(i_src2)) ? 1'b1: 1'b0;
                o_branch_addr = i_pc + i_imm;
            end
            `BLTU: begin
                o_branch = ($unsigned(i_src1) < $unsigned(i_src2)) ? 1'b1 : 1'b0;
                o_branch_addr = i_pc + i_imm;
            end
            `BGEU: begin
                o_branch = ($unsigned(i_src1) >= $unsigned(i_src2)) ? 1'b1 : 1'b0;
                o_branch_addr = i_pc + i_imm;
            end 
            `JAL: begin
                o_branch = 1'b1;
                o_branch_addr = i_pc + i_imm;
            end
            `JALR: begin
                o_branch = 1'b1;
                o_branch_addr = i_imm + i_fw_rs1_data;
            end
            default: begin
                o_branch = 1'b0;
                o_branch_addr = 32'b0;
            end
        endcase
    end

endmodule