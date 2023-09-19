`include "f_agent_act.sv"
`include "f_agent_pass.sv"
`include "f_scoreboard.sv"
//`include "f_scoreboard2.sv"

class f_environment extends uvm_env;
  f_agent_act f_agt;
  f_agent_pass f_agtp;
  f_scoreboard f_scb;
  f_scoreboard2 f_scb2;
  `uvm_component_utils(f_environment)
  
  function new(string name = "f_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    f_agt = f_agent_act::type_id::create("f_agt", this);
    f_agtp= f_agent_pass::type_id::create("f_agtp", this);
    f_scb = f_scoreboard::type_id::create("f_scb", this);
    f_scb2 = f_scoreboard2::type_id::create("f_scb2", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    f_agt.f_mon.item_got_port1.connect(f_scb.item_got_export1);
    f_agtp.f_mon1.item_got_port2.connect(f_scb2.item_got_export2);
  endfunction
  
endclass
