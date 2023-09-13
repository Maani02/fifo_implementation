class f_monitor_ip extends uvm_monitor;
  virtual f_interface vif;
  f_sequence_item item_got;
  uvm_analysis_port#(f_sequence_item) item_got_port;
  `uvm_component_utils(f_monitor_ip)
  
  function new(string name = "f_monitor_ip", uvm_component parent);
    super.new(name, parent);
    item_got_port = new("item_got_port", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got = f_sequence_item::type_id::create("item_got");
    if(!uvm_config_db#(virtual f_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

      
