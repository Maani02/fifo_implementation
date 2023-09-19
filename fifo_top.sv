import uvm_pkg::*;
`include "uvm_macros.svh"
`include "f_interface.sv"
`include "f_test.sv"

module tb;
  bit clk;
  bit reset;
  
  always #5 clk = ~clk;
  
  initial begin
    @(posedge clk)
    reset = 0;
    #5;
    reset= 1;
  end
  
  f_interface tif(clk, reset);
  
  my_fifo dut(.clk(tif.clk),
               .rstn(tif.reset),
               .data_in(tif.i_wdata),
               .wr(tif.i_wren),
               .rd(tif.i_rden),
               .full(tif.o_full),
               .empty(tif.o_empty),
               .alm_empty(tif.o_alm_empty),
               .alm_full(tif.o_alm_full),
               .data_out(tif.o_rdata) );
  initial begin
    uvm_config_db#(virtual f_interface)::set(null, "*", "vif", tif);
    run_test("f_test");
    
  end
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
     #1000 $finish;
  end
  
endmodule
