class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  virtual inf.MON_MP vif;
  agent_config agt_cfg;
  uvm_analysis_port #(xtn) ap;
  
  function new(string name="monitor",uvm_component parent);
    super.new(name,parent);
    ap=new("ap",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))  
      `uvm_fatal("AGENT_CONFIG","cannot get() AGT_CFG im monitor")
      
  endfunction
  
  function void connect_phase(uvm_phase phase);
    vif= agt_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever
      begin
        collect_data();
      end
  endtask
  
  task collect_data();
   begin
     xtn xtn1;
     xtn1= xtn::type_id::create("xtn1");

      @(vif.mon_cb);
        xtn1.din = vif.mon_cb.din;
        xtn1.rstn = vif.mon_cb.rstn;
        xtn1.dout= vif.mon_cb.dout; 
        
     // @(vif.mon_cb); 
       ap.write(xtn1);
       
    `uvm_info(get_type_name, $sformatf("Printing from MONITOR : %s", xtn1.sprint()), UVM_LOW)

   end
   
  endtask
  
endclass
