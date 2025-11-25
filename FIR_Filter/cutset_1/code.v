
module D_ff(
    input D_in,
    input rst,clk,
    output reg D_out
);
    always @(posedge clk) begin
        if (rst)
            D_out <= 1'b0;
        else
            D_out <= D_in;
    end
endmodule


module FIR_filter_5_Coefficient_Cutset_1(
    input X,clk,rst,
    input h0,h1,h2,h3,h4,
    output [1:0] Y
);
    wire X_1, X_2, X_3, X_4;
    wire [1:0]a1,a2,a3,a4,a5;
    wire [1:0] y1,y2,y3;

    D_ff A1(.D_in(X),   .clk(clk), .rst(rst), .D_out(X_1));
    D_ff A2(.D_in(X_1), .clk(clk), .rst(rst), .D_out(X_2));
    D_ff A3(.D_in(X_2), .clk(clk), .rst(rst), .D_out(X_3));
    D_ff A4(.D_in(X_3), .clk(clk), .rst(rst), .D_out(X_4));

    assign a1 = h0 * X;
    assign a2 = h1 * X_1;
    assign a3 = h2 * X_2;
    assign a4 = h3 * X_3;
    assign a5 = h4 * X_4;

    assign y1 = {1'b0, a1} + {1'b0, a2};
    assign y2 = y1 + {1'b0, a3};
    assign y3 = y2 + {1'b0, a4};
    assign Y  = y3 + {1'b0, a5};

endmodule
