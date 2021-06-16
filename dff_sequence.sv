
/***************************************************
** class name  : dff_sequence
** description : generate ransom input for DUT
***************************************************/
class dff_sequence extends uvm_sequence#(dff_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(dff_sequence)            
  //----------------------------------------------------------------------------

  dff_sequence_item txn;
  int unsigned LOOP=50;

  //----------------------------------------------------------------------------
  function new(string name="dff_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(LOOP) begin
      txn=dff_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize();
      txn.rst=0;
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:dff_sequence

/***************************************************
** class name  : reset_sequence
** description : reset DUT1
***************************************************/
class reset_sequence extends dff_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(reset_sequence)      
  //----------------------------------------------------------------------------
  
  dff_sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="reset_sequence");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    txn=dff_sequence_item::type_id::create("txn");
    start_item(txn);
    txn.d   =0;
    txn.rst =1;
    finish_item(txn);
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : sequence_2
** description :
***************************************************/
class sequence_2 extends dff_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(sequence_2)      
  //----------------------------------------------------------------------------
  
  dff_sequence_item txn;
  int unsigned LOOP = 50;
  
  //----------------------------------------------------------------------------
  function new(string name="sequence_2");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    for(int i = 0;i<LOOP;i++) begin 
      if(i%3==0) begin 
        txn=dff_sequence_item::type_id::create("txn");
        start_item(txn);
        txn.randomize()with{txn.d==1;};
        txn.rst=0;
        finish_item(txn);
      end
      else begin
        txn=dff_sequence_item::type_id::create("txn");
        start_item(txn);
        txn.randomize()with{txn.d==0;};
        txn.rst=0;
        finish_item(txn);
      end
    end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass