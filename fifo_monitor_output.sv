class f_monitor_op extends uvm_monitor;
  virtual f_interface vif;
  f_sequence_item item_got;
  uvm_analysis_port#(f_sequence_item) item_got_port;
  `uvm_component_utils(f_monitor_op)
  
  function new(string name = "f_monitor_op", uvm_component parent);
    super.new(name, parent);
    item_got_port = new("item_got_port", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got = f_sequence_item::type_id::create("item_got");
    if(!uvm_config_db#(virtual f_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Output Monitor: ", "No vif is found!")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.m_mp.clk)
      begin
        $display("\nWR is high");
        item_got.o_rdata = vif.m_mp_out.m_cb_out.o_rdata;
        item_got.o_alm_full =vif.m_mp_out.m_cb_out.o_alm_full;
        item_got.o_alm_empty =vif.m_mp_out.m_cb_out.o_alm_empty;
        item_got.o_full =vif.m_mp_out.m_cb_out.o_full;;
        item_got.o_empty =vif.m_mp_out.m_cb_out.o_empty;
        item_got_port.write(item_got);
      end
