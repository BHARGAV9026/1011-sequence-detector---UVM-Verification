module seq_det(input clk,rstn,din,
               output dout);
               
    parameter s0=3'b000,
              s1=3'b001,
              s2=3'b010,
              s3=3'b011,
              s4=3'b100;
    reg[2:0] pst,nst;
    
    always@(posedge clk)
     begin
       if(!rstn)
          pst <= s0;
       else
          pst <= nst;
     end
     
     always@(*)
      begin
         case(pst)
           s0 : if(din)
                   nst=s1;
                else
                   nst=s0;
           s1: if(din)
                  nst=s1;
               else
                  nst=s2;
           s2: if(din)
                  nst=s3;
               else
                  nst=s0;
           s3: if(din)
                 nst=s4;
               else
                 nst=s2;
           s4: if(din)
                  nst=s1;
               else
                  nst=s2;
           default: nst=s0;
         endcase
      end
     
     assign dout= (pst==s4)?1:0;
     
   endmodule