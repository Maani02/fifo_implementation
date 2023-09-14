class f_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export1;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export2;
  `uvm_component_utils(f_scoreboard)
  
  function new(string name = "f_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_got_export1 = new("item_got_export1", this);
    item_got_export2 = new("item_got_export2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  int queue[$];
  int counter=0;
  
  function void write(input f_sequence_item item_got);
    bit [127:0] examdata;
    if(item_got.i_wren == 1'b1)begin
      queue.push_back(item_got.i_wdata);
      counter++;
      `uvm_info("write Data", $sformatf("wr: %0b rd: %0b data_in: %0h counter=%0d full: %0b",item_got.i_wren, item_got.i_rden,item_got.i_wdata,counter, item_got.o_full), UVM_LOW);
    end
    else if (item_got.i_rden == 1'b1)begin
      if(queue.size() >= 'd1)begin
        counter--;
        examdata = queue.pop_front();
        `uvm_info("Read Data", $sformatf("examdata: %0h data_out: %0h, counter=%0d empty: %0b", examdata, item_got.o_rdata,counter, item_got.empty), UVM_LOW);
        if(examdata == item_got.o_rdata)begin
          $display("-------- 		Pass! 		--------");
        end
        else begin
          $display("--------		Fail!		--------");
          $display("--------		Check empty	--------");
        end
      end
    end
  endfunction
endclass
        
