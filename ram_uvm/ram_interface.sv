interface ram_inter(clk);
    parameter MEM_DEPTH =256;
    parameter ADDR_SIZE =8;
    input clk;
    logic [9:0] din;
    logic rx_valid,rst_n;
    logic  [7:0]dout;
    logic  tx_valid;
    modport DUT (
    input clk,din,rst_n,rx_valid,
    output dout,tx_valid
    ); 
endinterface //inter