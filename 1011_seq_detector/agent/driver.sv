class driver extends uvm_driver #(xtn);
  `uvm_component_utils(driver)
   virtual inf.DRV_MP vif;
   agent_config agt_cfg;
  
  function new(string name="driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
    if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))  
      `uvm_fatal("AGENT_CONFIG","cannot get() agt_cfg im driver")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    vif= agt_cfg.vif;
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    /*@(vif.drv_cb);
     vif.drv_cb.rstn<=1'b0; */
    @(vif.drv_cb);
      vif.drv_cb.rstn<=1'b1; 
        forever
           begin
             seq_item_port.get_next_item(req);
             send_to_dut(req);
             seq_item_port.item_done();
           end
  endtask
  
  task send_to_dut(xtn req);
   begin
     //@(vif.drv_cb);
      vif.drv_cb.din<=req.din;
     @(vif.drv_cb);
    `uvm_info(get_type_name, $sformatf("Printing from  DRIVER : %s", req.sprint()), UVM_LOW)
   end
 endtask
endclass

  