`include "./ifu.sv"
`include "./idu.sv"
`include "./exu.sv"
`include "./memu.sv"
`include "./wbu.sv"

module cpu(
    input clk,
    input rst,

    input [31:0] i_IM_inst,
    input [31:0] i_DM_DI,

    output logic [31:0] o_IM_addr,
    output logic        o_DM_CS,
    output logic [3:0]  o_DM_WEB,
    output logic [31:0] o_DM_addr,
    output logic [31:0] o_DM_DI,
    output logic        o_DM_OE
);
    logic [31:0] if_inst;

    logic [5:0]  id_mnemonic;
    logic [31:0] id_pc, id_rs1_data, id_rs2_data, id_imm;
    logic [4:0]  id_rd_addr, id_rs1_addr, id_rs2_addr;
    logic        id_rd_wr, id_ALUsrc1, id_ALUsrc2, id_DM_OE;

    logic [5:0]  ex_mnemonic;
    logic [4:0]  ex_rd_addr;
    logic [31:0] ex_ALUout, ex_rs2_data, ex_branch_addr;
    logic        ex_rd_wr, ex_flush, ex_stall;


    logic [4:0]  mem_rd_addr;
    logic [31:0] mem_ALUout;
    logic        mem_rd_wr;
    logic [5:0]  mem_mnemonic;

    logic [4:0]  wb_rd_addr;
    logic [31:0] wb_rd_data;
    logic        wb_rd_wr;
    ifu ifu0(
        .clk(clk),
        .rst(rst),
        
        .i_inst(i_IM_inst),
        .i_flush(ex_flush),
        .i_branch_addr(ex_branch_addr),
        .i_ex_stall(ex_stall),

        .o_inst(if_inst),
        .o_IM_addr(o_IM_addr)
    );
    idu idu0(
        .clk(clk),
        .rst(rst),

        .i_pc(o_IM_addr),
        .i_inst(if_inst),

        .i_rd_data(wb_rd_data),
        .i_rd_addr(wb_rd_addr),
        .i_rd_wr(wb_rd_wr),

        .o_mnemonic(id_mnemonic),
        .o_rs1_data(id_rs1_data),
        .o_rs2_data(id_rs2_data),
        .o_rd_addr(id_rd_addr),
        .o_rd_wr(id_rd_wr),
        .o_imm(id_imm),
        .o_ALUsrc1(id_ALUsrc1),
        .o_ALUsrc2(id_ALUsrc2),
        .o_pc(id_pc),
        .o_rs1_addr(id_rs1_addr),
        .o_rs2_addr(id_rs2_addr),
        .o_DM_OE(id_DM_OE)
    );


    exu exu0(
        .clk(clk),
        .rst(rst),

        .i_wb_rd_addr(wb_rd_addr),
        .i_wb_rd_data(wb_rd_data),
        .i_wb_rd_wr(wb_rd_wr),
        
        .i_mem_rd_addr(mem_rd_addr),
        .i_mem_rd_data(mem_ALUout),
        .i_mem_rd_wr(mem_rd_wr),

        .i_mnemonic(id_mnemonic),
        .i_rs1_data(id_rs1_data),
        .i_rs2_data(id_rs2_data),
        .i_rd_addr(id_rd_addr),
        .i_rd_wr(id_rd_wr),
        .i_imm(id_imm),
        .i_ALUsrc1(id_ALUsrc1),
        .i_ALUsrc2(id_ALUsrc2),
        .i_pc(id_pc),
        .i_rs1_addr(id_rs1_addr),
        .i_rs2_addr(id_rs2_addr),
        .i_flush(ex_flush),
        .i_DM_OE(id_DM_OE),


        .o_mnemonic(ex_mnemonic),
        .o_rd_addr(ex_rd_addr),
        .o_ALUout(ex_ALUout),
        .o_rd_wr(ex_rd_wr),
        .o_rs2_data(ex_rs2_data),
        .o_flush(ex_flush),
        .o_branch_addr(ex_branch_addr),
        .o_ex_stall(ex_stall)
    );

    memu memu0(
        .clk(clk),
        .rst(rst),

        .i_mnemonic(ex_mnemonic),
        .i_rd_addr(ex_rd_addr),
        .i_ALUout(ex_ALUout),
        .i_rd_wr(ex_rd_wr),
        .i_rs2_data(ex_rs2_data),

        .o_mnemonic(mem_mnemonic),
        .o_rd_addr(mem_rd_addr),
        .o_ALUout(mem_ALUout),
        .o_rd_wr(mem_rd_wr),
        .o_DM_CS(o_DM_CS),
        .o_DM_WEB(o_DM_WEB),
        .o_DM_addr(o_DM_addr),
        .o_DM_DI(o_DM_DI)
    );
    
    wbu wbu0(
        .clk(clk),
        .rst(rst),

        .i_mnemonic(mem_mnemonic),
        .i_rd_addr(mem_rd_addr),
        .i_ALUout(mem_ALUout),
        .i_rd_wr(mem_rd_wr),
        .i_DM_DI(i_DM_DI),

        .o_rd_addr(wb_rd_addr),
        .o_rd_data(wb_rd_data),
        .o_rd_wr(wb_rd_wr),
        .o_DM_OE(o_DM_OE)
    );
endmodule