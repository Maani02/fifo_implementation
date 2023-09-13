interface f_interface(input clk, reset);
  bit i_wren;
  bit i_rden;
  bit [127:0] i_wdata;
  bit o_full;
  bit o_empty;
  bit o_alm_full;
  bit o_alm_empty;
  bit [7:0] o_rdata;
  
  clocking d_cb @(posedge clk);
    default input #1 output #1;
    output i_wren;
    output i_rden;
    output i_wdata;
  endclocking
  
  clocking m_cb_in @(posedge clk);
    default input #1 output #0;
    input i_wren;
    input i_rden;
    input i_wdata;
  endclocking
  
  clocking m_cb_out @(posedge clk);
    default input #1 output #0;
    input o_full;
    input o_empty;
    input o_alm_full;
    input o_alm_empty;
    input o_rdata;
  endclocking
  
  modport d_mp (input clk, reset, clocking d_cb);
  modport m_mp_in (input clk, reset, clocking m_cb_in);
  modport m_mp_out (input clk, reset, clocking m_cb_out);
  endinterface
