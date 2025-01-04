class sequenc extends uvm_sequence #(xtn);
  `uvm_object_utils(sequenc)
  
  function new(string name="sequenc");
    super.new(name);
  endfunction
  
  task body();
  
   for (int i = 0; i < 14; i++) 
     begin
        req= xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
        finish_item(req);
        req.increment_index();
     end
     
  endtask

endclass
