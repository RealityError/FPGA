`timescale 1ns/1ns

module tb_usrt_byte_tx;

        reg Clk;
        reg Rst_n;
        reg [7:0] data_byte;
        reg send_en;
        reg [2:0] baud_set;

        wire Rs232_Tx;
        wire Tx_Done;
        wire uart_state;

uart_byte_tx uart_byte_tx(
        .Clk(Clk),
        .Rst_n(Rst_n),
        .data_byte(data_byte),
        .send_en(send_en),
        .baud_set(baud_set),

        .Rs232_Tx(Rs232_Tx),
        .Tx_Done(Tx_Done),
        .uart_state(uart_state)
);

initial Clk=1;
always #5 Clk = ~Clk;

initial begin
        Rst_n = 1'b0;
        data_byte = 8'd0;
        send_en = 1'd0;
        baud_set = 3'd4;
        #10
        Rst_n = 1'b1;
        #10
        data_byte = 8'd12;
        send_en = 1'd1;
        #100
        send_en = 1'd0;

        @(posedge Tx_Done)

        #100
        data_byte = 8'd55;
        send_en = 1'd1;
        #10
        send_en = 1'd0;

        @(posedge Tx_Done)
        #100;
        $stop;
end
endmodule