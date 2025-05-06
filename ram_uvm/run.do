vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
#add wave -position insertpoint sim:/top/ram_test_vif/*
add wave -position insertpoint  \
sim:/top/ram_test_vif/ADDR_SIZE \
sim:/top/ram_test_vif/clk \
sim:/top/ram_test_vif/din \
sim:/top/ram_test_vif/dout \
sim:/top/ram_test_vif/MEM_DEPTH \
sim:/top/ram_test_vif/rst_n \
sim:/top/ram_test_vif/rx_valid \
sim:/top/ram_test_vif/tx_valid
add wave -position insertpoint  \
sim:/top/dut/read_address \
sim:/top/dut/write_address
coverage save ram_tb.ucdb -onexit
run -all
coverage exclude -src ram.sv -allfalse -line 13 -code b
#vcover report ram_tb.ucdb -details -all -output coverage_rpt_ram.txt