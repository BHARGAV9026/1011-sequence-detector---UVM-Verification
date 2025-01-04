class test extends uvm_test;
 `uvm_component_utils(test)
  env envh;
  sequenc seqh;
  agent_config agt_cfg;
  
  function new(string name="test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase  phase);
    super.build_phase(phase);
    envh=env::type_id::create("envh",this);
    seqh=sequenc::type_id::create("seqh");
    
    agt_cfg=agent_config::type_id::create("agt_cfg");
    
    if(!uvm_config_db#(virtual inf)::get(this," ","in",agt_cfg.vif))
      `uvm_fatal("VIF CONFIG","cannot get()interface vif from SRC_AGT_CONFIG . Have you set() it?") 
      
    uvm_config_db #(agent_config)::set(this,"*","agent_config",agt_cfg);
    
  endfunction
  
  task run_phase(uvm_phase phase);
    begin
        phase.raise_objection(this);
          seqh.start(envh.agth.seqr);
        phase.drop_objection(this);
   end
  endtask
  
endclass
   