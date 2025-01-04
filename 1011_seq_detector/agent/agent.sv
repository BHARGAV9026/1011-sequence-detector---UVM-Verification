
class agent extends uvm_component;
  `uvm_component_utils(agent)
     driver drv;
     sequencer seqr;
     monitor mon;
     agent_config agt_cfg;
     
  function new(string name="agent", uvm_component parent);
       super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
       super.build_phase(phase); 
       if(!uvm_config_db#(agent_config)::get(this,"","agent_config",agt_cfg))  
         `uvm_fatal("AGENT_CONFIG","cannot get() agt_cfg im driver")
       mon=monitor::type_id::create("mon",this);
       
   if(agt_cfg.is_active==UVM_ACTIVE)
     begin
        drv=driver::type_id::create("drv",this);
        seqr=sequencer::type_id::create("seqr",this);
     end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(agt_cfg.is_active==UVM_ACTIVE)
      begin
         drv.seq_item_port.connect(seqr.seq_item_export);
      end
  endfunction
  
endclass