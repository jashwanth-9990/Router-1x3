class router_vbase_seq extends uvm_sequence #(uvm_sequence_item);

  // Factory registration
  `uvm_object_utils(router_vbase_seq)

  // Declare dynamic array of handles for write sequencer and read sequencer
  router_wr_sequencer wrr_seqrh[];
  router_rd_sequencer rdd_seqrh[];

  // Declare handle for virtual sequencer
  router_virtual_sequencer vsqrh;

  // Declare handle for router_env_config
  router_env_config m_cfg;

  extern function new(string name = "router_vbase_seq");
  extern task body();
endclass


// Add constructor
function router_vbase_seq::new(string name = "router_vbase_seq");
  super.new(name);
endfunction


// ---------------- task body() method ----------------
task router_vbase_seq::body();

  // get the config object using uvm_config_db
  if (!uvm_config_db#(router_env_config)::get(null, get_full_name(), "router_env_config", m_cfg))
    `uvm_fatal("CONFIG", "cannot get() m_cfg from uvm_config_db. Have you set() it?")

  // initialize the dynamic arrays for write & read sequencers
  // all the write & read sequencers declared above to m_cfg.no_of_duts
  wrr_seqrh = new[m_cfg.no_of_write_agent];
  rdd_seqrh = new[m_cfg.no_of_read_agent];

  assert($cast(vsqrh, m_sequencer)) // m_sequencer is the object of the sequencer
  else begin
    `uvm_error("BODY", "Error in $cast of virtual sequencer")
  end

  // Assign router_wr_sequencer & router_rd_sequencer handles to virtual sequencer's
  // router_wr_sequencer & router_rd_sequencer handles
  // Hint - use foreach loop
  foreach (wrr_seqrh[i])
    wrr_seqrh[i] = vsqrh.wr_seqrh[i];

  foreach (rdd_seqrh[i])
    rdd_seqrh[i] = vsqrh.rd_seqrh[i];

endtask : body


// ----------------------------------------------------

//----------------------------------------------------------------------
// router_small_pkt_vseq
//----------------------------------------------------------------------
class router_small_pkt_vseq extends router_vbase_seq;

  // Define Constructor new() function
  `uvm_object_utils(router_small_pkt_vseq)

  bit [1:0] addr;
  router_wxtns_small_pkt wrtns;
  router_rxtns1 rdtns;

  // METHODS
  // Standard UVM Methods:
  extern function new(string name = "router_small_pkt_vseq");
  extern task body();
endclass : router_small_pkt_vseq

//----------------------------------------------------------------------
// constructor new method
//----------------------------------------------------------------------
function router_small_pkt_vseq::new(string name = "router_small_pkt_vseq");
  super.new(name);
endfunction : new

//----------------------------------------------------------------------
// task body() method
//----------------------------------------------------------------------
task router_small_pkt_vseq::body();
  super.body();

  if (!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")

  // create the instances
  
    wrtns = router_wxtns_small_pkt::type_id::create("wrtns");
    rdtns = router_rxtns1::type_id::create("rdtns");

  fork
    begin
      wrtns.start(wrr_seqrh[0]);
    end

    begin
      if (addr == 2'b00)
        rdtns.start(rdd_seqrh[0]);

      if (addr == 2'b01)
        rdtns.start(rdd_seqrh[1]);

      if (addr == 2'b10)
        rdtns.start(rdd_seqrh[2]);
    end
  join

endtask : body

//----------------------------------------------------------------------
// router_medium_pkt_vseq
//----------------------------------------------------------------------
class router_medium_pkt_vseq extends router_vbase_seq;

  // Define Constructor new() function
  `uvm_object_utils(router_medium_pkt_vseq)

  bit [1:0] addr;
  router_wxtns_medium_pkt wrtns;
  router_rxtns1 rdtns;
  extern function new(string name = "router_medium_pkt_vseq");
  extern task body();
endclass 
function router_medium_pkt_vseq::new(string name = "router_medium_pkt_vseq");
  super.new(name);
endfunction : new

task router_medium_pkt_vseq::body();
  super.body();

  if (!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")

  // create the instances
  
    wrtns = router_wxtns_medium_pkt::type_id::create("wrtns");


 
    rdtns = router_rxtns1::type_id::create("rdtns");

  fork
    begin
      wrtns.start(wrr_seqrh[0]);
    end

    begin
      if (addr == 2'b00)
        rdtns.start(rdd_seqrh[0]);

      if (addr == 2'b01)
        rdtns.start(rdd_seqrh[1]);

      if (addr == 2'b10)
        rdtns.start(rdd_seqrh[2]);
    end
  join

endtask : body

class router_big_pkt_vseq extends router_vbase_seq;

  // Define Constructor new() function
  `uvm_object_utils(router_big_pkt_vseq)

  bit [1:0] addr;
  router_wxtns_big_pkt wrtns;
  router_rxtns1 rdtns;
  extern function new(string name = "router_big_pkt_vseq");
  extern task body();
endclass 
function router_big_pkt_vseq::new(string name = "router_big_pkt_vseq");
  super.new(name);
endfunction : new

task router_big_pkt_vseq::body();
  super.body();

  if (!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")

  // create the instances
  
    wrtns = router_wxtns_big_pkt::type_id::create("wrtns");
    rdtns = router_rxtns1::type_id::create("rdtns");

  fork
    begin
      wrtns.start(wrr_seqrh[0]);
    end

    begin
      if (addr == 2'b00)
        rdtns.start(rdd_seqrh[0]);

      if (addr == 2'b01)
        rdtns.start(rdd_seqrh[1]);

      if (addr == 2'b10)
        rdtns.start(rdd_seqrh[2]);
    end
  join

endtask : body


class router_error_pkt_vseq extends router_vbase_seq;

  // Define Constructor new() function
  `uvm_object_utils(router_error_pkt_vseq)

  bit [1:0] addr;
  error_pkt_sequence wrtns;
  router_rxtns1 rdtns;
  extern function new(string name = "router_error_pkt_vseq");
  extern task body();
endclass 
function router_error_pkt_vseq::new(string name = "router_error_pkt_vseq");
  super.new(name);
endfunction : new

task router_error_pkt_vseq::body();
  super.body();

  if (!uvm_config_db#(bit[1:0])::get(null, get_full_name(), "bit[1:0]", addr))
    `uvm_fatal(get_type_name(), "cannot get() addr from uvm_config_db. Have you set() it?")

  // create the instances
  
    wrtns = error_pkt_sequence::type_id::create("wrtns");
    rdtns = router_rxtns1::type_id::create("rdtns");

  fork
    begin
      wrtns.start(wrr_seqrh[0]);
    end

    begin
      if (addr == 2'b00)
        rdtns.start(rdd_seqrh[0]);

      if (addr == 2'b01)
        rdtns.start(rdd_seqrh[1]);

      if (addr == 2'b10)
        rdtns.start(rdd_seqrh[2]);
    end
  join

endtask : body
