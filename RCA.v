module FA( input x,y,cin_fa, output sum_fa, cout_fa);
assign {cout_fa,sum_fa} =x + y + cin_fa;
endmodule 

module RCA(a,b,cin,sum,cout);
input [15:0] a,b;
input cin;
output [15:0] sum;
output cout;
wire [15:0]c;

FA fa0(a[0],b[0],cin,sum[0],c[0]);

  genvar i;
  generate
  for(i=1;i<=15;i=i+1)
    begin : fa1tofa15
	   FA fa(a[i],b[i],c[i-1],sum[i],c[i]);
    end
  endgenerate

assign cout = c[15];
endmodule
 
 
