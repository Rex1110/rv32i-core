`include "../include/define.svh"
module load(
    input           [ 5:0]  i_mnemonic,
    input           [31:0]  i_ALUout,
    input           [31:0]  i_DM_DI,

    output  logic   [31:0]  o_rd_data,
    output  logic           o_DM_OE
);
    always_comb begin
        unique case (i_mnemonic)
            `LW: begin
                o_DM_OE     = 1'b1;
                o_rd_data   = i_DM_DI;
            end
            `LH: begin
                o_DM_OE     = 1'b1;
                o_rd_data   = i_ALUout[1] ? signed'(i_DM_DI[31:16]) : signed'(i_DM_DI[15:0]);
            end
            `LB: begin
                o_DM_OE = 1'b1;
                unique case (i_ALUout[1:0])
                    2'b00: o_rd_data = signed'(i_DM_DI[ 7: 0]);
                    2'b01: o_rd_data = signed'(i_DM_DI[15: 8]);
                    2'b10: o_rd_data = signed'(i_DM_DI[23:16]);
                    2'b11: o_rd_data = signed'(i_DM_DI[31:24]);
                endcase
            end
            `LHU: begin
                o_DM_OE = 1'b1;
                o_rd_data = i_ALUout[1] ? i_DM_DI[31:16] : i_DM_DI[15:0];
            end
            `LBU: begin
                o_DM_OE = 1'b1;
                unique case (i_ALUout[1:0])
                    2'b00: o_rd_data = i_DM_DI[ 7: 0];
                    2'b01: o_rd_data = i_DM_DI[15: 8];
                    2'b10: o_rd_data = i_DM_DI[23:16];
                    2'b11: o_rd_data = i_DM_DI[31:24];
                endcase
            end
            default: begin
                o_DM_OE = 1'b0;
                o_rd_data = i_ALUout;
            end
        endcase
    end
endmodule