class router_rd_monitor extends uvm_monitor;
  `uvm_component_utils(router_rd_monitor)

  router_rd_agt_config m_cfg;
  virtual router_if.RMON_MP vif;
  uvm_analysis_port #(read_xtn) monitor_port;
  extern function new(string name ="router_rd_monitor" , uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task collect_data();
  extern function void report_phase(uvm_phase phase);
endclass

  // Constructor
  function  router_rd_monitor::new(string name = "router_rd_monitor", uvm_component parent);
    super.new(name, parent);
    monitor_port = new("monitor_port", this);
  endfunction

  // Build Phase
  function void router_rd_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(router_rd_agt_config)::get(this, "", "router_rd_agt_config", m_cfg))
      `uvm_fatal("CONFIG"," we cannot get() m_cfg from uvmconfig_db. Have you set() it?")
      
  endfunction


function void router_rd_monitor::connect_phase(uvm_phase phase);
	vif = m_cfg.vif;
	super.connect_phase(phase);
endfunction


task router_rd_monitor::run_phase(uvm_phase phase);
	forever
 	collect_data();
endtask

task router_rd_monitor::collect_data();
 
	read_xtn mon_data;
	begin
		mon_data = read_xtn::type_id::create("mon_data");

	//	@(vif.rmon_cb);
		@(vif.rmon_cb);

		wait(vif.rmon_cb.read_enb)
		@(vif.rmon_cb);

			mon_data.header=vif.rmon_cb.data_out;
		mon_data.payload_data=new[mon_data.header[7:2]];
		@(vif.rmon_cb);
		foreach(mon_data.payload_data[i])
	
		begin
	
   			 mon_data.payload_data[i]=vif.rmon_cb.data_out;
   			 @(vif.rmon_cb);
		end


	mon_data.parity = vif.rmon_cb.data_out;
   @(vif.rmon_cb);
	m_cfg.mon_data_count++;
	`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from monitor \n %s", mon_data.sprint()),UVM_LOW)
	monitor_port.write(mon_data);
//`uvm_info("ROUTER_RD_MONITOR",$sformatf("printing from monitor \n %s", mon_data.sprint()),UVM_LOW)

end
endtask
function void router_rd_monitor::report_phase(uvm_phase phase);
`uvm_info(get_type_name(), $sformatf("Report: ROUTER read monitor sent %0d transaction", m_cfg.mon_data_count),UVM_LOW)
endfunction
