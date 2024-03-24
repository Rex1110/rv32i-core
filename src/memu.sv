`include "./ex_mem.sv"
`include "./store.sv"
module memu(
    input                   clk,
    input                   rst,

    input           [ 5:0]  i_mnemonic,
    
    input           [ 4:0]  i_rd_addr,
    input           [31:0]  i_ALUout,
    input                   i_rd_wr,
    input           [31:0]  i_rs2_data,

    output  logic   [ 5:0]  o_mnemonic,
    output  logic   [ 4:0]  o_rd_addr,
    output  logic   [31:0]  o_ALUout,
    output  logic           o_rd_wr,

    output  logic           o_DM_CS,
    output  logic   [ 3:0]  o_DM_WEB,
    output  logic   [31:0]  o_DM_addr,
    output  logic   [31:0]  o_DM_DI

);
    logic [5:0] mnemonic;
    logic [31:0] rs2_data;
    logic [31:0] ALUout;
    ex_mem ex_mem0(
        .clk        (clk        ),
        .rst        (rst        ),

        .i_mnemonic (i_mnemonic ),
        .i_rd_addr  (i_rd_addr  ),
        .i_ALUout   (i_ALUout   ),
        .i_rd_wr    (i_rd_wr    ),
        .i_rs2_data (i_rs2_data ),

        .o_mnemonic (mnemonic   ),
        .o_rd_addr  (o_rd_addr  ),
        .o_ALUout   (ALUout     ),
        .o_rd_wr    (o_rd_wr    ),
        .o_rs2_data (rs2_data   )
    );
    //store
    store store0(
        .i_mnemonic (mnemonic   ),
        .i_ALUout   (ALUout     ),
        .i_rs2_data (rs2_data   ),

        .o_DM_CS    (o_DM_CS    ),
        .o_DM_WEB   (o_DM_WEB   ),
        .o_DM_addr  (o_DM_addr  ),
        .o_DM_DI    (o_DM_DI    )
    );
    assign o_ALUout   = ALUout;
    assign o_mnemonic = mnemonic;
endmodule