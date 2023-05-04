module FA1bit (input A,B,C_in, output Sum, C_out);
assign Sum = A ^ B ^ C_in;
assign C_out = (A&B) | (B&C_in) | (A&C_in);
endmodule

module FA8bit #(parameter n =8)(input [n-1:0]a,b , input c_in, output [n-1:0]sum, output c_out);
wire [n-1:0] b_xored;
wire [n:0] c;
assign c[0] = c_in;
assign c_out = c[n];

generate
genvar i; 
for(i = 0 ; i<8; i=i+1) begin
assign b_xored[i] = b[i]^c[0];
end 
for (i = 0; i<8; i=i+1) begin
FA1bit FA(.A(a[i]),.B(b_xored[i]),.C_in(c[i]),.Sum(sum[i]),.C_out(c[i+1]));
end
endgenerate 
endmodule

module ALU #(parameter n =8)(input [n-1:0]a,b, input [2:0] op, input c_in, output reg [7:0] out, output wire c_out, output reg c_flag, output reg zero);
wire [7:0] sum;
FA8bit adder(.a(a),.b(b),.c_in(c_in),.sum(sum),.c_out(c_out));
always @(*) begin
case(op)
3'b000: out <= sum;
3'b001: out <= sum;
3'b010: out <= a&b;
3'b011: out <= a|b;
3'b100: out <= a^b;
3'b101: out <= (a>b)?1'b1:1'b0;
3'b110: out <= a<<1;
3'b111: out <= b<<1;
default: out <= 8'b0;
endcase
zero = (out==8'b0);
c_flag = (a>b)?1'b1:1'b0;
end 
endmodule

`timescale 1ns/1ps
module alu_tb;
reg [7:0] a,b;
reg[2:0] op;
reg c_in;

wire [7:0] out;
wire cout;
wire cflag;
wire zero;

ALU dut (.a(a),.b(b),.op(op),.c_in(c_in), .out(out), .c_out(c_out), .c_flag(c_flag), .zero(zero));
initial 
begin 
a = 8'd95;
b = 8'd14;
op= 3'b000;
c_in = op[0];
#10;
op= 3'b001;
c_in = op[0];
#10;
op= 3'b010;
c_in = op[0];
#10;
op= 3'b011;
c_in = op[0];
#10;
op= 3'b100;
c_in = op[0];
#10;
op= 3'b101;
c_in = op[0];
#10;
op= 3'b110;
c_in = op[0];
#10;
op= 3'b111;
c_in = op[0];
#10;
end
endmodule
