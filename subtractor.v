module subtractor #(
    parameter bits =4
) (
    input [bits-1:0] in1, in2,
    output [bits-1:0] out
);

    assign out = in1 - in2;

endmodule