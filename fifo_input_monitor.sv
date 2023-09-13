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

    virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.m_mp.clk)
      if((vif.m_mp.m_cb.wr == 0) && (vif.)begin
        $display("\nWR is high");
        item_got.data_in = vif.m_mp.m_cb.data_in;
        item_got.wr = 'b1;
        item_got.rd = 'b0;  
