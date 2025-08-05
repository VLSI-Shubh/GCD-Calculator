`timescale 1ns / 1ps
`include "GCD_while.v"

module GCD_while_tb();

    reg [15:0] a, b;
    wire [15:0] gcd_out;

    // Instantiate the GCD module
    GCD_while uut (
        .a(a),
        .b(b),
        .gcd_out(gcd_out)
    );

    initial begin
        // Test cases
        a = 143; b = 72;   // Expected GCD: 1
        #10;
        $display("GCD(%d, %d) = %d", a, b, gcd_out);

        a = 48; b = 18;    // Expected GCD: 6
        #10;
        $display("GCD(%d, %d) = %d", a, b, gcd_out);

        a = 56; b = 98;    // Expected GCD: 14
        #10;
        $display("GCD(%d, %d) = %d", a, b, gcd_out);

        a = 100; b = 25;   // Expected GCD: 25
        #10;
        $display("GCD(%d, %d) = %d", a, b, gcd_out);

        a = 270; b = 192;  // Expected GCD: 6
        #10;
        $display("GCD(%d, %d) = %d", a, b, gcd_out);

        $finish;
    end

endmodule
