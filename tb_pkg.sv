
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "dff_sequence_item.sv"        // transaction class
 `include "dff_sequence.sv"             // sequence class
 `include "dff_sequencer.sv"            // sequencer class
 `include "dff_driver.sv"               // driver class
 `include "dff_monitor.sv"              // monitor class
 `include "dff_agent.sv"                // agent class  
 `include "dff_coverage.sv"             // coverage class
 `include "dff_scoreboard.sv"           // scoreboard class
 `include "dff_env.sv"                  // environment class

 `include "dff_test.sv"                         // test1
 //`include "test2.sv"
 //`include "test3.sv"

endpackage
`endif 


