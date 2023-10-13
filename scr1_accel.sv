`include "scr1_memif.svh"
`include "scr1_arch_description.svh"

`define ROTLEFT(a,b) (((a) << (b)) | ((a) >> (32-(b))))
`define ROTRIGHT(a,b) (((a) >> (b)) | ((a) << (32-(b))))

`define CH(x,y,z) (((x) & (y)) ^ (~(x) & (z)))
`define MAJ(x,y,z) (((x) & (y)) ^ ((x) & (z)) ^ ((y) & (z)))
`define EP0(x) (`ROTRIGHT(x,2) ^ `ROTRIGHT(x,13) ^ `ROTRIGHT(x,22))
`define EP1(x) (`ROTRIGHT(x,6) ^ `ROTRIGHT(x,11) ^ `ROTRIGHT(x,25))
`define SIG0(x) (`ROTRIGHT(x,7) ^ `ROTRIGHT(x,18) ^ ((x) >> 3))
`define SIG1(x) (`ROTRIGHT(x,17) ^ `ROTRIGHT(x,19) ^ ((x) >> 10))

module scr1_accel
(
    // Control signals
    input   logic                           clk,
    input   logic                           rst_n,


    // Core data interface
    output  logic                           dmem_req_ack,
    input   logic                           dmem_req,
    input   type_scr1_mem_cmd_e             dmem_cmd,
    input   type_scr1_mem_width_e           dmem_width,
    input   logic [`SCR1_DMEM_AWIDTH-1:0]   dmem_addr,
    input   logic [`SCR1_DMEM_DWIDTH-1:0]   dmem_wdata,
    output  logic [`SCR1_DMEM_DWIDTH-1:0]   dmem_rdata,
    output  type_scr1_mem_resp_e            dmem_resp
);


//-------------------------------------------------------------------------------
// Local signal declaration
//-------------------------------------------------------------------------------
logic                               dmem_req_en;
logic                               dmem_rd;
logic                               dmem_wr;
logic [`SCR1_DMEM_DWIDTH-1:0]       dmem_writedata;
logic [`SCR1_DMEM_DWIDTH-1:0]       dmem_rdata_local;
logic [1:0]                         dmem_rdata_shift_reg;

/// -----------------------------------------------------------------------------
///	INIT
/// -----------------------------------------------------------------------------

reg [31:0] state[7:0];
reg [31:0] datalen;
reg [31:0] bitlen[1:0];


//-------------------------------------------------------------------------------
// Core interface
//-------------------------------------------------------------------------------
assign dmem_req_en = (dmem_resp == SCR1_MEM_RESP_RDY_OK) ^ dmem_req;


always_ff @(posedge clk, negedge rst_n) begin
    if (~rst_n) begin
        dmem_resp <= SCR1_MEM_RESP_NOTRDY;
    end else if (dmem_req_en) begin
        dmem_resp <= dmem_req ? SCR1_MEM_RESP_RDY_OK : SCR1_MEM_RESP_NOTRDY;
    end
end

assign dmem_req_ack = 1'b1;
//-------------------------------------------------------------------------------
// Memory data composing
//-------------------------------------------------------------------------------
assign dmem_rd  = dmem_req & (dmem_cmd == SCR1_MEM_CMD_RD);
assign dmem_wr  = dmem_req & (dmem_cmd == SCR1_MEM_CMD_WR);

always_comb begin
    dmem_writedata = dmem_wdata;
    case ( dmem_width )
        SCR1_MEM_WIDTH_BYTE : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH /  8){dmem_wdata[7:0]}};
        end
        SCR1_MEM_WIDTH_HWORD : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH / 16){dmem_wdata[15:0]}};
        end
		  SCR1_MEM_WIDTH_WORD : begin
            dmem_writedata  = {(`SCR1_DMEM_DWIDTH / 32){dmem_wdata[31:0]}};
        end
        default : begin
        end
    endcase
end

 
	reg go_bit;
	wire go_bit_in;
	reg done_bit;
	wire done_bit_in;
	reg [15:0] counter;
	reg [31:0] data0;
	reg [31:0] data1;
	reg [31:0] data2;
	reg [31:0] data3;
	reg [31:0] data4;
	reg [31:0] data5;
	reg [31:0] data6;
	reg [31:0] data7;
	reg [31:0] data8;
	reg [31:0] data9;
	reg [31:0] data10;
	reg [31:0] data11;
	reg [31:0] data12;
	reg [31:0] data13;
	reg [31:0] data14;
	reg [31:0] data15;
	reg [31:0] m0;
	reg [31:0] m1;
	reg [31:0] m2;
	reg [31:0] m3;
	reg [31:0] m4;
	reg [31:0] m5;
	reg [31:0] m6;
	reg [31:0] m7;
	reg [31:0] m8;
	reg [31:0] m9;
	reg [31:0] m10;
	reg [31:0] m11;
	reg [31:0] m12;
	reg [31:0] m13;
	reg [31:0] m14;
	reg [31:0] m15;
	reg [31:0] m16;
	reg [31:0] m17;
	reg [31:0] m18;
	reg [31:0] m19;
	reg [31:0] m20;
	reg [31:0] m21;
	reg [31:0] m22;
	reg [31:0] m23;
	reg [31:0] m24;
	reg [31:0] m25;
	reg [31:0] m26;
	reg [31:0] m27;
	reg [31:0] m28;
	reg [31:0] m29;
	reg [31:0] m30;
	reg [31:0] m31;
	reg [31:0] m32;
	reg [31:0] m33;
	reg [31:0] m34;
	reg [31:0] m35;
	reg [31:0] m36;
	reg [31:0] m37;
	reg [31:0] m38;
	reg [31:0] m39;
	reg [31:0] m40;
	reg [31:0] m41;
	reg [31:0] m42;
	reg [31:0] m43;
	reg [31:0] m44;
	reg [31:0] m45;
	reg [31:0] m46;
	reg [31:0] m47;
	reg [31:0] m48;
	reg [31:0] m49;
	reg [31:0] m50;
	reg [31:0] m51;
	reg [31:0] m52;
	reg [31:0] m53;
	reg [31:0] m54;
	reg [31:0] m55;
	reg [31:0] m56;
	reg [31:0] m57;
	reg [31:0] m58;
	reg [31:0] m59;
	reg [31:0] m60;
	reg [31:0] m61;
	reg [31:0] m62;
	reg [31:0] m63;
	reg [31:0] result;
	logic [31:0] ctr;

	assign ctr = counter;
	 
	 always @(*) begin
		case(dmem_addr[8:2])
		7'b0000000: dmem_rdata_local = {done_bit, 30'b0, go_bit};
		7'b0000001: dmem_rdata_local = data0;
		7'b0000010: dmem_rdata_local = data1;
		7'b0000011: dmem_rdata_local = data2;
		7'b0000100: dmem_rdata_local = data3;
		7'b0000101: dmem_rdata_local = data4;
		7'b0000110: dmem_rdata_local = data5;
		7'b0000111: dmem_rdata_local = data6;
		7'b0001000: dmem_rdata_local = data7;
		7'b0001001: dmem_rdata_local = data8;
		7'b0001010: dmem_rdata_local = data9;
		7'b0001011: dmem_rdata_local = data10;
		7'b0001100: dmem_rdata_local = data11;
		7'b0001101: dmem_rdata_local = data12;
		7'b0001110: dmem_rdata_local = data13;
		7'b0001111: dmem_rdata_local = data14;
		7'b0010000: dmem_rdata_local = data15;
		7'b0010001: dmem_rdata_local = m0;//68
		7'b0010010: dmem_rdata_local = m1;
		7'b0010011: dmem_rdata_local = m2;
		7'b0010100: dmem_rdata_local = m3;
		7'b0010101: dmem_rdata_local = m4;
		7'b0010110: dmem_rdata_local = m5;
		7'b0010111: dmem_rdata_local = m6;
		7'b0011000: dmem_rdata_local = m7;
		7'b0011001: dmem_rdata_local = m8;
		7'b0011010: dmem_rdata_local = m9;
		7'b0011011: dmem_rdata_local = m10;
		7'b0011100: dmem_rdata_local = m11;
		7'b0011101: dmem_rdata_local = m12;
		7'b0011110: dmem_rdata_local = m13;
		7'b0011111: dmem_rdata_local = m14;
		7'b0100000: dmem_rdata_local = m15;
		7'b0100001: dmem_rdata_local = m16;
		7'b0100010: dmem_rdata_local = m17;
		7'b0100011: dmem_rdata_local = m18;
		7'b0100100: dmem_rdata_local = m19;
		7'b0100101: dmem_rdata_local = m20;
		7'b0100110: dmem_rdata_local = m21;
		7'b0100111: dmem_rdata_local = m22;
		7'b0101000: dmem_rdata_local = m23;
		7'b0101001: dmem_rdata_local = m24;
		7'b0101010: dmem_rdata_local = m25;
		7'b0101011: dmem_rdata_local = m26;
		7'b0101100: dmem_rdata_local = m27;
		7'b0101101: dmem_rdata_local = m28;
		7'b0101110: dmem_rdata_local = m29;
		7'b0101111: dmem_rdata_local = m30;
		7'b0110000: dmem_rdata_local = m31;
		7'b0110001: dmem_rdata_local = m32;
		7'b0110010: dmem_rdata_local = m33;		
		7'b0110011: dmem_rdata_local = m34;
		7'b0110100: dmem_rdata_local = m35;
		7'b0110101: dmem_rdata_local = m36;
		7'b0110110: dmem_rdata_local = m37;
		7'b0110111: dmem_rdata_local = m38;
		7'b0111000: dmem_rdata_local = m39;
		7'b0111001: dmem_rdata_local = m40;
		7'b0111010: dmem_rdata_local = m41;
		7'b0111011: dmem_rdata_local = m42;
		7'b0111100: dmem_rdata_local = m43;
		7'b0111101: dmem_rdata_local = m44;
		7'b0111110: dmem_rdata_local = m45;
		7'b0111111: dmem_rdata_local = m46;
		7'b1000000: dmem_rdata_local = m47;
		7'b1000001: dmem_rdata_local = m48;
		7'b1000010: dmem_rdata_local = m49;
		7'b1000011: dmem_rdata_local = m50;
		7'b1000100: dmem_rdata_local = m51;
		7'b1000101: dmem_rdata_local = m52;
		7'b1000110: dmem_rdata_local = m53;
		7'b1000111: dmem_rdata_local = m54;
		7'b1001000: dmem_rdata_local = m55;
		7'b1001001: dmem_rdata_local = m56;
		7'b1001010: dmem_rdata_local = m57;
		7'b1001011: dmem_rdata_local = m58;
		7'b1001100: dmem_rdata_local = m59;
		7'b1001101: dmem_rdata_local = m60;
		7'b1001110: dmem_rdata_local = m61;
		7'b1001111: dmem_rdata_local = m62;
		7'b1010000: dmem_rdata_local = m63; //140 in hex
		7'b1010001: dmem_rdata_local = state[0]; //144
		7'b1010010: dmem_rdata_local = state[1];
		7'b1010011: dmem_rdata_local = state[2];
		7'b1010100: dmem_rdata_local = state[3];
		7'b1010101: dmem_rdata_local = state[4];
		7'b1010110: dmem_rdata_local = state[5];
		7'b1010111: dmem_rdata_local = state[6];
		7'b1011000: dmem_rdata_local = state[7];
		7'b1011001: dmem_rdata_local = {16'b0, counter};
		7'b1011010: dmem_rdata_local = datalen;
		7'b1011011: dmem_rdata_local = bitlen[0];
		7'b1011100: dmem_rdata_local = bitlen[1];
		default: dmem_rdata_local = 32'b0;
		endcase
	 end
	 
	 assign go_bit_in = (dmem_wr & (dmem_addr[8:2] == 7'b0000000));
		
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) go_bit <= 1'b0;
		else go_bit <=  go_bit_in ? 1'b1 : 1'b0;
		
		
		
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) begin
			state[0] <= 32'h6a09e667;
			state[1] <= 32'hbb67ae85;
			state[2] <= 32'h3c6ef372;
			state[3] <= 32'ha54ff53a;
			state[4] <= 32'h510e527f;
			state[5] <= 32'h9b05688c;
			state[6] <= 32'h1f83d9ab;
			state[7] <= 32'h5be0cd19;
			datalen <= 0;
			bitlen[0] <= 0;
			bitlen[1] <= 0;
			counter <= 16'b0;
			data0 <= 32'b0;
			data1 <= 32'b0;
			data2 <= 32'b0;
			data3 <= 32'b0;
			data4 <= 32'b0;
			data5 <= 32'b0;
			data6 <= 32'b0;
			data7 <= 32'b0;
			data8 <= 32'b0;
			data9 <= 32'b0;
			data10 <= 32'b0;
			data11 <= 32'b0;
			data12 <= 32'b0;
			data13 <= 32'b0;
			data14 <= 32'b0;
			data15 <= 32'b0;
			m0 <= 32'b0;
			m1 <= 32'b0;
			m2 <= 32'b0;
			m3 <= 32'b0;
			m4 <= 32'b0;
			m5 <= 32'b0;
			m6 <= 32'b0;
			m7 <= 32'b0;
			m8 <= 32'b0;
			m9 <= 32'b0;
			m10 <= 32'b0;
			m11 <= 32'b0;
			m12 <= 32'b0;
			m13 <= 32'b0;
			m14 <= 32'b0;
			m15 <= 32'b0;
			m16 <= 32'b0;
			m17 <= 32'b0;
			m18 <= 32'b0;
			m19 <= 32'b0;
			m20 <= 32'b0;
			m21 <= 32'b0;
			m22 <= 32'b0;
			m23 <= 32'b0;
			m24 <= 32'b0;
			m25 <= 32'b0;
			m26 <= 32'b0;
			m27 <= 32'b0;
			m28 <= 32'b0;
			m29 <= 32'b0;
			m30 <= 32'b0;
			m31 <= 32'b0;
			m32 <= 32'b0;
			m33 <= 32'b0;
			m34 <= 32'b0;
			m35 <= 32'b0;
			m36 <= 32'b0;
			m37 <= 32'b0;
			m38 <= 32'b0;
			m39 <= 32'b0;
			m40 <= 32'b0;
			m41 <= 32'b0;
			m42 <= 32'b0;
			m43 <= 32'b0;
			m44 <= 32'b0;
			m45 <= 32'b0;
			m46 <= 32'b0;
			m47 <= 32'b0;
			m48 <= 32'b0;
			m49 <= 32'b0;
			m50 <= 32'b0;
			m51 <= 32'b0;
			m52 <= 32'b0;
			m53 <= 32'b0;
			m54 <= 32'b0;
			m55 <= 32'b0;
			m56 <= 32'b0;
			m57 <= 32'b0;
			m58 <= 32'b0;
			m59 <= 32'b0;
			m60 <= 32'b0;
			m61 <= 32'b0;
			m62 <= 32'b0;
			m63 <= 32'b0;
		end
		else begin
			if (dmem_wr) begin
				data0 <= (dmem_addr[8:2] == 7'b0000001) ? dmem_writedata : data0;
				data1 <= (dmem_addr[8:2] == 7'b0000010) ? dmem_writedata : data1;
				data2 <= (dmem_addr[8:2] == 7'b0000011) ? dmem_writedata : data2;
				data3 <= (dmem_addr[8:2] == 7'b0000100) ? dmem_writedata : data3;
				data4 <= (dmem_addr[8:2] == 7'b0000101) ? dmem_writedata : data4;
				data5 <= (dmem_addr[8:2] == 7'b0000110) ? dmem_writedata : data5;
				data6 <= (dmem_addr[8:2] == 7'b0000111) ? dmem_writedata : data6;
				data7 <= (dmem_addr[8:2] == 7'b0001000) ? dmem_writedata : data7;
				data8 <= (dmem_addr[8:2] == 7'b0001001) ? dmem_writedata : data8;
				data9 <= (dmem_addr[8:2] == 7'b0001010) ? dmem_writedata : data9;
				data10 <= (dmem_addr[8:2] == 7'b0001011) ? dmem_writedata : data10;
				data11 <= (dmem_addr[8:2] == 7'b0001100) ? dmem_writedata : data11;
				data12 <= (dmem_addr[8:2] == 7'b0001101) ? dmem_writedata : data12;
				data13 <= (dmem_addr[8:2] == 7'b0001110) ? dmem_writedata : data13;
				data14 <= (dmem_addr[8:2] == 7'b0001111) ? dmem_writedata : data14;
				data15 <= (dmem_addr[8:2] == 7'b0010000) ? dmem_writedata : data15;
				datalen <= (dmem_addr[8:2] == 7'b1011010) ? dmem_writedata : datalen;
				bitlen[0] <= (dmem_addr[8:2] == 7'b1011011) ? dmem_writedata : bitlen[0];
				bitlen[1] <= (dmem_addr[8:2] == 7'b1011100) ? dmem_writedata : bitlen[1];	
			end
			else begin
				data0  <= data0; 
				data1  <= data1; 
				data2  <= data2; 
				data3  <= data3; 
				data4  <= data4; 
				data5  <= data5; 
				data6  <= data6; 
				data7  <= data7; 
				data8  <= data8; 
				data9  <= data9; 
				data10 <= data10;
				data11 <= data11;
				data12 <= data12;
				data13 <= data13;
				data14 <= data14;
				data15 <= data15;
				m0 <= (counter == 0) ?  {data0[7:0], data0[15:8], data0[23:16], data0[31:24]} : m0;
				m1 <= (counter == 0) ?  {data1[7:0], data1[15:8], data1[23:16], data1[31:24]} : m1;
				m2 <= (counter == 0) ?  {data2[7:0], data2[15:8], data2[23:16], data2[31:24]} : m2;
				m3 <= (counter == 0) ?  {data3[7:0], data3[15:8], data3[23:16], data3[31:24]} : m3; 
				m4 <= (counter == 0) ?  {data4[7:0], data4[15:8], data4[23:16], data4[31:24]} : m4;
				m5 <= (counter == 0) ?  {data5[7:0], data5[15:8], data5[23:16], data5[31:24]} : m5;
				m6 <= (counter == 0) ?  {data6[7:0], data6[15:8], data6[23:16], data6[31:24]} : m6;
				m7 <= (counter == 0) ?  {data7[7:0], data7[15:8], data7[23:16], data7[31:24]} : m7;
				m8 <= (counter == 0) ?  {data8[7:0], data8[15:8], data8[23:16], data8[31:24]} : m8;
				m9 <= (counter == 0) ?  {data9[7:0], data9[15:8], data9[23:16], data9[31:24]} : m9;
				m10 <= (counter == 0) ? {data10[7:0], data10[15:8], data10[23:16], data10[31:24]} : m10;
				m11 <= (counter == 0) ? {data11[7:0], data11[15:8], data11[23:16], data11[31:24]} : m11;
				m12 <= (counter == 0) ? {data12[7:0], data12[15:8], data12[23:16], data12[31:24]} : m12;
				m13 <= (counter == 0) ? {data13[7:0], data13[15:8], data13[23:16], data13[31:24]} : m13;
				m14 <= (counter == 0) ? {data14[7:0], data14[15:8], data14[23:16], data14[31:24]} : m14;
				m15 <= (counter == 0) ? {data15[7:0], data15[15:8], data15[23:16], data15[31:24]} : m15;
				m16 <= (counter == 16'd1) ? `SIG1(m14) + m9 + `SIG0(m1) + m0 : m16;
				m17 <= (counter == 16'd1) ? `SIG1(m15) + m10 + `SIG0(m2) + m1 : m17;
				m18 <= (counter == 16'd2) ? `SIG1(m16) + m11 + `SIG0(m3) + m2 : m18;
				m19 <= (counter == 16'd2) ? `SIG1(m17) + m12 + `SIG0(m4) + m3 : m19;
				m20 <= (counter == 16'd3) ? `SIG1(m18) + m13 + `SIG0(m5) + m4 : m20;
				m21 <= (counter == 16'd3) ? `SIG1(m19) + m14 + `SIG0(m6) + m5 : m21;
				m22 <= (counter == 16'd4) ? `SIG1(m20) + m15 + `SIG0(m7) + m6 : m22;
				m23 <= (counter == 16'd4) ? `SIG1(m21) + m16 + `SIG0(m8) + m7 : m23;
				m24 <= (counter == 16'd5) ? `SIG1(m22) + m17 + `SIG0(m9) + m8 : m24;
				m25 <= (counter == 16'd5) ? `SIG1(m23) + m18 + `SIG0(m10) + m9 : m25;
				m26 <= (counter == 16'd6) ? `SIG1(m24) + m19 + `SIG0(m11) + m10 : m26;
				m27 <= (counter == 16'd6) ? `SIG1(m25) + m20 + `SIG0(m12) + m11 : m27;
				m28 <= (counter == 16'd7) ? `SIG1(m26) + m21 + `SIG0(m13) + m12 : m28;
				m29 <= (counter == 16'd7) ? `SIG1(m27) + m22 + `SIG0(m14) + m13 : m29;
				m30 <= (counter == 16'd8) ? `SIG1(m28) + m23 + `SIG0(m15) + m14 : m30;
				m31 <= (counter == 16'd8) ? `SIG1(m29) + m24 + `SIG0(m16) + m15 : m31;
				m32 <= (counter == 16'd9) ? `SIG1(m30) + m25 + `SIG0(m17) + m16 : m32;
				m33 <= (counter == 16'd9) ? `SIG1(m31) + m26 + `SIG0(m18) + m17 : m33;
				m34 <= (counter == 16'd10) ? `SIG1(m32) + m27 + `SIG0(m19) + m18 : m34;
				m35 <= (counter == 16'd10) ? `SIG1(m33) + m28 + `SIG0(m20) + m19 : m35;
				m36 <= (counter == 16'd11) ? `SIG1(m34) + m29 + `SIG0(m21) + m20 : m36;
				m37 <= (counter == 16'd11) ? `SIG1(m35) + m30 + `SIG0(m22) + m21 : m37;
				m38 <= (counter == 16'd12) ? `SIG1(m36) + m31 + `SIG0(m23) + m22 : m38;
				m39 <= (counter == 16'd12) ? `SIG1(m37) + m32 + `SIG0(m24) + m23 : m39;
				m40 <= (counter == 16'd13) ? `SIG1(m38) + m33 + `SIG0(m25) + m24 : m40;
				m41 <= (counter == 16'd13) ? `SIG1(m39) + m34 + `SIG0(m26) + m25 : m41;
				m42 <= (counter == 16'd14) ? `SIG1(m40) + m35 + `SIG0(m27) + m26 : m42;
				m43 <= (counter == 16'd14) ? `SIG1(m41) + m36 + `SIG0(m28) + m27 : m43;
				m44 <= (counter == 16'd15) ? `SIG1(m42) + m37 + `SIG0(m29) + m28 : m44;
				m45 <= (counter == 16'd15) ? `SIG1(m43) + m38 + `SIG0(m30) + m29 : m45;
				m46 <= (counter == 16'd16) ? `SIG1(m44) + m39 + `SIG0(m31) + m30 : m46;
				m47 <= (counter == 16'd16) ? `SIG1(m45) + m40 + `SIG0(m32) + m31 : m47;
				m48 <= (counter == 16'd17) ? `SIG1(m46) + m41 + `SIG0(m33) + m32 : m48;
				m49 <= (counter == 16'd17) ? `SIG1(m47) + m42 + `SIG0(m34) + m33 : m49;
				m50 <= (counter == 16'd18) ? `SIG1(m48) + m43 + `SIG0(m35) + m34 : m50;
				m51 <= (counter == 16'd18) ? `SIG1(m49) + m44 + `SIG0(m36) + m35 : m51;
				m52 <= (counter == 16'd19) ? `SIG1(m50) + m45 + `SIG0(m37) + m36 : m52;
				m53 <= (counter == 16'd19) ? `SIG1(m51) + m46 + `SIG0(m38) + m37 : m53;
				m54 <= (counter == 16'd20) ? `SIG1(m52) + m47 + `SIG0(m39) + m38 : m54;
				m55 <= (counter == 16'd20) ? `SIG1(m53) + m48 + `SIG0(m40) + m39 : m55;
				m56 <= (counter == 16'd21) ? `SIG1(m54) + m49 + `SIG0(m41) + m40 : m56;
				m57 <= (counter == 16'd21) ? `SIG1(m55) + m50 + `SIG0(m42) + m41 : m57;
				m58 <= (counter == 16'd22) ? `SIG1(m56) + m51 + `SIG0(m43) + m42 : m58;
				m59 <= (counter == 16'd22) ? `SIG1(m57) + m52 + `SIG0(m44) + m43 : m59;
				m60 <= (counter == 16'd23) ? `SIG1(m58) + m53 + `SIG0(m45) + m44 : m60;
				m61 <= (counter == 16'd23) ? `SIG1(m59) + m54 + `SIG0(m46) + m45 : m61;
				m62 <= (counter == 16'd24) ? `SIG1(m60) + m55 + `SIG0(m47) + m46 : m62;
				m63 <= (counter == 16'd24) ? `SIG1(m61) + m56 + `SIG0(m48) + m47 : m63;
			end
				counter <= go_bit_in? 16'h00 : done_bit_in ? counter : counter + 16'h01;
		end
		
	assign done_bit_in = (counter == 16'd25);
		
	 always @(posedge clk or negedge rst_n)
		if(~rst_n) done_bit <= 1'b0;
		else done_bit <= go_bit_in ? 1'b0 : done_bit_in;
	 


always_ff @(posedge clk) begin
    if (dmem_rd) begin
        dmem_rdata_shift_reg <= dmem_addr[1:0];
    end
end

assign dmem_rdata = dmem_rdata_local >> ( 8 * dmem_rdata_shift_reg );



endmodule : scr1_accel




module RotateLeftModule (
  input [31:0] a,
  input [4:0] b,
  output reg [31:0] rotated
);

  always @* begin
    rotated = (a << b) | (a >> (32 - b));
  end

endmodule

module RotateRightModule (
  input [31:0] a,
  input [4:0] b,
  output reg [31:0] rotated
);

  always @* begin
    rotated = (a >> b) | (a << (32 - b));
  end

endmodule

module DoubleIntAddModule (
  input wire [31:0] a,
  input wire [31:0] b,
  input wire [31:0] c,
  output reg [31:0] result
);

  always @* begin
    if (a > 32'hFFFFFFFF - c)
      result = b + 1;
    else
      result = b;

    result = result + c;
  end

endmodule

module ChModule (
  input wire [31:0] x,
  input wire [31:0] y,
  input wire [31:0] z,
  output reg [31:0] result
);

  always @* begin
    result = (x & y) ^ (~x & z);
  end

endmodule

module MajModule (
  input wire [31:0] x,
  input wire [31:0] y,
  input wire [31:0] z,
  output reg [31:0] result
);

  always @* begin
    result = (x & y) ^ (x & z) ^ (y & z);
  end

endmodule

module EP0Module (
  input wire [31:0] x,
  output reg [31:0] result
);

  RotateRightModule rr1 (.a(x), .b(2), .rotated(result));
  RotateRightModule rr2 (.a(x), .b(13), .rotated(result));

  always @* begin
    result = result ^ (x >> 22);
  end

endmodule

module EP1Module (
  input wire [31:0] x,
  output reg [31:0] result
);

  RotateRightModule rr1 (.a(x), .b(6), .rotated(result));
  RotateRightModule rr2 (.a(x), .b(11), .rotated(result));

  always @* begin
    result = result ^ (x >> 25);
  end

endmodule

module SIG0Module (
  input wire [31:0] x,
  output reg [31:0] result
);

  RotateRightModule rr1 (.a(x), .b(7), .rotated(result));
  RotateRightModule rr2 (.a(x), .b(18), .rotated(result));

  always @* begin
    result = result ^ (x >> 3);
  end

endmodule

module SIG1Module (
  input wire [31:0] x,
  output reg [31:0] result
);

  RotateRightModule rr1 (.a(x), .b(17), .rotated(result));
  RotateRightModule rr2 (.a(x), .b(19), .rotated(result));

  always @* begin
    result = result ^ (x >> 10);
  end

endmodule