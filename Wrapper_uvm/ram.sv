module ram (ram_inter.DUT ram_test_vif);
    parameter MEM_DEPTH =256;
    parameter ADDR_SIZE =8;
    bit [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
    reg [ADDR_SIZE-1:0] write_address ,  read_address;

    always @(posedge ram_test_vif.clk) begin
        if (~ram_test_vif.rst_n) begin
            ram_test_vif.dout <= 0;
            ram_test_vif.tx_valid <= 0;
        end else begin
            if (ram_test_vif.rx_valid) begin
                if (ram_test_vif.din[9:8] == 2'b00) begin
                    write_address <= ram_test_vif.din[7:0];
                    ram_test_vif.tx_valid <= 0;
                end else if (ram_test_vif.din[9:8] == 2'b01) begin
                    mem[write_address] <= ram_test_vif.din[7:0];
                    ram_test_vif.tx_valid <= 0;
                end else if (ram_test_vif.din[9:8] == 2'b10) begin
                    read_address <= ram_test_vif.din[7:0];
                    ram_test_vif.tx_valid <= 0;
                end else if (ram_test_vif.din[9:8] == 2'b11) begin
                    ram_test_vif.dout <= mem[read_address];
                    ram_test_vif.tx_valid <= 1;
                end
            end
        end  
    end
        
endmodule