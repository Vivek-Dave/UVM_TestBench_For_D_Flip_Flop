class dff_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic  d;  //i/p
  logic rst;

  logic q;        //o/p

  //---------------- register dff_sequence_item class with factory --------
  `uvm_object_utils_begin(dff_sequence_item) 
     `uvm_field_int( d   ,UVM_ALL_ON)
     `uvm_field_int( rst ,UVM_ALL_ON)
     `uvm_field_int( q   ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="dff_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("d=%0b  rst=%0b", d,rst));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("q=%0b",q));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), " || ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:dff_sequence_item
