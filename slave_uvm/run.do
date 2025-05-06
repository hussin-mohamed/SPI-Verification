vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/top/Spi_slave_test_vif/*
add wave -position insertpoint  \
sim:/sequence_item::seq_item::counter \
sim:/sequence_item::seq_item::packet \
sim:/sequence_item::seq_item::packet_old
add wave -position insertpoint  \
sim:/top/dut/ADD_OR_DATA \
sim:/top/dut/counter \
sim:/top/dut/cs \
sim:/top/dut/ns \
sim:/top/dut/updwn
coverage save spi_tb.ucdb -onexit
run -all
#vcover report spi_tb.ucdb -details -all -output coverage_rpt_slave.txt