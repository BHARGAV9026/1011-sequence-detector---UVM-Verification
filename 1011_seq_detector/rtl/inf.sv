interface inf(input clk);
  bit din,rstn,dout;
  
  clocking drv_cb@(posedge clk);
   default input #1 output #1;
     output din;
     output rstn;
  endclocking
  
  clocking mon_cb@(posedge clk);
   default input #1 output #1;
    input dout;
    input din;
    input rstn;
   endclocking
   
   modport DRV_MP(clocking drv_cb);
   modport MON_MP(clocking mon_cb);
   
endinterface
  
    