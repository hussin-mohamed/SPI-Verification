package seqr_packk;
import uvm_pkg::*;
`include "uvm_macros.svh"
import sequence_itemmm::*;
class sqrrr_class extends uvm_sequencer #(seq_itemmm);
    `uvm_component_utils(sqrrr_class)

    function new(string name = "sqrrr_class" , uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass 
    
endpackage