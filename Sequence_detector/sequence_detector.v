module detector_1101(
    input clk,nrst,in,
    output reg detector
    );
    
    localparam A=3'b000,
               B=3'b001,
               C=3'b010,
               D=3'b011,
               E=3'b100;
  reg [2:0] state,next_state;

    always @(posedge clk, negedge nrst)
            begin
                if (!nrst)
                    state <= A;
                else
                    state <= next_state;
            end
            
      always@(*)
      begin
        // default output to avoid latches
                next_state = state; // keep the same state
                detector = 1'b0;
      case(state)
        A:
               if(in)
                   next_state = B;
                else 
                   next_state = A;
        B: 
                if(in)
                    next_state = C;
                else
                    next_state = A;
           
        C:
               if(~in)
                     next_state = D;
               else
                      next_state = B;
           
        D: 
          if(in) begin
                      next_state = E;
                      detector=1'b1;
          end
                 else
                      next_state = A;
           
        E:        
          if(in) 
                    next_state = C;
                    
                 else
                     next_state = A;
        
        default: next_state = A;
                                
      endcase
      end   
endmodule


