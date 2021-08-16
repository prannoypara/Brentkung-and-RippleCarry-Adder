`timescale 1ns/1ps

module brentkung_tb();	
  reg [15:0] A, B; reg Cin;	
  wire [15:0] Sum; wire Cout;	
  brentkung Test (A, B, Cin, Sum, Cout);	

  initial begin
    //$dumpfile("Test_Adder_16.vcd");
    //$dumpvars;
    A='h8194; B='h1314; Cin=0;	
    #200 $finish;
  end

  always begin	
    #60 A='h52A0; #60 A='hB904; #60 A='h158A; 
  end

  always begin	
    #20 B='h9A44; #20 B='hC6B4; #20 B='h7094; 
  end

  always #10 Cin = ~Cin;	

endmodule
