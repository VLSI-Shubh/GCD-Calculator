`timescale 1ns/1ns
`include "datapath.v"
`include "controller.v"
`include "mux_2x1.v"
`include "subtractor.v"
`include "comparator.v"
`include "pipo.v"

module gcd_tb ();
    reg [15:0] data_in;
    reg clk, rst, start;
    wire done;
    wire Lt, Gt, Et;
    wire sel1, sel2, sel3, lda, ldb;

    // Instantiate datapath and controller
    datapath dp1 (
        .lda(lda), .ldb(ldb), .sel1(sel1), .sel2(sel2), .sel3(sel3),
        .clk(clk), .data(data_in), .Lt(Lt), .Gt(Gt), .Et(Et)
    );

    controller ctlr1 (
        .Lt(Lt), .Gt(Gt), .Et(Et),
        .start(start), .clk(clk), .rst(rst),
        .sel1(sel1), .sel2(sel2), .sel3(sel3), .lda(lda), .ldb(ldb),
        .done(done)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
    rst = 1;
    start = 0;
    data_in = 0;

    $dumpfile("gcd_tb.vcd");
    $dumpvars(0, gcd_tb);

    #10 rst = 0;

    // Load first number (A)
    #10 data_in = 81;
    #10 start = 1;

    // Set second number BEFORE controller goes to S1
    #10 data_in = 27;

    // Wait for done or timeout after 2000 clock cycles
    repeat (2000) @(posedge clk);
    if (done) begin
        $display("GCD calculation completed");
        $display("Final result in A_out: %d", dp1.A_out);
        $display("Final result in B_out: %d", dp1.B_out);
    end else begin
        $display("Timeout! 'done' signal not asserted.");
    end

    $finish;
end


    // Monitor outputs and state for debugging
    initial begin
        $monitor("Time=%0t | A_out=%d | B_out=%d | done=%b | state=%b", 
                 $time, dp1.A_out, dp1.B_out, done, ctlr1.ps);
    end
endmodule