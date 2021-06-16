class dff_sequencer extends uvm_sequencer#(dff_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(dff_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="dff_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:dff_sequencer

