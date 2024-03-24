module if_id(
    input                   clk,
    input                   rst,
    input           [31:0]  i_pc,
    input           [31:0]  i_inst,

    output  logic   [31:0]  o_pc,
    output  logic   [31:0]  o_inst
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            o_pc <= 'd0;
        end else begin
            o_pc <= i_pc;
        end
    end

    assign o_inst = i_inst;
endmodule