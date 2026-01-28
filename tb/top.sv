module top;

	import pkg::*;

	import uvm_pkg::*;

	bit clk;

		always
		#10 clk=!clk;

//instantiate 4 ram_if interface instance in0,in1,in2,in3 with clk as input

	router_if in(clk);//src_network
	router_if in0(clk);//dst_ntw0
	router_if in1(clk);//dst_ntw1
	router_if in2(clk);//dst_ntw2
//instanstiate rtl amd pass ip argument

	router_top duv(.clock(clk),
	.resetn(in.rst),
	.pkt_valid(in.pkt_valid),
	.data_in(in.data_in),
	.error(in.error),
	.busy(in.busy),
	
	.read_enb_0(in0.read_enb),
	.vld_out_0(in0.v_out),
	.data_out_0(in0.data_out),

	.read_enb_1(in1.read_enb),
        .vld_out_1(in1.v_out),
        .data_out_1(in1.data_out),



	.read_enb_2(in2.read_enb),
        .vld_out_2(in2.v_out),
        .data_out_2(in2.data_out));

	initial
		begin
			`ifdef VCS
			$fsdbDumpvars(0, top);
			`endif
			 uvm_config_db #(virtual router_if)::set(null,"*","vif",in);
      			 uvm_config_db #(virtual router_if)::set(null,"*","vif_0",in0);
			 uvm_config_db #(virtual router_if)::set(null,"*","vif_1",in1);
			 uvm_config_db #(virtual router_if)::set(null,"*","vif_2",in2);

			run_test("router_test");

		end

endmodule
