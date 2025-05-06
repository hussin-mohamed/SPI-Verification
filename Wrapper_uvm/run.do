vlib work
vlog -f src_files.list +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/top/spi_test_vif/*
coverage save spi_tb.ucdb -onexit
run -all
coverage exclude -cvgpath /coverage_pkgg/Spi_slave_cover/g1/packet /coverage_pkgg/Spi_slave_cover/g1/packet_with_reset /coverage_pkgg/Spi_slave_cover/g1/packet_with_ssn
coverage exclude -src ram.sv -allfalse -line 13 -code b
#vcover report spi_tb.ucdb -details -all -output coverage_rpt_spi.txt