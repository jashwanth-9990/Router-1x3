package pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

// Transactions //
`include "write_xtn.sv"
`include "read_xtn.sv"

// Agent Configuration //

`include "router_wr_agt_config.sv"
`include "router_rd_agt_config.sv"
`include "router_env_config.sv"

//  Write agent config //

`include "router_wr_driver.sv"
`include "router_wr_mon.sv"
`include "router_wr_sequencer.sv"
`include "router_wr_agent.sv"
`include "router_wr_agt_top.sv"
`include "router_wr_seqs.sv"


// Read agent //

`include "router_rd_driver.sv"
`include "router_rd_monitor.sv"
`include "router_rd_sequencer.sv"
`include "router_rd_agent.sv"
`include "router_rd_agt_top.sv"
`include "router_rd_seqs.sv"

// environment config//

`include "router_virtual_sequencer.sv"
`include "router_virtual_sequence.sv"
`include "router_scoreboard.sv"
`include "router_env.sv"
`include "router_test.sv"
endpackage
