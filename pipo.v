module pipo #(parameter bits = 16)(
    input [bits-1:0] d_in,
    input clk, load,
    output reg [bits-1:0] q
);
    always @(posedge clk) begin
        if (load)
            q <= d_in;
    end
endmodule
