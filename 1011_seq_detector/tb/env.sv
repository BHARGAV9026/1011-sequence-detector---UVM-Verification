class env extends uvm_env;
 `uvm_component_utils(env)
 agent agth;
 scoreboard sbh;
 agent_config agt_cfg;
 
 function new(string name="env", uvm_component parent);
   super.new(name,parent);
 endfunction
 
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   agt_cfg=agent_config::type_id::create("agt_cfg");
   uvm_config_db#(agent_config)::set(this,"*","agent_config",agt_cfg);
   
   agth= agent::type_id::create("agth",this);
   sbh= scoreboard::type_id::create("sbh",this);
   
 endfunction
 
 function void end_of_elaboration_phase(uvm_phase phase);
   uvm_top.print_topology();
 endfunction
 
 function void connect_phase(uvm_phase phase);
   begin
    agth.mon.ap.connect(sbh.xtn_fifo.analysis_export);
   end
 endfunction
 
 endclass      