class f_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export1;
  //uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export2;
  `uvm_component_utils(f_scoreboard)
  
  function new(string name = "f_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_got_export1 = new("item_got_export1", this);
    //item_got_export2 = new("item_got_export2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  bit [3:0] queue[$];
  int counter=0;
  bit[3:0] temp;
  
  function void write( input f_sequence_item item_got);
    bit [3:0] examdata;
    if(item_got.i_wren == 1'b1)begin
      queue.push_back(item_got.i_wdata);
      counter++;
      `uvm_info("write Data", $sformatf("wr: %0b rd: %0b data_in: %0h counter=%0d",item_got.i_wren, item_got.i_rden,item_got.i_wdata,counter), UVM_LOW);
    end
   if (item_got.i_rden == 1'b1)begin
      if(queue.size() >= 'd1)begin
        counter--;
        examdata = queue.pop_front();
        `uvm_info("Read Data", $sformatf("examdata: %0h  counter=%0d", examdata,counter), UVM_LOW);
                if(examdata == temp)begin
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
class f_scoreboard2 extends f_scoreboard;
    //uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export1;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard2) item_got_export2;
  `uvm_component_utils(f_scoreboard2)
  
  function new(string name = "f_scoreboard2", uvm_component parent);
    super.new(name, parent);
    //item_got_export1 = new("item_got_export1", this);
    item_got_export2 = new("item_got_export2", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
 
  function void write(input f_sequence_item item_got2);
   temp=item_got2.o_rdata;
    if(counter==13)
      begin
        if(item_got2.o_full=='b1)
          begin
            $display("FIFO FULL:PASS");
          end
        else
          begin
            $display("FIFO FULL:FAIL");
          end
      end

    if(counter>=11 && counter<15)
      begin
        if(item_got2.o_alm_full=='b1)
          begin
            $display("FIFO ALMOST FULL: PASS");
          end
        else
          begin
            $display("FIFO ALMOST FULL:FAIL");
          end
      end

    if(counter>0 && counter<=2)
      begin
        if(item_got2.o_alm_empty=='b1)
          begin
            $display("FIFO ALMOST EMPTY: PASS");
          end
        else
          begin
            $display("FIFO ALMOST EMPTY:FAIL");
          end
      end

    
    if(counter==0)
      begin
        if(item_got2.o_empty=='b1)
          begin
            $display("FIFO EMPTY: PASS");
          end
        else
          begin
            $display("FIFO EMPTY:FAIL");
          end
      end
  endfunction
endclass
