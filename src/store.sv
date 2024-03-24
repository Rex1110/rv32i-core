`include "../include/define.svh"
module store(
    input           [ 5:0]  i_mnemonic,
    input           [31:0]  i_ALUout,
    input           [31:0]  i_rs2_data,

    output  logic           o_DM_CS,
    output  logic   [ 3:0]  o_DM_WEB,
    output  logic   [31:0]  o_DM_addr,
    output  logic   [31:0]  o_DM_DI
);
    assign o_DM_addr = i_ALUout;
    always_comb begin
        unique case (i_mnemonic) 
            `SW: begin
                o_DM_CS     = 1'b1;
                o_DM_DI     = i_rs2_data;
                o_DM_WEB    = 4'b0000;
            end
            `SB: begin
                o_DM_CS     = 1'b1;
                o_DM_DI     = {4{i_rs2_data[7:0]}};
                unique case (i_ALUout[1:0])
                    2'b00: o_DM_WEB = 4'b1110;
                    2'b01: o_DM_WEB = 4'b1101;
                    2'b10: o_DM_WEB = 4'b1011;
                    2'b11: o_DM_WEB = 4'b0111;
                endcase
            end
            `SH: begin
                o_DM_CS     = 1'b1;
                o_DM_DI     = {2{i_rs2_data[15:0]}};
                o_DM_WEB    = i_ALUout[1] ? 4'b0011 : 4'b1100;
            end
            `LW, `LB, `LBU, `LH, `LHU: begin
                o_DM_CS     = 1'b1;
                o_DM_DI     = 32'b0;
                o_DM_WEB    = 4'b1111;
            end
            default: begin
                o_DM_CS     = 1'b0;
                o_DM_DI     = 32'b0;
                o_DM_WEB    = 4'b1111;
            end
        endcase
    end
endmodule