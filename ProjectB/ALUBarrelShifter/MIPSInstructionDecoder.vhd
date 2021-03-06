library IEEE;
use IEEE.std_logic_1164.all;

entity MIPSInstructionDecoder is

port( i_instruction_function : in std_logic_vector(5 downto 0);
	i_instruction_opcode : in std_logic_vector(5 downto 0);
--------------------------------------------
	o_reg_Dst : out std_logic;
	o_reg_Jump : out std_logic;
	o_Branch : out std_logic;
	o_Mem_To_Reg : out std_logic;
	o_Mem_Write : out std_logic;
	o_ALU_Src : out std_logic;
	o_Reg_Write : out std_logic;
---------------------------------------------
        o_ALU_Op : out std_logic_vector(2 downto 0);
	o_ALUn_AddSub : out std_logic;
	o_Shifter_Mux_Control : out std_logic;
	o_Arithmetic : out std_logic;
	o_Sign_Extended : out std_logic;
	o_Left_Shift : out std_logic);
end MIPSInstructionDecoder;


architecture behavior of MIPSInstructionDecoder is

begin

process(i_instruction_opcode, i_instruction_function) is
begin

case i_instruction_opcode is

when "000000" =>

     if i_instruction_function = "100000" then
	-- ADD
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     elsif i_instruction_function = "100001" then
	-- ADDU
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "100100" then
	-- AND
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "010";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "100111" then
	-- NOR
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "110";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "100110" then
	-- XOR
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "101";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "100101" then
	-- OR
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "011";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "101010" then
	-- SLT
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '1';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "101011" then
	-- SLTU
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '1';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "000000" then
	-- SLL
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '1';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '1';


    elsif i_instruction_function = "000010" then
	-- SRL
   ---------------------------------------------
	o_reg_Dst <= '0';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '1';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "000011" then
	-- SRA
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '1';
	o_Arithmetic <= '1';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "000100" then
	-- SLLV
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '1';
	o_Arithmetic <= '1';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "000110" then
	-- SRLV
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '1';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '1';


    elsif i_instruction_function = "000111" then
	-- SRAV
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '1';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "100010" then
	-- SUB
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '1';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


    elsif i_instruction_function = "100011" then
	-- SUBU
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '0';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '1';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';

end if;


     when "001000" =>
	--ADDI
    ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001001" =>
	--ADDIU
    ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001100" => 
	-- ANDI
   ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "010";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Arithmetic <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001111" =>
	--LUI
    ---------------------------------------------
	o_reg_Dst <= '0';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "100011" =>
	--LW
    ---------------------------------------------
	o_reg_Dst <= '0';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '1';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001110" =>
	--XORI
    ---------------------------------------------
	o_reg_Dst <= '0';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "100";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001101" =>
	--ORI
    ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "011";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001010" =>
	--SLTI
    ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '1';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "001011" =>
	--SLTIU
    ---------------------------------------------
	o_reg_Dst <= '1';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '0';
	o_ALU_Src <= '1';
	o_Reg_Write <= '1';
   ---------------------------------------------
	o_ALU_Op <= "001";
	o_ALUn_AddSub <= '1';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';


     when "101011" =>
	--SW
    ---------------------------------------------
	o_reg_Dst <= '0';
	o_reg_Jump <= '0';
	o_Branch <= '0';
	o_Mem_To_Reg <= '0';
	o_Mem_Write <= '1';
	o_ALU_Src <= '1';
	o_Reg_Write <= '0';
   ---------------------------------------------
	o_ALU_Op <= "000";
	o_ALUn_AddSub <= '0';
	o_Shifter_Mux_Control <= '0';
	o_Sign_Extended <= '0';
	o_Left_Shift <= '0';

     when others =>
	-- DO NOTHING

end case;
end process;

end behavior;