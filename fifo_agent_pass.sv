`include "f_sequence_item.sv"
`include "f_sequence.sv"
`include "f_sequencer.sv"
`include "f_driver.sv"
`include "f_monitor_op.sv"

class f_agent_pass extends uvm_agent;
  f_monitor_op f_mon;
  `uvm_component_utils(f_agent_pass)
  
  function new(string name = "f_agent_pass", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_PASSIVE) begin
     f_mon = f_monitor::type_id::create("f_mon", this);
    end
  endfunction
  
  // virtual function void connect_phase(uvm_phase phase);
  //   if(get_is_active() == UVM_ACTIVE)
  //     f_dri.seq_item_port.connect(f_seqr.seq_item_export);
  // endfunction
  
endclass
    
    
