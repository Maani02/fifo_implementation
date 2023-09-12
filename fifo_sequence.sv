class f_sequence extends uvm_sequence#(f_sequence_item);
  `uvm_object_utils(f_sequence)
  
  function new(string name = "f_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_info(get_type_name(), $sformatf("******** Generate 16 Write REQs ********"), UVM_LOW)
    repeat(16) begin
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b10;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 16 Read REQs ********"), UVM_LOW)
    repeat(16) begin
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b01;});
      finish_item(req);
    end
     `uvm_info(get_type_name(), $sformatf("******** Generate 20 Random REQs ********"), UVM_LOW)
    repeat(20) begin
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b10;});
      finish_item(req);
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b01;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 16 Read REQs ********"), UVM_LOW)
    repeat(16) begin
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b11;});
      finish_item(req);
    end
     `uvm_info(get_type_name(), $sformatf("******** Generate 16 Read REQs ********"), UVM_LOW)
    repeat(16) begin
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {{i_wren,i_rden} == 2'b00;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 20 Random REQs ********"), UVM_LOW)
    repeat(20) begin
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask
  
endclass
  
  
