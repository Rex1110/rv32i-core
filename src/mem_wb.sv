module mem_wb(
    input                   clk,
    input                   rst,

    input           [ 5:0]  i_mnemonic,
    input           [ 4:0]  i_rd_addr,
    input           [31:0]  i_ALUout,
    input                   i_rd_wr,

    output  logic   [ 5:0]  o_mnemonic,
    output  logic   [ 4:0]  o_rd_addr,
    output  logic   [31:0]  o_ALUout,
    output  logic           o_rd_wr
);
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            o_rd_addr   <= 'd0;
            o_ALUout    <= 'd0;
            o_rd_wr     <= 'd0;
            o_mnemonic  <= 'd0;
        end else begin
            o_rd_addr   <= i_rd_addr;
            o_ALUout    <= i_ALUout;
            o_rd_wr     <= i_rd_wr;
            o_mnemonic  <= i_mnemonic;
        end
    end

endmodule