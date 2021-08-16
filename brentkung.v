module AND(input a,b, output c);
assign c=a & b;
endmodule 

module XOR(input a,b,output c);
assign c=a ^ b;
endmodule 

module aplusbc(input a,b,c, output d);
assign d=a | (b & c);
endmodule 


module brentkung(a,b,cin,sum,cout);

input [15:0] a,b;
input cin;
output [15:0] sum;
output cout;

wire [15:0] P1,G1;
wire [7:0] P2,G2;
wire [3:0] P3,G3;
wire [1:0] P4,G4;
wire [0:0] P5,G5;
wire [16:0] carry;
genvar i;
generate
for(i=0;i<=15;i=i+1)
begin : firstorder
	
	AND  A1(a[i],b[i],G1[i]);
	XOR  X(a[i],b[i],P1[i]);
end
endgenerate


generate
for(i=0;i<=7;i=i+1)
begin : secondorder
	
	aplusbc  apbc2(G1[2*i+1],P1[2*i+1],G1[2*i],G2[i]); //G2[0] =G1[1]+P1[1]*G1[0], G2[1] =G1[3]+P1[3]*G1[2]
	AND  A2(P1[2*i+1],P1[2*i],P2[i]);
end
endgenerate

generate
for(i=0;i<=3;i=i+1)
begin : thirdorder
	
	aplusbc  apbc3(G2[2*i+1],P2[2*i+1],G2[2*i],G3[i]);
	AND  A3(P2[2*i+1],P2[2*i],P3[i]);
end
endgenerate


generate
for(i=0;i<=1;i=i+1)
begin : Fourthorder
	
	aplusbc  apbc4(G3[2*i+1],P3[2*i+1],G3[2*i],G4[i]);
	AND  A4(P3[2*i+1],P3[2*i],P4[i]);
end
endgenerate

generate
for(i=0;i<=0;i=i+1)
begin : Fifthorder
	
	aplusbc  apbc5(G4[2*i+1],P4[2*i+1],G4[2*i],G5[i]);
	AND  A5(P4[2*i+1],P4[2*i],P5[i]);
end
endgenerate

assign carry[0] = cin;

assign carry[1] = G1[0] | (P1[0]&carry[0]);

assign carry[2] = G2[0] | (P2[0]&carry[0]);

assign carry[4] = G3[0] | (P3[0]&carry[0]);

assign carry[8] = G4[0] | (P4[0]&carry[0]);

assign carry[16] = G5[0] | (P5[0]&carry[0]);

//***********************

assign carry[3] = G1[2] | (P1[2]&carry[2]);

assign carry[5] = G1[4] | (P1[4]&carry[4]);

assign carry[9] = G1[8] | (P1[8]&carry[8]);

assign carry[6] = G2[2] | (P2[2]&carry[4]);

assign carry[10] = G2[4] | (P2[4]&carry[8]);

assign carry[12] = G3[2] | (P3[2]&carry[8]);

//**************************

assign carry[7] = G1[6] | (P1[6]&carry[6]);

assign carry[11] = G1[10] | (P1[10]&carry[10]);

assign carry[13] = G1[12] | (P1[12]&carry[12]);

assign carry[14] = G2[6] | (P2[6]&carry[12]);

//**********************

assign carry[15] = G1[14] | (P1[14]&carry[14]);

assign sum[15:0] = P1[15:0] ^ carry[15:0];

assign cout = carry[16];
endmodule 