package scoreborad_pckkk;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_itemmm::*;
class  ram_scoreborad extends uvm_scoreboard;
`uvm_component_utils(ram_scoreborad)

uvm_analysis_export #(seq_itemmm) sb_export;
uvm_tlm_analysis_fifo #(seq_itemmm) sb_fifo;
seq_itemmm item;
static int correct_count =0;
static int wrong_count =0;
logic  [7:0]dout_ref;
logic  tx_valid_ref;
parameter MEM_DEPTH =256;
parameter ADDR_SIZE =8;
bit [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
logic [ADDR_SIZE-1:0] write_address ,  read_address;
// define refrences variables
    function new(string name = "ram_scoreborad" , uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
      function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        sb_export=new("sb_export",this);
        sb_fifo=new("sb_fifo",this);
    endfunction 

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
    endfunction 
     task  run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
        sb_fifo.get(item);
        check_data();
        end
    endtask //
    task  check_data();
        reference_model();
        if (dout_ref==item.dout && tx_valid_ref==item.tx_valid) begin
            correct_count=correct_count+1;
        end
        else begin
            wrong_count=wrong_count+1;
        end
    endtask //
    task  reference_model();
        if (!item.rst_n) begin
            dout_ref = 8'h00;
            tx_valid_ref = 1'b0;
        end
        else
        begin
            if (item.rx_valid) begin
                if (item.rx_valid) begin
                if (item.din[9:8] == 2'b00) begin
                    write_address = item.din[7:0];
                    tx_valid_ref = 0;
                end else if (item.din[9:8] == 2'b01) begin
                    mem[write_address] = item.din[7:0];
                    tx_valid_ref = 0;
                end else if (item.din[9:8] == 2'b10) begin
                    read_address = item.din[7:0];
                    tx_valid_ref = 0;
                end else if (item.din[9:8] == 2'b11) begin
                    dout_ref = mem[read_address];
                    tx_valid_ref = 1;
                end
            end
            end
        end

    endtask
endclass 

    
endpackage