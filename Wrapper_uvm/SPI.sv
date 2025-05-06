module Spi_slave (Spi_slave_inter.dut Spi_slave_test_vif);
    parameter IDLE = 'b000 , CHK_CMD = 'b001 , WRITE = 'b010 , READ_ADD = 'b011 , READ_DATA = 'b100;

    

   (* fsm_encoding = "gray" *)

    reg [2:0] ns,cs;
    reg ADD_OR_DATA ;
    reg [4:0] counter;
    reg updwn;

    always @(posedge Spi_slave_test_vif.clk) begin
        if(~Spi_slave_test_vif.rst_n)begin
        cs <= IDLE; 
        
        end
        else 
        cs <= ns;
    end

    always @(cs,Spi_slave_test_vif.MOSI,Spi_slave_test_vif.SS_n) begin
        case (cs)
            IDLE:begin
                if (Spi_slave_test_vif.SS_n) ns = IDLE;
                else ns = CHK_CMD;
            end

            CHK_CMD: begin
                if (Spi_slave_test_vif.SS_n) ns = IDLE;
                else begin
                    if (Spi_slave_test_vif.MOSI) begin
                        if (ADD_OR_DATA) ns = READ_DATA;
                        else  ns = READ_ADD;
                    end
                    else  ns = WRITE; 
                end
            end

            WRITE:begin
                if (Spi_slave_test_vif.SS_n) ns = IDLE;
                else ns = WRITE;
            end 

            READ_ADD: begin
                if (Spi_slave_test_vif.SS_n) ns = IDLE;
                else ns = READ_ADD;
            end
            
            READ_DATA: begin
                if (Spi_slave_test_vif.SS_n) ns = IDLE;
                else ns = READ_DATA;
            end
            default: ns = IDLE;
        endcase
    end

    always @(posedge Spi_slave_test_vif.clk ) begin
        if(~Spi_slave_test_vif.rst_n)begin
           Spi_slave_test_vif.rx_valid <= 0; 
           Spi_slave_test_vif.rx_data <=0;
           ADD_OR_DATA <= 0;
           Spi_slave_test_vif.MISO <= 0;
           counter <= 0;
           updwn <=0;
        end
        
        else begin
            if (~updwn) begin
            counter  <= counter + 1;    
            end
            else
            counter  <=counter-1;
        case (cs)


        WRITE:begin

            updwn <=0;
            Spi_slave_test_vif.MISO <= 0;

            if (counter == 9) begin
               counter <= 0;
               Spi_slave_test_vif.rx_valid <= 1;  
            end

            else  Spi_slave_test_vif.rx_valid <= 0;

            Spi_slave_test_vif.rx_data <= {Spi_slave_test_vif.rx_data[8:0],Spi_slave_test_vif.MOSI};
        end 


        READ_ADD: begin

            updwn <=0;
            Spi_slave_test_vif.MISO <= 0;

            if (counter == 9) begin
               counter <= 0;
               Spi_slave_test_vif.rx_valid <= 1;
            ADD_OR_DATA <= 1;  
            end

            else  Spi_slave_test_vif.rx_valid <= 0;

            Spi_slave_test_vif.rx_data <= {Spi_slave_test_vif.rx_data[8:0],Spi_slave_test_vif.MOSI};
        end 


        READ_DATA: begin

        if (counter<=9 && (~updwn)) begin 
            Spi_slave_test_vif.rx_valid <= 0;
            Spi_slave_test_vif.rx_data <= {Spi_slave_test_vif.rx_data[8:0],Spi_slave_test_vif.MOSI};
        end

        if (counter == 9) begin
                counter<=8;
               Spi_slave_test_vif.rx_valid <= 1;
               updwn <=1;  
               ADD_OR_DATA <= 0; // fixed error
            end  

            if (Spi_slave_test_vif.rx_valid && Spi_slave_test_vif.tx_valid) Spi_slave_test_vif.MISO <= Spi_slave_test_vif.tx_data[counter];

        end
            default:begin
           Spi_slave_test_vif.rx_valid <= 0; 
           Spi_slave_test_vif.rx_data <=0;
           Spi_slave_test_vif.MISO <= 0;
           counter <= 0;
           updwn <=0;
           end
        endcase 
        end
    end
endmodule