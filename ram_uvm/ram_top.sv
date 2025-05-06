import ram_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
module top ();
    bit clk ;
    initial begin
        forever begin
            #10;
            clk=!clk;
        end
    end
    ram_inter ram_test_vif(clk);
    ram dut (ram_test_vif);
    bind ram sva sva_inst(ram_test_vif);
    initial begin
    uvm_config_db#(virtual ram_inter)::set(null,"*","ram_test_vif",ram_test_vif);
    run_test("ram_test");
    end

endmodule