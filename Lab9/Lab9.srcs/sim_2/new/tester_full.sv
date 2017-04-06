`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/29/2017
//
// This is a self-checking tester for your full MIPS processor 
// (Lab 9).  Use the test program for "full test" povided on the website,
// i.e., initialize instruction memory with full_imem.mem, and data memory
// with full_dmem.mem.
//
// Use this tester carefully!  The names of your top-level input/output
// and internal signals may be different, so modify all of signal names on the
// right-hand-side of the "wire" assigments appearing above the uut
// instantiation.  Observe that the uut itself only has clock and reset inputs
// now, and no debug outputs.  Instead, the internal signals are "pulled out"
// using the member selection, or dot, operator (".").
//
// If you decide not to use some of these internal signals for debugging, you
// may comment the relevant lines out.  Be sure to comment out the
// corresponding "ERROR_*" lines below as well.
//
//////////////////////////////////////////////////////////////////////////////////


module mips_tester_full;

    // Inputs
    logic clk;
    logic reset;

    // Signals inside top-level module uut
    wire [31:0] pc             =uut.pc;                     // PC
    wire [31:0] instr          =uut.instr;                  // instr coming out of instr mem
    wire [31:0] mem_addr       =uut.mem_addr;               // addr sent to data mem
    wire        mem_wr         =uut.mem_wr;                 // write enable for data mem
    wire [31:0] mem_readdata   =uut.mem_readdata;           // data read from data mem
    wire [31:0] mem_writedata  =uut.mem_writedata;          // write data for data mem

    // Signals inside module uut.mips
    wire        werf           =uut.mips.werf;              // WERF = write enable for register file
    wire  [4:0] alufn          =uut.mips.alufn;             // ALU function
    wire        Z              =uut.mips.Z;                 // Zero flag

    // Signals inside module uut.mips.dp (datapath)
    wire [31:0] ReadData1      =uut.mips.dp.ReadData1;       // Reg[rs]
    wire [31:0] ReadData2      =uut.mips.dp.ReadData2;       // Reg[rt]
    wire [31:0] alu_result     =uut.mips.dp.alu_result;      // ALU's output
    wire [4:0]  reg_writeaddr  =uut.mips.dp.WriteAddr;   // destination register
    wire [31:0] reg_writedata  =uut.mips.dp.reg_writedata;   // write data for register file
    wire [31:0] signImm        =uut.mips.dp.imme;         // sign-/zero-extended immediate
    wire [31:0] aluA           =uut.mips.dp.AluDataA;            // operand A for ALU
    wire [31:0] aluB           =uut.mips.dp.AluDataB;            // operand B for ALU

    // Signals inside module uut.mips.c (controller)
    wire [1:0] pcsel           =uut.mips.c.pcsel;
    wire [1:0] wasel           =uut.mips.c.wasel;
    wire sext                  =uut.mips.c.sext;
    wire bsel                  =uut.mips.c.bsel;
    wire [1:0] wdsel           =uut.mips.c.wdsel;
    wire wr                    =uut.mips.c.wr;
    wire [1:0] asel            =uut.mips.c.asel;


    // Instantiate the Unit Under Test (UUT)
    top #("full_imem.mem", "full_dmem.mem") uut(
        .clk(clk), 
        .reset(reset)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 0;
    end

    initial begin
        #0.5 clk = 0;
        forever
            #0.5 clk = ~clk;
    end
   
    initial begin
        #80 $finish;
    end
   
   
   
    // SELF-CHECKING CODE
   
    selfcheck c();

    wire [31:0] c_pc=c.pc;
    wire [31:0] c_instr=c.instr;
    wire [31:0] c_mem_addr=c.mem_addr;
    wire        c_mem_wr=c.mem_wr;
    wire [31:0] c_mem_readdata=c.mem_readdata;
    wire [31:0] c_mem_writedata=c.mem_writedata;
    wire        c_werf=c.werf;
    wire  [4:0] c_alufn=c.alufn;
    wire        c_Z=c.Z;
    wire [31:0] c_ReadData1=c.ReadData1;
    wire [31:0] c_ReadData2=c.ReadData2;
    wire [31:0] c_alu_result=c.alu_result;
    wire [4:0]  c_reg_writeaddr=c.reg_writeaddr;
    wire [31:0] c_reg_writedata=c.reg_writedata;
    wire [31:0] c_signImm=c.signImm;
    wire [31:0] c_aluA=c.aluA;
    wire [31:0] c_aluB=c.aluB;
    wire [1:0]  c_pcsel=c.pcsel;
    wire [1:0]  c_wasel=c.wasel;
    wire        c_sext=c.sext;
    wire        c_bsel=c.bsel;
    wire [1:0]  c_wdsel=c.wdsel;
    wire        c_wr=c.wr;
    wire [1:0]  c_asel=c.asel;

  
    function mismatch;  // some trickery needed to match two values with don't cares
        input p, q;      // mismatch in a bit position is ignored if q has an 'x' in that bit
        integer p, q;
        mismatch = (((p ^ q) ^ q) !== q);
    endfunction

   
    wire ERROR;

    wire ERROR_pc             = mismatch(pc, c.pc) ? 1'bx : 1'b0;
    wire ERROR_instr          = mismatch(instr, c.instr) ? 1'bx : 1'b0;
    wire ERROR_mem_addr       = mismatch(mem_addr, c.mem_addr) ? 1'bx : 1'b0;
    wire ERROR_mem_wr         = mismatch(mem_wr, c.mem_wr) ? 1'bx : 1'b0;
    wire ERROR_mem_readdata   = mismatch(mem_readdata, c.mem_readdata) ? 1'bx : 1'b0;
    wire ERROR_mem_writedata  = c.mem_wr & (mismatch(mem_writedata, c.mem_writedata) ? 1'bx : 1'b0);
    wire ERROR_werf           = mismatch(werf, c.werf) ? 1'bx : 1'b0;
    wire ERROR_alufn          = mismatch(alufn, c.alufn) ? 1'bx : 1'b0;
    wire ERROR_Z              = mismatch(Z, c.Z) ? 1'bx : 1'b0;
    wire ERROR_ReadData1      = mismatch(ReadData1, c.ReadData1) ? 1'bx : 1'b0;
    wire ERROR_ReadData2      = mismatch(ReadData2, c.ReadData2) ? 1'bx : 1'b0;
    wire ERROR_alu_result     = mismatch(alu_result, c.alu_result) ? 1'bx : 1'b0;
    wire ERROR_reg_writeaddr  = c.werf & (mismatch(reg_writeaddr, c.reg_writeaddr) ? 1'bx : 1'b0);
    wire ERROR_reg_writedata  = c.werf & (mismatch(reg_writedata, c.reg_writedata) ? 1'bx : 1'b0);
    wire ERROR_signImm        = mismatch(signImm, c.signImm) ? 1'bx : 1'b0;
    wire ERROR_aluA           = mismatch(aluA, c.aluA) ? 1'bx : 1'b0;
    wire ERROR_aluB           = mismatch(aluB, c.aluB) ? 1'bx : 1'b0;
    wire ERROR_pcsel          = mismatch(pcsel, c.pcsel) ? 1'bx : 1'b0;
    wire ERROR_wasel          = c.werf & (mismatch(wasel, c.wasel) ? 1'bx : 1'b0);
    wire ERROR_sext           = mismatch(sext, c.sext) ? 1'bx : 1'b0;
    wire ERROR_bsel           = mismatch(bsel, c.bsel) ? 1'bx : 1'b0;
    wire ERROR_wdsel          = mismatch(wdsel, c.wdsel) ? 1'bx : 1'b0;
    wire ERROR_wr             = mismatch(wr, c.wr) ? 1'bx : 1'b0;
    wire ERROR_asel           = mismatch(asel, c.asel) ? 1'bx : 1'b0;

    assign ERROR = ERROR_pc | ERROR_instr | ERROR_mem_addr | ERROR_mem_wr | ERROR_mem_readdata 
              | ERROR_mem_writedata | ERROR_werf | ERROR_alufn | ERROR_Z
              | ERROR_ReadData1 | ERROR_ReadData2 | ERROR_alu_result | ERROR_reg_writeaddr
              | ERROR_reg_writedata | ERROR_signImm | ERROR_aluA | ERROR_aluB
              | ERROR_pcsel | ERROR_wasel | ERROR_sext | ERROR_bsel | ERROR_wdsel | ERROR_wr | ERROR_asel;


    initial begin
        $monitor("#%02d {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h%h, 32'h%h, 32'h%h, 1'b%b, 32'h%h, 32'h%h, 1'b%b, 5'b%b, 1'b%b, 32'h%h, 32'h%h, 32'h%h, 5'h%h, 32'h%h, 32'h%h, 32'h%h, 32'h%h, 2'b%b, 2'b%b, 1'b%b, 1'b%b, 2'b%b, 1'b%b, 2'b%b};",
            $time, pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel);
    end
     
endmodule



// CHECKER MODULE
module selfcheck();
    logic  [31:0] pc;
    logic  [31:0] instr;
    logic  [31:0] mem_addr;
    logic         mem_wr;
    logic  [31:0] mem_readdata;
    logic  [31:0] mem_writedata;
    logic         werf;
    logic   [4:0] alufn;
    logic         Z;
    logic  [31:0] ReadData1;
    logic  [31:0] ReadData2;
    logic  [31:0] alu_result;
    logic  [4:0]  reg_writeaddr;
    logic  [31:0] reg_writedata;
    logic  [31:0] signImm;
    logic  [31:0] aluA;
    logic  [31:0] aluB;
    logic  [1:0] pcsel;
    logic  [1:0] wasel;
    logic        sext;
    logic        bsel;
    logic  [1:0] wdsel;
    logic        wr;
    logic  [1:0] asel;
    
initial begin
fork
#00 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000000, 32'h201d003c, 32'h0000003c, 1'b0, 32'hxxxxxxxx, 32'hxxxxxxxx, 1'b1, 5'b0xx01, 1'b0, 32'h00000000, 32'hxxxxxxxx, 32'h0000003c, 5'h1d, 32'h0000003c, 32'h0000003c, 32'h00000000, 32'h0000003c, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#01 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000004, 32'h3c08ffff, 32'hffff0000, 1'b0, 32'hxxxxxxxx, 32'hxxxxxxxx, 1'b1, 5'bx0010, 1'b0, 32'h00000000, 32'hxxxxxxxx, 32'hffff0000, 5'h08, 32'hffff0000, 32'hxxxxffff, 32'h00000010, 32'hxxxxffff, 2'b00, 2'b01, 1'bx, 1'b1, 2'b01, 1'b0, 2'b10};
#02 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000008, 32'h3508ffff, 32'hffffffff, 1'b0, 32'hxxxxxxxx, 32'hffff0000, 1'b1, 5'bx0100, 1'b0, 32'hffff0000, 32'hffff0000, 32'hffffffff, 5'h08, 32'hffffffff, 32'h0000ffff, 32'hffff0000, 32'h0000ffff, 2'b00, 2'b01, 1'b0, 1'b1, 2'b01, 1'b0, 2'b00};
#03 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000000c, 32'h2009ffff, 32'hffffffff, 1'b0, 32'hxxxxxxxx, 32'hxxxxxxxx, 1'b1, 5'b0xx01, 1'b0, 32'h00000000, 32'hxxxxxxxx, 32'hffffffff, 5'h09, 32'hffffffff, 32'hffffffff, 32'h00000000, 32'hffffffff, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#04 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000010, 32'h1509001b, 32'h00000000, 1'b0, 32'h00000000, 32'hffffffff, 1'b0, 5'b1xx01, 1'b1, 32'hffffffff, 32'hffffffff, 32'h00000000, 5'hxx, 32'hxxxxxxxx, 32'h0000001b, 32'hffffffff, 32'hffffffff, 2'b00, 2'bxx, 1'b1, 1'b0, 2'bxx, 1'b0, 2'b00};
#05 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000014, 32'h00084600, 32'hff000000, 1'b0, 32'hxxxxxxxx, 32'hffffffff, 1'b1, 5'bx0010, 1'b0, 32'h00000000, 32'hffffffff, 32'hff000000, 5'h08, 32'hff000000, 32'h00004600, 32'h00000018, 32'hffffffff, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b01};
#06 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000018, 32'h3508f000, 32'hff00f000, 1'b0, 32'hxxxxxxxx, 32'hff000000, 1'b1, 5'bx0100, 1'b0, 32'hff000000, 32'hff000000, 32'hff00f000, 5'h08, 32'hff00f000, 32'h0000f000, 32'hff000000, 32'h0000f000, 2'b00, 2'b01, 1'b0, 1'b1, 2'b01, 1'b0, 2'b00};
#07 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000001c, 32'h00084203, 32'hffff00f0, 1'b0, 32'hxxxxxxxx, 32'hff00f000, 1'b1, 5'bx1110, 1'b0, 32'h00000000, 32'hff00f000, 32'hffff00f0, 5'h08, 32'hffff00f0, 32'h00004203, 32'h00000008, 32'hff00f000, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b01};
#08 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000020, 32'h00084102, 32'h0ffff00f, 1'b0, 32'hxxxxxxxx, 32'hffff00f0, 1'b1, 5'bx1010, 1'b0, 32'h00000000, 32'hffff00f0, 32'h0ffff00f, 5'h08, 32'h0ffff00f, 32'h00004102, 32'h00000004, 32'hffff00f0, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b01};
#09 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000024, 32'h340a0003, 32'h00000003, 1'b0, 32'h00000000, 32'hxxxxxxxx, 1'b1, 5'bx0100, 1'b0, 32'h00000000, 32'hxxxxxxxx, 32'h00000003, 5'h0a, 32'h00000003, 32'h00000003, 32'h00000000, 32'h00000003, 2'b00, 2'b01, 1'b0, 1'b1, 2'b01, 1'b0, 2'b00};
#10 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000028, 32'h01495022, 32'h00000004, 1'b0, 32'h00000003, 32'hffffffff, 1'b1, 5'b1xx01, 1'b0, 32'h00000003, 32'hffffffff, 32'h00000004, 5'h0a, 32'h00000004, 32'h00005022, 32'h00000003, 32'hffffffff, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#11 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000002c, 32'h01484004, 32'hffff00f0, 1'b0, 32'hxxxxxxxx, 32'h0ffff00f, 1'b1, 5'bx0010, 1'b0, 32'h00000004, 32'h0ffff00f, 32'hffff00f0, 5'h08, 32'hffff00f0, 32'h00004004, 32'h00000004, 32'h0ffff00f, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#12 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000030, 32'h010a582a, 32'h00000001, 1'b0, 32'h00000000, 32'h00000004, 1'b1, 5'b1x011, 1'b0, 32'hffff00f0, 32'h00000004, 32'h00000001, 5'h0b, 32'h00000001, 32'h0000582a, 32'hffff00f0, 32'h00000004, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#13 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000034, 32'h010a582b, 32'h00000000, 1'b0, 32'h00000000, 32'h00000004, 1'b1, 5'b1x111, 1'b1, 32'hffff00f0, 32'h00000004, 32'h00000000, 5'h0b, 32'h00000000, 32'h0000582b, 32'hffff00f0, 32'h00000004, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#14 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000038, 32'h20080005, 32'h00000005, 1'b0, 32'h00000003, 32'hffff00f0, 1'b1, 5'b0xx01, 1'b0, 32'h00000000, 32'hffff00f0, 32'h00000005, 5'h08, 32'h00000005, 32'h00000005, 32'h00000000, 32'h00000005, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#15 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000003c, 32'h2d0b000a, 32'h00000001, 1'b0, 32'h00000000, 32'h00000000, 1'b1, 5'b1x111, 1'b0, 32'h00000005, 32'h00000000, 32'h00000001, 5'h0b, 32'h00000001, 32'h0000000a, 32'h00000005, 32'h0000000a, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#16 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000040, 32'h2d0b0004, 32'h00000000, 1'b0, 32'h00000000, 32'h00000001, 1'b1, 5'b1x111, 1'b1, 32'h00000005, 32'h00000001, 32'h00000000, 5'h0b, 32'h00000000, 32'h00000004, 32'h00000005, 32'h00000004, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#17 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000044, 32'h2008fffb, 32'hfffffffb, 1'b0, 32'hxxxxxxxx, 32'h00000005, 1'b1, 5'b0xx01, 1'b0, 32'h00000000, 32'h00000005, 32'hfffffffb, 5'h08, 32'hfffffffb, 32'hfffffffb, 32'h00000000, 32'hfffffffb, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#18 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000048, 32'h2d0b0005, 32'h00000000, 1'b0, 32'h00000000, 32'h00000000, 1'b1, 5'b1x111, 1'b1, 32'hfffffffb, 32'h00000000, 32'h00000000, 5'h0b, 32'h00000000, 32'h00000005, 32'hfffffffb, 32'h00000005, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#19 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000004c, 32'h3c0b1010, 32'h10100000, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b1, 5'bx0010, 1'b0, 32'h00000000, 32'h00000000, 32'h10100000, 5'h0b, 32'h10100000, 32'h00001010, 32'h00000010, 32'h00001010, 2'b00, 2'b01, 1'bx, 1'b1, 2'b01, 1'b0, 2'b10};
#20 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000050, 32'h356b1010, 32'h10101010, 1'b0, 32'hxxxxxxxx, 32'h10100000, 1'b1, 5'bx0100, 1'b0, 32'h10100000, 32'h10100000, 32'h10101010, 5'h0b, 32'h10101010, 32'h00001010, 32'h10100000, 32'h00001010, 2'b00, 2'b01, 1'b0, 1'b1, 2'b01, 1'b0, 2'b00};
#21 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000054, 32'h3c0c0101, 32'h01010000, 1'b0, 32'hxxxxxxxx, 32'hxxxxxxxx, 1'b1, 5'bx0010, 1'b0, 32'h00000000, 32'hxxxxxxxx, 32'h01010000, 5'h0c, 32'h01010000, 32'h00000101, 32'h00000010, 32'h00000101, 2'b00, 2'b01, 1'bx, 1'b1, 2'b01, 1'b0, 2'b10};
#22 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000058, 32'h218c1010, 32'h01011010, 1'b0, 32'hxxxxxxxx, 32'h01010000, 1'b1, 5'b0xx01, 1'b0, 32'h01010000, 32'h01010000, 32'h01011010, 5'h0c, 32'h01011010, 32'h00001010, 32'h01010000, 32'h00001010, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#23 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000005c, 32'h016c6824, 32'h00001010, 1'b0, 32'hxxxxxxxx, 32'h01011010, 1'b1, 5'bx0000, 1'b0, 32'h10101010, 32'h01011010, 32'h00001010, 5'h0d, 32'h00001010, 32'h00006824, 32'h10101010, 32'h01011010, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#24 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000060, 32'h016c6825, 32'h11111010, 1'b0, 32'hxxxxxxxx, 32'h01011010, 1'b1, 5'bx0100, 1'b0, 32'h10101010, 32'h01011010, 32'h11111010, 5'h0d, 32'h11111010, 32'h00006825, 32'h10101010, 32'h01011010, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#25 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000064, 32'h016c6826, 32'h11110000, 1'b0, 32'hxxxxxxxx, 32'h01011010, 1'b1, 5'bx1000, 1'b0, 32'h10101010, 32'h01011010, 32'h11110000, 5'h0d, 32'h11110000, 32'h00006826, 32'h10101010, 32'h01011010, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#26 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000068, 32'h016c6827, 32'heeeeefef, 1'b0, 32'hxxxxxxxx, 32'h01011010, 1'b1, 5'bx1100, 1'b0, 32'h10101010, 32'h01011010, 32'heeeeefef, 5'h0d, 32'heeeeefef, 32'h00006827, 32'h10101010, 32'h01011010, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#27 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000006c, 32'h8c040004, 32'h00000004, 1'b0, 32'h00000003, 32'hxxxxxxxx, 1'b1, 5'b0xx01, 1'b0, 32'h00000000, 32'hxxxxxxxx, 32'h00000004, 5'h04, 32'h00000003, 32'h00000004, 32'h00000000, 32'h00000004, 2'b00, 2'b01, 1'b1, 1'b1, 2'b10, 1'b0, 2'b00};
#28 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000070, 32'h20840002, 32'h00000005, 1'b0, 32'h00000003, 32'h00000003, 1'b1, 5'b0xx01, 1'b0, 32'h00000003, 32'h00000003, 32'h00000005, 5'h04, 32'h00000005, 32'h00000002, 32'h00000003, 32'h00000002, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#29 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000074, 32'h2484fffe, 32'h00000003, 1'b0, 32'h00000000, 32'h00000005, 1'b1, 5'b0xx01, 1'b0, 32'h00000005, 32'h00000005, 32'h00000003, 5'h04, 32'h00000003, 32'hfffffffe, 32'h00000005, 32'hfffffffe, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#30 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000078, 32'h0c000021, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b1, 5'bxxxxx, 1'bx, 32'h00000000, 32'h00000000, 32'hxxxxxxxx, 5'h1f, 32'h0000007c, 32'h00000021, 32'hxxxxxxxx, 32'h000000XX, 2'b10, 2'b10, 1'bx, 1'bx, 2'b00, 1'b0, 2'bxx};
#31 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000084, 32'h23bdfff8, 32'h00000034, 1'b0, 32'hxxxxxxxx, 32'h0000003c, 1'b1, 5'b0xx01, 1'b0, 32'h0000003c, 32'h0000003c, 32'h00000034, 5'h1d, 32'h00000034, 32'hfffffff8, 32'h0000003c, 32'hfffffff8, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#32 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000088, 32'hafbf0004, 32'h00000038, 1'b1, 32'hxxxxxxxx, 32'h0000007c, 1'b0, 5'b0xx01, 1'b0, 32'h00000034, 32'h0000007c, 32'h00000038, 5'hxx, 32'hxxxxxxxx, 32'h00000004, 32'h00000034, 32'h00000004, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#33 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000008c, 32'hafa40000, 32'h00000034, 1'b1, 32'hxxxxxxxx, 32'h00000003, 1'b0, 5'b0xx01, 1'b0, 32'h00000034, 32'h00000003, 32'h00000034, 5'hxx, 32'hxxxxxxxx, 32'h00000000, 32'h00000034, 32'h00000000, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#34 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000090, 32'h28880002, 32'h00000000, 1'b0, 32'h00000000, 32'hfffffffb, 1'b1, 5'b1x011, 1'b1, 32'h00000003, 32'hfffffffb, 32'h00000000, 5'h08, 32'h00000000, 32'h00000002, 32'h00000003, 32'h00000002, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#35 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000094, 32'h11000002, 32'h00000000, 1'b0, 32'h00000000, 32'h00000000, 1'b0, 5'b1xx01, 1'b1, 32'h00000000, 32'h00000000, 32'h00000000, 5'hxx, 32'hxxxxxxxx, 32'h00000002, 32'h00000000, 32'h00000000, 2'b01, 2'bxx, 1'b1, 1'b0, 2'bxx, 1'b0, 2'b00};
#36 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000a0, 32'h2084ffff, 32'h00000002, 1'b0, 32'h00000000, 32'h00000003, 1'b1, 5'b0xx01, 1'b0, 32'h00000003, 32'h00000003, 32'h00000002, 5'h04, 32'h00000002, 32'hffffffff, 32'h00000003, 32'hffffffff, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#37 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000a4, 32'h0c000021, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b1, 5'bxxxxx, 1'bx, 32'h00000000, 32'h00000000, 32'hxxxxxxxx, 5'h1f, 32'h000000a8, 32'h00000021, 32'hxxxxxxxx, 32'h000000XX, 2'b10, 2'b10, 1'bx, 1'bx, 2'b00, 1'b0, 2'bxx};
#38 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000084, 32'h23bdfff8, 32'h0000002c, 1'b0, 32'hxxxxxxxx, 32'h00000034, 1'b1, 5'b0xx01, 1'b0, 32'h00000034, 32'h00000034, 32'h0000002c, 5'h1d, 32'h0000002c, 32'hfffffff8, 32'h00000034, 32'hfffffff8, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#39 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000088, 32'hafbf0004, 32'h00000030, 1'b1, 32'hxxxxxxxx, 32'h000000a8, 1'b0, 5'b0xx01, 1'b0, 32'h0000002c, 32'h000000a8, 32'h00000030, 5'hxx, 32'hxxxxxxxx, 32'h00000004, 32'h0000002c, 32'h00000004, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#40 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000008c, 32'hafa40000, 32'h0000002c, 1'b1, 32'hxxxxxxxx, 32'h00000002, 1'b0, 5'b0xx01, 1'b0, 32'h0000002c, 32'h00000002, 32'h0000002c, 5'hxx, 32'hxxxxxxxx, 32'h00000000, 32'h0000002c, 32'h00000000, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#41 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000090, 32'h28880002, 32'h00000000, 1'b0, 32'h00000000, 32'h00000000, 1'b1, 5'b1x011, 1'b1, 32'h00000002, 32'h00000000, 32'h00000000, 5'h08, 32'h00000000, 32'h00000002, 32'h00000002, 32'h00000002, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#42 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000094, 32'h11000002, 32'h00000000, 1'b0, 32'h00000000, 32'h00000000, 1'b0, 5'b1xx01, 1'b1, 32'h00000000, 32'h00000000, 32'h00000000, 5'hxx, 32'hxxxxxxxx, 32'h00000002, 32'h00000000, 32'h00000000, 2'b01, 2'bxx, 1'b1, 1'b0, 2'bxx, 1'b0, 2'b00};
#43 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000a0, 32'h2084ffff, 32'h00000001, 1'b0, 32'h00000000, 32'h00000002, 1'b1, 5'b0xx01, 1'b0, 32'h00000002, 32'h00000002, 32'h00000001, 5'h04, 32'h00000001, 32'hffffffff, 32'h00000002, 32'hffffffff, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#44 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000a4, 32'h0c000021, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b1, 5'bxxxxx, 1'bx, 32'h00000000, 32'h00000000, 32'hxxxxxxxx, 5'h1f, 32'h000000a8, 32'h00000021, 32'hxxxxxxxx, 32'h000000XX, 2'b10, 2'b10, 1'bx, 1'bx, 2'b00, 1'b0, 2'bxx};
#45 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000084, 32'h23bdfff8, 32'h00000024, 1'b0, 32'hxxxxxxxx, 32'h0000002c, 1'b1, 5'b0xx01, 1'b0, 32'h0000002c, 32'h0000002c, 32'h00000024, 5'h1d, 32'h00000024, 32'hfffffff8, 32'h0000002c, 32'hfffffff8, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#46 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000088, 32'hafbf0004, 32'h00000028, 1'b1, 32'hxxxxxxxx, 32'h000000a8, 1'b0, 5'b0xx01, 1'b0, 32'h00000024, 32'h000000a8, 32'h00000028, 5'hxx, 32'hxxxxxxxx, 32'h00000004, 32'h00000024, 32'h00000004, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#47 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000008c, 32'hafa40000, 32'h00000024, 1'b1, 32'hxxxxxxxx, 32'h00000001, 1'b0, 5'b0xx01, 1'b0, 32'h00000024, 32'h00000001, 32'h00000024, 5'hxx, 32'hxxxxxxxx, 32'h00000000, 32'h00000024, 32'h00000000, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#48 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000090, 32'h28880002, 32'h00000001, 1'b0, 32'h00000000, 32'h00000000, 1'b1, 5'b1x011, 1'b0, 32'h00000001, 32'h00000000, 32'h00000001, 5'h08, 32'h00000001, 32'h00000002, 32'h00000001, 32'h00000002, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#49 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000094, 32'h11000002, 32'h00000001, 1'b0, 32'h00000000, 32'h00000000, 1'b0, 5'b1xx01, 1'b0, 32'h00000001, 32'h00000000, 32'h00000001, 5'hxx, 32'hxxxxxxxx, 32'h00000002, 32'h00000001, 32'h00000000, 2'b00, 2'bxx, 1'b1, 1'b0, 2'bxx, 1'b0, 2'b00};
#50 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000098, 32'h00041020, 32'h00000001, 1'b0, 32'h00000000, 32'h00000001, 1'b1, 5'b0xx01, 1'b0, 32'h00000000, 32'h00000001, 32'h00000001, 5'h02, 32'h00000001, 32'h00001020, 32'h00000000, 32'h00000001, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#51 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000009c, 32'h0800002e, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b0, 5'bxxxxx, 1'bx, 32'h00000000, 32'h00000000, 32'hxxxxxxxx, 5'hxx, 32'hxxxxxxxx, 32'h0000002e, 32'hxxxxxxxx, 32'h000000XX, 2'b10, 2'bxx, 1'bx, 1'bx, 2'bxx, 1'b0, 2'bxx};
#52 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b8, 32'h8fbf0004, 32'h00000028, 1'b0, 32'h000000a8, 32'h000000a8, 1'b1, 5'b0xx01, 1'b0, 32'h00000024, 32'h000000a8, 32'h00000028, 5'h1f, 32'h000000a8, 32'h00000004, 32'h00000024, 32'h00000004, 2'b00, 2'b01, 1'b1, 1'b1, 2'b10, 1'b0, 2'b00};
#53 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000bc, 32'h23bd0008, 32'h0000002c, 1'b0, 32'h00000002, 32'h00000024, 1'b1, 5'b0xx01, 1'b0, 32'h00000024, 32'h00000024, 32'h0000002c, 5'h1d, 32'h0000002c, 32'h00000008, 32'h00000024, 32'h00000008, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#54 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000c0, 32'h03e00008, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b0, 5'bxxxxx, 1'bx, 32'h000000a8, 32'h00000000, 32'hxxxxxxxx, 5'hxx, 32'hxxxxxxxx, 32'h00000008, 32'hxxxxxxxx, 32'h0000000X, 2'b11, 2'bxx, 1'bx, 1'bx, 2'bxx, 1'b0, 2'bxx};
#55 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000a8, 32'h8fa40000, 32'h0000002c, 1'b0, 32'h00000002, 32'h00000001, 1'b1, 5'b0xx01, 1'b0, 32'h0000002c, 32'h00000001, 32'h0000002c, 5'h04, 32'h00000002, 32'h00000000, 32'h0000002c, 32'h00000000, 2'b00, 2'b01, 1'b1, 1'b1, 2'b10, 1'b0, 2'b00};
#56 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000ac, 32'h00441020, 32'h00000003, 1'b0, 32'h00000000, 32'h00000002, 1'b1, 5'b0xx01, 1'b0, 32'h00000001, 32'h00000002, 32'h00000003, 5'h02, 32'h00000003, 32'h00001020, 32'h00000001, 32'h00000002, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#57 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b0, 32'h00441020, 32'h00000005, 1'b0, 32'h00000003, 32'h00000002, 1'b1, 5'b0xx01, 1'b0, 32'h00000003, 32'h00000002, 32'h00000005, 5'h02, 32'h00000005, 32'h00001020, 32'h00000003, 32'h00000002, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#58 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b4, 32'h2042ffff, 32'h00000004, 1'b0, 32'h00000003, 32'h00000005, 1'b1, 5'b0xx01, 1'b0, 32'h00000005, 32'h00000005, 32'h00000004, 5'h02, 32'h00000004, 32'hffffffff, 32'h00000005, 32'hffffffff, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#59 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b8, 32'h8fbf0004, 32'h00000030, 1'b0, 32'h000000a8, 32'h000000a8, 1'b1, 5'b0xx01, 1'b0, 32'h0000002c, 32'h000000a8, 32'h00000030, 5'h1f, 32'h000000a8, 32'h00000004, 32'h0000002c, 32'h00000004, 2'b00, 2'b01, 1'b1, 1'b1, 2'b10, 1'b0, 2'b00};
#60 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000bc, 32'h23bd0008, 32'h00000034, 1'b0, 32'h00000003, 32'h0000002c, 1'b1, 5'b0xx01, 1'b0, 32'h0000002c, 32'h0000002c, 32'h00000034, 5'h1d, 32'h00000034, 32'h00000008, 32'h0000002c, 32'h00000008, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#61 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000c0, 32'h03e00008, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b0, 5'bxxxxx, 1'bx, 32'h000000a8, 32'h00000000, 32'hxxxxxxxx, 5'hxx, 32'hxxxxxxxx, 32'h00000008, 32'hxxxxxxxx, 32'h0000000X, 2'b11, 2'bxx, 1'bx, 1'bx, 2'bxx, 1'b0, 2'bxx};
#62 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000a8, 32'h8fa40000, 32'h00000034, 1'b0, 32'h00000003, 32'h00000002, 1'b1, 5'b0xx01, 1'b0, 32'h00000034, 32'h00000002, 32'h00000034, 5'h04, 32'h00000003, 32'h00000000, 32'h00000034, 32'h00000000, 2'b00, 2'b01, 1'b1, 1'b1, 2'b10, 1'b0, 2'b00};
#63 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000ac, 32'h00441020, 32'h00000007, 1'b0, 32'h00000003, 32'h00000003, 1'b1, 5'b0xx01, 1'b0, 32'h00000004, 32'h00000003, 32'h00000007, 5'h02, 32'h00000007, 32'h00001020, 32'h00000004, 32'h00000003, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#64 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b0, 32'h00441020, 32'h0000000a, 1'b0, 32'hxxxxxxxx, 32'h00000003, 1'b1, 5'b0xx01, 1'b0, 32'h00000007, 32'h00000003, 32'h0000000a, 5'h02, 32'h0000000a, 32'h00001020, 32'h00000007, 32'h00000003, 2'b00, 2'b00, 1'bx, 1'b0, 2'b01, 1'b0, 2'b00};
#65 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b4, 32'h2042ffff, 32'h00000009, 1'b0, 32'hxxxxxxxx, 32'h0000000a, 1'b1, 5'b0xx01, 1'b0, 32'h0000000a, 32'h0000000a, 32'h00000009, 5'h02, 32'h00000009, 32'hffffffff, 32'h0000000a, 32'hffffffff, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#66 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000b8, 32'h8fbf0004, 32'h00000038, 1'b0, 32'h0000007c, 32'h000000a8, 1'b1, 5'b0xx01, 1'b0, 32'h00000034, 32'h000000a8, 32'h00000038, 5'h1f, 32'h0000007c, 32'h00000004, 32'h00000034, 32'h00000004, 2'b00, 2'b01, 1'b1, 1'b1, 2'b10, 1'b0, 2'b00};
#67 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000bc, 32'h23bd0008, 32'h0000003c, 1'b0, 32'hxxxxxxxx, 32'h00000034, 1'b1, 5'b0xx01, 1'b0, 32'h00000034, 32'h00000034, 32'h0000003c, 5'h1d, 32'h0000003c, 32'h00000008, 32'h00000034, 32'h00000008, 2'b00, 2'b01, 1'b1, 1'b1, 2'b01, 1'b0, 2'b00};
#68 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h000000c0, 32'h03e00008, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b0, 5'bxxxxx, 1'bx, 32'h0000007c, 32'h00000000, 32'hxxxxxxxx, 5'hxx, 32'hxxxxxxxx, 32'h00000008, 32'hxxxxxxxx, 32'h0000000X, 2'b11, 2'bxx, 1'bx, 1'bx, 2'bxx, 1'b0, 2'bxx};
#69 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h0000007c, 32'hac020000, 32'h00000000, 1'b1, 32'h00000000, 32'h00000009, 1'b0, 5'b0xx01, 1'b1, 32'h00000000, 32'h00000009, 32'h00000000, 5'hxx, 32'hxxxxxxxx, 32'h00000000, 32'h00000000, 32'h00000000, 2'b00, 2'bxx, 1'b1, 1'b1, 2'bxx, 1'b1, 2'b00};
#70 {pc, instr, mem_addr, mem_wr, mem_readdata, mem_writedata, werf, alufn, Z, ReadData1, ReadData2, alu_result, reg_writeaddr, reg_writedata, signImm, aluA, aluB, pcsel, wasel, sext, bsel, wdsel, wr, asel} <= {32'h00000080, 32'h08000020, 32'hxxxxxxxx, 1'b0, 32'hxxxxxxxx, 32'h00000000, 1'b0, 5'bxxxxx, 1'bx, 32'h00000000, 32'h00000000, 32'hxxxxxxxx, 5'hxx, 32'hxxxxxxxx, 32'h00000020, 32'hxxxxxxxx, 32'h000000X0, 2'b10, 2'bxx, 1'bx, 1'bx, 2'bxx, 1'b0, 2'bxx};
join
end

endmodule