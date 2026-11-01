module load_updown_counter_tb();
      reg clk;
      reg rst;
      reg load;
      reg up_down;
      reg[3:0]load_value;
      wire[3:0] count;
     
load_updown_counter dut(
    .clk(clk),
    .rst(rst),
    .load(load),
    .up_down(up_down),
    .load_value(load_value),
    .count(count));
    
 always begin
 #5;
 clk=~clk;
 end
 
 task reset();
  begin
 rst=1'b1; #5;
 rst=1'b0; #5;
 end
 endtask
 
 task initialise();
  begin
  load=1'b0;
  up_down=1'b0;
  load_value=4'b0000;
  end
 endtask
 
 task d_in(input[3:0]i);
 begin
  load_value=i;
 end
 endtask
 
 initial begin
   clk=0;
   initialise();
   reset();
   #100;
   load=1'b1;
   d_in(4'b1010);
   #50;
   reset();
   load=1'b0;
   up_down=1'b1;
   #50;
   $finish;
   $dumpfile("dump.vcd");
   $dumpvars;
   
   end
endmodule
