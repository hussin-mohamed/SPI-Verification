package sequence_itemmm;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    class seq_itemmm extends uvm_sequence_item;
        `uvm_object_utils(seq_itemmm)
        function new(string name = "seq_itemmm");
            super.new(name);
        endfunction //new()
        static rand logic [9:0] din;
        static rand logic rx_valid,rst_n;
        bit rst_old;
        bit [9:0] din_old;
        logic  [7:0]dout;
        logic  tx_valid;
        constraint c1 {
            rst_n dist {1:=90,0:=10};
            rx_valid dist {1:=90,0:=10};
            }
            function void pre_randomize();
                rst_old=rst_n;
                din_old=din;
                
            endfunction
            function void post_randomize();
                if (rst_old==1'b1) begin
                if (din_old[9:8]==2'b00) begin
                    din[9:8]=2'b01;
                end
                    
                else if (din_old[9:8]==2'b10) begin
                     din[9:8]=2'b11;
                end
                if (din[9:8]==2'b01 && din_old[9:8]!=2'b00) begin
                    din[9:8]=2'b00;
                end
                else if (din[9:8]==2'b11 && din_old[9:8]!=2'b10) begin
                    din[9:8]=2'b10;
                end
                end 
                else
                begin
                    if (((din[9:8])!=2'b00 || (din[9:8])!=2'b10) ) begin
                    din[9:8]=2'b00;  
                    end
                end
            endfunction
    endclass //seq_item extends superClass
endpackage