// Extend router_wbase_seq from uvm_sequence parameterized by write_xtn
class router_wr_seq extends uvm_sequence #(write_xtn);

  // Factory registration using `uvm_object_utils

  `uvm_object_utils(router_wr_seq)

  // --------------------------------------
  // METHODS
  // --------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "router_wr_seq");
endclass

function router_wr_seq::new(string name = "router_wr_seq");
  super.new(name);
endfunction

class router_wxtns_small_pkt extends router_wr_seq;

  // Factory registration using `uvm_object_utils
  `uvm_object_utils(router_wxtns_small_pkt)

  bit [1:0] addr;

  // --------------------------------------
  // METHODS
  // --------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "router_wxtns_small_pkt");
  extern task body();
endclass

function router_wxtns_small_pkt::new(string name = "router_wxtns_small_pkt");
  super.new(name);
endfunction

task router_wxtns_small_pkt::body();
 
  if (!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")
  req = write_xtn::type_id::create("req");
  start_item(req);
  assert(req.randomize() with { header[7:2] inside {[1:15]} && header[1:0] == addr; });
  `uvm_info(get_type_name(), $sformatf("printing from sequence \n %s",req.sprint()), UVM_HIGH);
  finish_item(req);
endtask



class router_wxtns_medium_pkt extends router_wr_seq;


	`uvm_object_utils(router_wxtns_medium_pkt)

  bit [1:0] addr;

  // --------------------------------------
  // METHODS
  // --------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "router_wxtns_medium_pkt");
  extern task body();
endclass

function router_wxtns_medium_pkt::new(string name = "router_wxtns_medium_pkt");
  super.new(name);
endfunction

task router_wxtns_medium_pkt::body();
    if (!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")
  req = write_xtn::type_id::create("req");
  start_item(req);
  assert(req.randomize() with { header[7:2] inside {[16:30]} && header[1:0] == addr; });
  `uvm_info(get_type_name(), $sformatf("printing from sequence \n %s",req.sprint()), UVM_HIGH);
  finish_item(req);
endtask


class router_wxtns_big_pkt extends router_wr_seq;

	`uvm_object_utils(router_wxtns_big_pkt)

  bit [1:0] addr;

  // --------------------------------------
  // METHODS
  // --------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "router_wxtns_big_pkt");
  extern task body();
endclass

function router_wxtns_big_pkt::new(string name = "router_wxtns_big_pkt");
  super.new(name);
endfunction

task router_wxtns_big_pkt::body();

  if (!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")

  req = write_xtn::type_id::create("req");
  start_item(req);
  assert(req.randomize() with { header[7:2] inside {[31:63]} && header[1:0] == addr; });
  `uvm_info(get_type_name(), $sformatf("printing from sequence \n %s",req.sprint()), UVM_HIGH);
  finish_item(req);
endtask

class error_pkt_sequence extends router_wr_seq;

  // Factory registration using `uvm_object_utils
  `uvm_object_utils(error_pkt_sequence)

  bit [1:0] addr;

  // --------------------------------------
  // METHODS
  // --------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "error_pkt_sequence");
  extern task body();
endclass

function error_pkt_sequence::new(string name = "error_pkt_sequence");
  super.new(name);
endfunction

task error_pkt_sequence::body();
 
  if (!uvm_config_db #(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")
  req = write_xtn::type_id::create("req");
  start_item(req);
  assert(req.randomize() with { header[7:2] inside {[1:15]} && header[1:0] == addr; });
 req.parity = {$random}%100;
  `uvm_info(get_type_name(), $sformatf("printing from sequence \n %s",req.sprint()), UVM_HIGH);
  finish_item(req);
endtask
