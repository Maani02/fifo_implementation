class f_monitor_ip extends uvm_monitor;
  virtual f_interface vif;
  f_sequence_item item_got;
  uvm_analysis_port#(f_sequence_item) item_got_port1;
  `uvm_component_utils(f_monitor_ip)
  
  function new(string name = "f_monitor_ip", uvm_component parent);
    super.new(name, parent);
    item_got_port1 = new("item_got_port1", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_got = f_sequence_item::type_id::create("item_got");
    if(!uvm_config_db#(virtual f_interface)::get(this, "*", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

    virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.m_mp_in.clk)
      if((vif.m_mp_in.m_cb_in.i_wren == 0) && (vif.m_mp_in.m_cb_in.i_rden==0))begin
        $display("\nWR and RD is low");
        //item_got.data_in = vif.m_mp.m_cb.data_in;
        item_got.i_wren = 1'b0;
        item_got.i_rden = 1'b0;
        item_got_port1.write(item_got);
      end
      else if((vif.m_mp_in.m_cb_in.i_wren == 0) && (vif.m_mp_in.m_cb_in.i_rden==1))begin
      @(posedge vif.m_mp_in.clk) 
        $display("\n RD is high");
        //item_got.data_in = vif.m_mp.m_cb.data_in;
        item_got.i_wren = 1'b0;
        item_got.i_rden = 1'b1;
        item_got_port1.write(item_got);
      end
      else if((vif.m_mp_in.m_cb_in.i_wren == 1) && (vif.m_mp_in.m_cb_in.i_rden==0))begin
      @(posedge vif.m_mp_in.clk)
        $display("\nWR is high");
        item_got.i_wdata = vif.m_mp_in.m_cb_in.i_wdata;
        item_got.i_wren = 1'b1;
        item_got.i_rden = 1'b0;
        item_got_port1.write(item_got);
      end
      
      else if((vif.m_mp_in.m_cb_in.i_wren == 1) && (vif.m_mp_in.m_cb_in.i_rden==1))begin
      @(posedge vif.m_mp_in.clk)
        $display("\nWR and RD is high");
        //item_got.data_in = vif.m_mp.m_cb.data_in;
        item_got.i_wren = 1'b1;
        item_got.i_rden = 1'b1;
        item_got_port1.write(item_got);
      end
    end
 endtask
endclass
    
