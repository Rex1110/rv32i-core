module ifu(
    input                   clk,
    input                   rst,

    input           [31:0]  i_inst,
    input           [31:0]  i_branch_addr,

    input                   i_flush,
    input                   i_ex_stall,

    output  logic   [31:0]  o_IM_addr,
    output  logic   [31:0]  o_inst
);

    logic [31:0] pc;

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            pc <= 'd0;
        end else begin
            if (i_flush == 'd1) begin
                pc <= i_branch_addr + 'd4;
            end else if (i_ex_stall == 1'd1) begin
                pc <= pc;
            end else begin
                pc <= pc + 'd4;
            end
        end
    end


    assign o_inst   = i_inst;
    always_comb begin
        if (i_flush == 1'b1) begin
            o_IM_addr = i_branch_addr;
        end else if (i_ex_stall) begin
            o_IM_addr = pc -'d4;
        end else begin
            o_IM_addr = pc;
        end
    end
    // assign o_IM_addr= (i_flush == 'd1) ? i_branch_addr : pc;

endmodule