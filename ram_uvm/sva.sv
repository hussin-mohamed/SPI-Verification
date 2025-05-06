module sva (
    ram_inter.DUT ram_test_vif
);
reset: assert property (@(posedge ram_test_vif.clk) !ram_test_vif.rst_n |=> ram_test_vif.dout==0 && ram_test_vif.tx_valid==0);
reset_cover: cover property (@(posedge ram_test_vif.clk) !ram_test_vif.rst_n |=> ram_test_vif.dout==0 && ram_test_vif.tx_valid==0);
tx_valid:assert property (@(posedge ram_test_vif.clk) disable iff(!ram_test_vif.rst_n) ram_test_vif.din[9:8] == 2'b11 && ram_test_vif.rx_valid |=> ram_test_vif.tx_valid==1);
rx_valid_cover: cover property (@(posedge ram_test_vif.clk) disable iff(!ram_test_vif.rst_n) ram_test_vif.din[9:8] == 2'b11 && ram_test_vif.rx_valid |=> ram_test_vif.tx_valid==1);
    endmodule