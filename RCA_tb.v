`timescale 1ns/1ps

module RCA_tb();	
  reg [15:0] A, B; reg Cin;	
  wire [15:0] Sum; wire Cout;	
  RCA Test (A, B, Cin, Sum, Cout);	

  initial begin
    //$dumpfile("Test_Adder_16.vcd");
    //$dumpvars;
     A='h8194; B='h1314; Cin=0;	
    #240 $finish;	
  end

  always begin	// Change A every 60 ns
    #60 A='h52A0; #60 A='hB904; #60 A='h158A; 
  end

  always begin	// Change B every 20 ns
    #20 B='h9A44; #20 B='hC6B4; #20 B='h7094; 
  end

  always #10 Cin = ~Cin;	// Invert Cin every 10 ns

endmodule
