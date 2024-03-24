`include "./mem_wb.sv"
`include "./load.sv"
module wbu(
    input                   clk,
    input                   rst,

    input           [ 5:0]  i_mnemonic,
    input           [ 4:0]  i_rd_addr,
    input           [31:0]  i_ALUout,
    input                   i_rd_wr,
    input           [31:0]  i_DM_DI,

    output  logic   [ 4:0]  o_rd_addr,
    output  logic   [31:0]  o_rd_data,
    output  logic           o_rd_wr,
    output  logic           o_DM_OE
);
    logic load_inst;
    logic [31:0] ALUout;
    logic [5:0] mnemonic;
    mem_wb mem_wb0(
        .clk        (clk        ),
        .rst        (rst        ),
        
        .i_rd_addr  (i_rd_addr  ),
        .i_ALUout   (i_ALUout   ),
        .i_rd_wr    (i_rd_wr    ),
        .i_mnemonic (i_mnemonic ),

        .o_rd_addr  (o_rd_addr  ),
        .o_ALUout   (ALUout     ),
        .o_rd_wr    (o_rd_wr    ),
        .o_mnemonic (mnemonic   )
    );

    load load0(
        .i_mnemonic (mnemonic   ),
        .i_ALUout   (ALUout     ),
        .i_DM_DI    (i_DM_DI    ),

        .o_rd_data  (o_rd_data  ),
        .o_DM_OE    (o_DM_OE    )
    );

endmodule