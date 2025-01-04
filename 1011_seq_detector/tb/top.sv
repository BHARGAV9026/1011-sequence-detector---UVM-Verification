module top;

  import pkg::*; 
  import uvm_pkg::*;
  
   bit clk;
   always
   #5 clk=~clk;
   
  inf in(clk);
  seq_det DUT(.clk(clk),
              .din(in.din),
              .rstn(in.rstn),
              .dout(in.dout));
  
  initial
    begin
      uvm_config_db#(virtual inf)::set(null,"*","in",in);
      run_test();
    end
  endmodule
  