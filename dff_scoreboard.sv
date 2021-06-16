
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class dff_scoreboard extends uvm_scoreboard;
  //----------------------------------------------------------------------------
  `uvm_component_utils(dff_scoreboard)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_analysis_imp_drv #(dff_sequence_item, dff_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(dff_sequence_item, dff_scoreboard) aport_mon;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_tlm_fifo #(dff_sequence_item) expfifo;
  uvm_tlm_fifo #(dff_sequence_item) outfifo;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic t_d;
  logic t_rst;
  logic t_q,temp_q;
  int unsigned count=0;
  bit u[$]={0};
  int i;

  function new(string name="dff_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_drv = new("aport_drv", this);
    aport_mon = new("aport_mon", this);
    expfifo= new("expfifo",this);
    outfifo= new("outfifo",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_drv(dff_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    t_d    = tr.d;
    t_rst  = tr.rst;
    temp_q = t_q;
    if(t_rst==1) begin 
      count=0;
      t_q = 0;
      u={0,0};
      i=1;
      u.push_back(t_q);
    end
    else begin 
      t_q=t_d;
      u.push_back(t_q);
    end
    tr.q = u[i-1];
    i++;
    void'(expfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_mon(dff_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
	dff_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
        if (out_tr.q===exp_tr.q && count>0) begin
            PASS();
           `uvm_info ("\n [ PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      	else if (out_tr.q!==exp_tr.q && count>0) begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
          count++;
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	  VECT_CNT++;
	  PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction
  //----------------------------------------------------------------------------

endclass

