
class dff_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(dff_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="dff_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(dff_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    dff_sequence_item txn=dff_sequence_item::type_id::create("txn",this);
    forever
    begin
      sample_dut(txn);
      ap_mon.write(txn);
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task sample_dut(output dff_sequence_item txn);
    dff_sequence_item t = dff_sequence_item::type_id::create("t");
    @(vif.cb);
    #1;
    t.rst  = vif.rst;
    t.d    = vif.d;
    t.q    = vif.cb.q;
    txn    = t;
  endtask
  //----------------------------------------------------------------------------

endclass:dff_monitor

