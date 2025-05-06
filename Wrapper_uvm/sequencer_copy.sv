package seqr_pack;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_itemm::*;
class sqrr_class extends uvm_sequencer #(seq_itemm);
    `uvm_component_utils(sqrr_class)

    function new(string name = "sqrr_class" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass 
    
endpackage