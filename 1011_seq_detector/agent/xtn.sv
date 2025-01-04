class xtn extends uvm_sequence_item;
   `uvm_object_utils(xtn)
    rand bit din;
    bit dout,rstn;
    
    static int index;             // Static index to track the current bit in the sequence
    static bit [13:0] seq_pattern = 14'b00110111011101; // 14-bit sequence pattern

    
   // constraint c1 { din inside{1,0};}
   // constraint c2 { din dist {0:/20,1:/80};}
   
  //  constraint basic_seq {din inside {4'b1011};}  // At least one occurrence of '1011'data inside {4'b1011};}
   // constraint random_patterns {foreach (din[i]) din[i] inside {1'b0, 1'b1}; }  // Random stream of bits
  // Sequence with overlapping detection
   // constraint overlapping { din == {8'b1101011};  // Ensure the stream includes overlapping '1011'
    
    
    
    
    // Constraint to enforce the specific sequence
    constraint c_generate_sequence {
        din == seq_pattern[index];
    }
    
     // Increment the index to cycle through the sequence
    function void increment_index();
        index = (index + 1); // Loop back after the 14th bit
    endfunction  
    
    
     virtual function void do_print(uvm_printer printer);
      printer.print_field("din",this.din,1,UVM_BIN);
			printer.print_field("rstn",this.rstn,1,UVM_BIN);
			printer.print_field("dout",this.dout,1,UVM_BIN);
    endfunction
    
endclass
			