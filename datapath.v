module datapath (
    input lda,ldb,sel1,sel2,sel3,clk,
    input [15:0] data,
    output Lt, Gt, Et
);
    wire [15:0] A_out, B_out,X_out, Y_out, Sub_out, bus;

    pipo #(.bits(16)) pipo1 (.d_in(bus), .clk(clk),.load(lda),.q(A_out)) ;
    pipo #(.bits(16)) pipo2 (.d_in(bus), .clk(clk),.load(ldb),.q(B_out)) ;
    mux_2x1 #(.width(16)) mux_1 (.in0(A_out), .in1(B_out), .sel(sel1), .out(X_out));
    mux_2x1 #(.width(16)) mux_2 (.in0(A_out), .in1(B_out), .sel(sel2), .out(Y_out));
    mux_2x1 #(.width(16)) mux_3 (.in0(data), .in1(Sub_out), .sel(sel3), .out(bus));
    subtractor #(.bits(16)) sub(.in1(X_out),.in2(Y_out),.out(Sub_out));
    comp #(.bits(16)) comp1 (.in1(A_out), .in2(B_out), .Lt(Lt), .Gt(Gt), .Et(Et));
endmodule