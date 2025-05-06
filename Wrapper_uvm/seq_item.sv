package sequence_item;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    class seq_item extends uvm_sequence_item;
        `uvm_object_utils(seq_item)
        function new(string name = "seq_item");
            super.new(name);
        endfunction //new()
        rand logic SS_n,rst_n;
        logic MOSI;
        static rand logic [10:0] packet;
        static logic [10:0] packet_old;
        static int counter;
        logic MISO;
        constraint ss_n_asserted_reset_deasserted {
            SS_n == 0;
            rst_n == 1;
        }
        constraint ss_n_deasserted_reset_asserted {
            SS_n == 1;
            rst_n == 0;
        }
        constraint ss_n_asserted_reset_asserted {
            SS_n == 0;
            rst_n == 0;
        }
        constraint ss_n_deasserted_reset_deasserted {
            SS_n == 1;
            rst_n == 1;
        }
        constraint ss_n_randomized_reset_randomized {
            SS_n dist {0:=50, 1:=40};
            rst_n dist {1:=50, 0:=70};
        }
        function void post_randomize();
            if (counter!=0 && rst_n!=0 && SS_n==0)
            begin
                if (counter==12) begin
                    counter=counter-1;
                    packet=packet_old;
                end
                else begin
                packet=packet_old;
                MOSI=packet[counter-1];
                counter=counter-1;
                if (counter==0) begin
                    counter=11;
                end
                end
            end
            else if(rst_n==0)
            begin
                counter=12;
                packet[10:8]=3'b000;  
            end
            else if (SS_n==1) begin
                counter=12;   
                if (packet_old[10:8]==3'b000) begin
                    packet[10:8]=3'b001;
                end
                    
                else if (packet_old[10:8]==3'b110) begin
                    packet[10:8]=3'b111;
                end
                else if (packet_old[10:8]==3'b001) begin
                    packet[10:8]=3'b110;
                end
                else if (packet_old[10:8]==3'b111) begin
                    packet[10:8]=3'b000;
                end
                if (packet[10:8]==3'b001&& packet_old[10:8]!=3'b000) begin
                    packet[10:8]=3'b000;
                end
                else if (packet[10:8]==3'b111&& packet_old[10:8]!=3'b110) begin
                    packet[10:8]=3'b110;
                end 
            end
            packet_old=packet;
        endfunction
        
    endclass //seq_item extends superClass
endpackage