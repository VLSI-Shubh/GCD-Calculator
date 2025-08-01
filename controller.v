module controller (
    input Lt, Gt, Et, start, clk, rst,
    output reg sel1, sel2, sel3, lda,ldb,done
);
    parameter [2:0] S0 = 3'b000, 
                    S1 = 3'b001, 
                    S2 = 3'b010,  
                    S3 = 3'b011, 
                    S4 = 3'b100, 
                    S5 = 3'b101;
    reg [2:0] ps,ns;

// state transition logic
    always@(*) begin
        case (ps)
            S0:  if (start) begin
                ns = S1;
            end else begin
                ns = S0;
            end
            S1: ns = S2;
            S2: if (Et) begin
                ns = S5;
            end else begin
                if (Lt) begin
                    ns = S3;
                end else begin
                    if (Gt) begin
                      ns = S4;  
                    end 
                end
            end
            S3: if (Et) begin
                ns = S5;
            end else begin
                if (Lt) begin
                    ns = S3;
                end else begin
                    if (Gt) begin
                        ns = S4;
                    end 
                end
            end
            S4:if (Et) begin
                ns = S5;
            end else begin
                if (Lt) begin
                    ns = S3;
                end else begin
                    if (Gt) begin
                      ns = S4;  
                    end 
                end
            end
            S5: ns = S5;
            default: ns = S0;
        endcase
    end

// State memory 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps <= S0;
        end else begin
            ps <= ns; 
        end
    end
//output logic
    always @(*) begin
        sel1 = 0; sel2 = 0; sel3 = 0; lda = 0; ldb = 0; done = 0;
        case (ps)
            S0: begin
                if (start) begin
                    sel3 = 0; lda =1; ldb =0; done = 0;
                end else begin
                    sel3 = 0; lda =0; ldb =0; done = 0;
                end
            end 
            S1: begin
                lda =0 ;ldb = 1; done =0; sel3=0;  
            end
            S2: begin
                if (Et) begin
                    done = 1;sel3 = 1; lda = 0; ldb = 0;
                end else begin
                    if (Lt) begin
                        sel1 =1 ; sel2 = 0; sel3 = 1; done = 0;
                        lda =0; ldb =1;
                    end else begin
                        if (Gt) begin
                            sel1 =0; sel2 =1; sel3 =1; done =0;
                            lda =1; ldb =0;
                        end else begin
                            lda =0; ldb =0; sel1=0; sel2=0; sel3=1; done=0;
                        end
                    end
                end
            end
            S3: begin
                if (Et) begin
                    done = 1;
                end else begin
                    if (Lt) begin
                        sel1 =1 ; sel2 = 0; sel3 = 1; done = 0;
                        lda =0; ldb =1;
                    end else begin
                        if (Gt) begin
                            sel1 =0; sel2 =1; sel3 =1; done =0;
                            lda =1; ldb =0;
                        end else begin
                            lda =0; ldb =0; sel1=0; sel2=0; sel3=1; done=0;
                        end
                    end
                end
            end
            S4: begin
                if (Et) begin
                    done = 1;
                end else begin
                    if (Lt) begin
                        sel1 =1 ; sel2 = 0; sel3 = 1; done = 0;
                        lda =0; ldb =1;
                    end else begin
                        if (Gt) begin
                            sel1 =0; sel2 =1; sel3 =1; done =0;
                            lda =1; ldb =0;
                        end else begin
                            lda =0; ldb =0; sel1=0; sel2=0; sel3=1; done=0;
                        end
                    end
                end
            end
            S5: begin
                done =1; sel1 =0; sel2=0; sel3=0; lda =0; ldb =0;
            end
            default: begin
                done =0; sel1 =0; sel2=0; sel3=0; lda =0; ldb =0;
            end
        endcase
    end
endmodule