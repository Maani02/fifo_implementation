class f_monitor_op extends uvm_monitor;
  virtual f_interface vif;
  f_sequence_item item_got2;
  uvm_analysis_port#(f_sequence_item) item_got_port2;
  `uvm_component_utils(f_monitor_op)
  
  function new(string name = "f_monitor_op", uvm_component parent);
    super.new(name, parent);
    item_got_port2 = new("item_got_port2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got2 = f_sequence_item::type_id::create("item_got2");
    if(!uvm_config_db#(virtual f_interface)::get(this, "*", "vif", vif))
      `uvm_fatal("Output Monitor: ", "No vif is found!")
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.m_mp_out.clk)
      begin
        
        $display("\nRD is high");
        item_got2.o_rdata = vif.m_mp_out.m_cb_out.o_rdata;
        item_got2.o_alm_full =vif.m_mp_out.m_cb_out.o_alm_full;
        item_got2.o_alm_empty =vif.m_mp_out.m_cb_out.o_alm_empty;
        item_got2.o_full =vif.m_mp_out.m_cb_out.o_full;
        item_got2.o_empty =vif.m_mp_out.m_cb_out.o_empty;
        item_got_port2.write(item_got2);
      end
    end
  endtask
endclass
