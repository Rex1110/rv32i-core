module id_ex(
    input                   clk,
    input                   rst,

    input           [ 5:0]  i_mnemonic,
    input           [31:0]  i_rs1_data,
    input           [31:0]  i_rs2_data,
    input           [ 4:0]  i_rd_addr,
    input                   i_rd_wr,
    input           [31:0]  i_imm,
    input                   i_ALUsrc1,
    input                   i_ALUsrc2,
    input           [31:0]  i_pc,
    input           [ 4:0]  i_rs1_addr,
    input           [ 4:0]  i_rs2_addr,
    input                   i_flush,
    input                   i_DM_OE,
    input                   i_ex_stall,

    output  logic   [ 5:0]  o_mnemonic,
    output  logic   [31:0]  o_rs1_data,
    output  logic   [31:0]  o_rs2_data,
    output  logic   [ 4:0]  o_rd_addr,
    output  logic           o_rd_wr,
    output  logic   [31:0]  o_imm,
    output  logic           o_ALUsrc1,
    output  logic           o_ALUsrc2,
    output  logic   [31:0]  o_pc,
    output  logic   [ 4:0]  o_rs1_addr,
    output  logic   [ 4:0]  o_rs2_addr,
    output  logic           o_DM_OE

);
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            o_mnemonic  <= 'd0;
            o_rs1_data  <= 'd0;
            o_rs2_data  <= 'd0;
            o_rd_addr   <= 'd0;
            o_rd_wr     <= 'd0;
            o_imm       <= 'd0;
            o_ALUsrc1   <= 'd0;
            o_ALUsrc2   <= 'd0;
            o_pc        <= 'd0;
            o_rs1_addr  <= 'd0;
            o_rs2_addr  <= 'd0;
            o_DM_OE     <= 'd0;
        end else if (i_flush || i_ex_stall) begin
            o_mnemonic  <= 'd0;
            o_rs1_data  <= 'd0;
            o_rs2_data  <= 'd0;
            o_rd_addr   <= 'd0;
            o_rd_wr     <= 'd0;
            o_imm       <= 'd0;
            o_ALUsrc1   <= 'd0;
            o_ALUsrc2   <= 'd0;
            o_pc        <= 'd0;
            o_rs1_addr  <= 'd0;
            o_rs2_addr  <= 'd0;
            o_DM_OE     <= 'd0;
        end else begin
            o_mnemonic  <= i_mnemonic;
            o_rs1_data  <= i_rs1_data;
            o_rs2_data  <= i_rs2_data;
            o_rd_addr   <= i_rd_addr;
            o_rd_wr     <= i_rd_wr;
            o_imm       <= i_imm;
            o_ALUsrc1   <= i_ALUsrc1;
            o_ALUsrc2   <= i_ALUsrc2;
            o_pc        <= i_pc;
            o_rs1_addr  <= i_rs1_addr;
            o_rs2_addr  <= i_rs2_addr;
            o_DM_OE     <= i_DM_OE;
        end
    end
endmodule