`include "./cpu.sv"
`include "./SRAM_wrapper.sv"
module top(
    input clk,
    input rst
);
    logic [31:0] IM_addr, IM_inst;
    logic DM_CS, DM_OE;
    logic [3:0] DM_WEB;
    logic [31:0] DM_addr, DM_DI, DM_DO;
    cpu cpu0(
        .clk(clk),
        .rst(rst),

        .i_IM_inst(IM_inst),
        .i_DM_DI(DM_DO),

        .o_IM_addr(IM_addr),
        .o_DM_CS(DM_CS),
        .o_DM_WEB(DM_WEB),
        .o_DM_addr(DM_addr),
        .o_DM_DI(DM_DI),
        .o_DM_OE(DM_OE)
    );
    SRAM_wrapper IM1(
        .CK(clk),
        .CS(1'b1),
        .OE(1'b1),
        .WEB(4'b1111),
        .A(IM_addr[15:2]),
        .DI(32'b0),
        .DO(IM_inst)
    );

    SRAM_wrapper DM1(
        .CK(clk),
        .CS(DM_CS),
        .OE(1'b1),
        .WEB(DM_WEB),
        .A(DM_addr[15:2]),
        .DI(DM_DI),
        .DO(DM_DO)
    );

    

endmodule