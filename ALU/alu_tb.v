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