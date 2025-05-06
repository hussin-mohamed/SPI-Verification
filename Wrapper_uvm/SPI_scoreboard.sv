package scoreborad_pck;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import sequence_item::*;
class  spi_scoreborad extends uvm_scoreboard;
`uvm_component_utils(spi_scoreborad)

uvm_analysis_export #(seq_item) sb_export;
uvm_tlm_analysis_fifo #(seq_item) sb_fifo;
seq_item item;
static int correct_count =0;
static int wrong_count =0;
int counter=11;
int counter_tx=8;
logic MoSI_expected;
logic[9:0] rx_data_expected;
logic[7:0]tx_data;
logic rx_valid_expected;
bit MOSI_is_ready;
bit tx_is_ready;
parameter MEM_DEPTH =256;
parameter ADDR_SIZE =8;
bit [ADDR_SIZE-1:0] addr;
bit [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
    function new(string name = "spi_scoreborad" , uvm_component parent = null);
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
        update_variables();
        if(item.MISO==MoSI_expected)begin
                    correct_count=correct_count+1;
                end
        else begin
            wrong_count = wrong_count + 1;
            `uvm_info("SCOREBOARD", $sformatf("Time: %0t | Expected ->MISO: %0b | Actual -> MISO: %0b",$time, MoSI_expected, item.MISO), UVM_MEDIUM)
        end
        end
    endtask //
    task update_variables();
        if(item.rst_n==1 && item.SS_n==0 &&!tx_is_ready) begin
            if(counter==11 )begin
                counter=counter-1;
                rx_valid_expected=0;
                rx_data_expected=0;
                MoSI_expected=0;
            end
            else if (counter==10) begin
                counter=counter-1;
                rx_valid_expected=0;
                rx_data_expected=0;        
            end
            else if(counter!=0)begin
                counter=counter-1;
                rx_data_expected={rx_data_expected[8:0],item.MOSI};
                rx_valid_expected=0;
            end
            else if (counter==0)begin
                rx_data_expected={rx_data_expected[8:0],item.MOSI};
                rx_valid_expected=1;
                if(!item.SS_n&&rx_data_expected[9:8]!=2'b11)
                counter = 9;
                else
                counter=11;

                if(rx_data_expected[9:8]==2'b00)begin
                addr=rx_data_expected[7:0];
                end
                else if(rx_data_expected[9:8]==2'b01)begin
                mem[addr]=rx_data_expected[7:0];
                end
                else if(rx_data_expected[9:8]==2'b10)begin
                addr=rx_data_expected[7:0];
                end
                else if (rx_data_expected[9:8]==2'b11) begin
                    tx_is_ready=1;
                end
            end
        end
        else if(item.rst_n==0) begin
            counter=11;
            counter_tx=8;
            rx_data_expected=0;
            rx_valid_expected=0;
            MoSI_expected=0;
            tx_is_ready=0;
        end
        else if (item.SS_n==1&&!tx_is_ready) begin
            counter=11;
            tx_is_ready=0;
            counter_tx=8;
            
            rx_data_expected=0;
            rx_valid_expected=0;
        end
        else if (item.SS_n==1&&tx_is_ready)begin
            counter=11;
            tx_is_ready=0;
            MoSI_expected=tx_data[counter_tx];
            counter_tx=8;
        end
        else if (tx_is_ready) begin
            if (counter_tx==8) begin
                tx_data=mem[addr];
                counter_tx=counter_tx-1;
            end
            else if (counter_tx!=0) begin
                MoSI_expected=tx_data[counter_tx];
                counter_tx=counter_tx-1;
            end
            else if (counter_tx==0) begin
                MoSI_expected=tx_data[counter_tx];
                counter_tx=8;
            end
        end

    endtask
endclass 

    
endpackage