
class dff_coverage extends uvm_subscriber #(dff_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(dff_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  dff_sequence_item txn;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup dut_cov;
    option.per_instance= 1;
    option.comment     = "dut_cov";
    option.name        = "dut_cov";
    option.auto_bin_max= 4;
    D:coverpoint txn.d { 
        bins d_high={1};
        bins d_low ={0};
    }
    RST:coverpoint txn.rst { 
        bins rst_high={1};
        bins rst_low ={0};
    }
    DXRST:cross D,RST;
  endgroup:dut_cov;

  //----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  function void write(dff_sequence_item t);
    txn=t;
    dut_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:dff_coverage

