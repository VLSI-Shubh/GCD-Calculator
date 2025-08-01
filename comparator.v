module comp #(
    parameter bits = 4
) (
    input [bits-1:0] in1, in2,
    output Lt, Gt, Et
);

        assign Lt = in1 < in2;
        assign Et = in1 == in2;
        assign Gt = in1 > in2;

endmodule