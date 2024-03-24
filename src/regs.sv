module regs(
    input                   clk,
    input                   rst,

    input                   i_rd_wr,

    input           [ 4:0]  i_rd_addr,
    input           [ 4:0]  i_rs1_addr,
    input           [ 4:0]  i_rs2_addr,

    input           [31:0]  i_rd_data,


    output  logic   [31:0]  o_rs1_data,
    output  logic   [31:0]  o_rs2_data
);

    logic [31:0] regs [0:31];

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            for (int i = 0; i < 32; i++) begin
                regs[i] <= 'd0;
            end
        end else if (i_rd_wr) begin
            regs[i_rd_addr] <= i_rd_data;
        end else begin
            regs[i_rd_addr] <= regs[i_rd_addr];
        end
    end

    always_comb begin
        if (i_rs1_addr == 5'b0) begin
            o_rs1_data = 'd0;
        end else if (i_rd_wr && i_rd_addr == i_rs1_addr) begin
            o_rs1_data = i_rd_data;
        end else begin
            o_rs1_data = regs[i_rs1_addr];
        end
    end

    always_comb begin
        if (i_rs2_addr == 5'b0) begin
            o_rs2_data = 32'b0;
        end else if (i_rd_wr && i_rd_addr == i_rs2_addr) begin
            o_rs2_data = i_rd_data;
        end else begin
            o_rs2_data = regs[i_rs2_addr];
        end
    end

endmodule