class scoreboard extends uvm_component;

    uvm_tlm_analysis_fifo#(xtn) xtn_fifo;
    int shift_reg[3:0]; // Shift register to store last 4 bits
    bit expected_detected;
   
    `uvm_component_utils(scoreboard)
     xtn xtn2;
     
     covergroup cg;
	  	option.per_instance = 1;
	 	  d_in : coverpoint xtn2.din{
							bins  zero={0};
              bins one={1};}
	
		 d_out : coverpoint xtn2.dout{
							bins fail  = {0};
							bins pass= {1};	}
     resetn : coverpoint xtn2.rstn{
                 bins set= {0};
                 bins reset={1};}            
	   endgroup
     
  function new(string name="scoreboard",uvm_component parent);
      super.new(name,parent);
      cg=new();
      xtn_fifo=new("xtn_fifo",this);
  endfunction


    // Process items received from the monitor

      
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      xtn2=xtn::type_id::create("xtn2");
   endfunction
     
     
    task run_phase(uvm_phase phase);
     super.run_phase(phase);
      forever
         begin
              xtn_fifo.get(xtn2);
             `uvm_info(get_type_name(),$sformatf("printing from XTN_FIFO in SB: %s", xtn2.sprint()),UVM_LOW)
              cg.sample();
              compare();
           end
     endtask
    
     // Process items received from the monitor
    virtual task compare();
        // Shift in the new bit to the shift register
        shift_reg[3] = shift_reg[2];
        shift_reg[2] = shift_reg[1];
        shift_reg[1] = shift_reg[0];
        shift_reg[0] = xtn2.din;

        // Check if the shift register matches "1011"
        expected_detected = 4'b1011;

        // Compare expected_detected with DUT's detected signal
        if (xtn2.dout !== expected_detected)
               begin
            `uvm_error("SCOREBOARD", $sformatf("Mismatch! Input: %p, Expected: %b, DUT: %b",
                                               shift_reg, expected_detected, xtn2.dout))
               end 
        else 
            begin
            `uvm_info("SCOREBOARD", $sformatf("Match! Input: %p, Expected: %b, DUT: %b",
                                              shift_reg, expected_detected, xtn2.dout), UVM_LOW)
            end
    endtask
endclass
  