`timescale 1ns / 1ns

module detector_tb;
    // declare internal testbench signals
    localparam T = 20; // clk period
    reg clk, nrst,in;
    wire detector;
    
    
     // Instantiate the binary counter module with 4 bits
      detector_1101 dut (
           .clk(clk),
           .nrst(nrst),
           .in(in),
           .detector(detector)
       );
// Generate clock signal
           always begin
               clk = 1'b1;
               #(T/2);
               clk = 1'b0;
               #(T/2);
           end
  // rst
             initial begin
                 nrst = 1'b0;
                 #(T/4);
                 nrst = 1'b1;
             end
             
     
                 // Stimulus generation
                 initial begin
                     // initial values
                     in = 0;
                   repeat (2) @(posedge clk);
                     in = 1'b1;
                   repeat (2) @(posedge clk);
                     in = 1'b0;
                   @(posedge clk);
                     in = 1'b1;
                   repeat (2) @(posedge clk);
                                in = 1'b1;
                   repeat (2) @(posedge clk);
                                in = 1'b0;
                     $stop;
                 end
endmodule
