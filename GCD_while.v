module GCD_while (
    input [15:0] a, b,
    output reg [15:0] gcd_out
);

    reg [15:0] xs, ys;
    integer i;  

    always @(*) begin
        xs = a;
        ys = b;
        i = 0;  // safety counter to avoid infinite loops

        while (xs != 0 && ys != 0 && i < 100) begin
            if (xs > ys)
                xs = xs % ys;
            else
                ys = ys % xs;
            i = i + 1;
        end

        if (xs == 0)
            gcd_out = ys;
        else
            gcd_out = xs;
    end
endmodule
