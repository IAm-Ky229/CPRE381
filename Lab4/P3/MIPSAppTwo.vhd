library IEEE;
use IEEE.std_logic_1164.all;

entity MIPSAppTwo is

generic(N: integer := 32;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

port(i_MIPSCLK   : in std_logic;
	i_MIPSReadRS, i_MIPSReadRT, i_MIPSWriteAddress   : in std_logic_vector(4 downto 0); 
	i_MIPSWriteEnable, i_ALUSRC, i_MIPSnAddSub  : in std_logic;
	i_MIPSRes : in std_logic_vector(31 downto 0);
	i_MIPSImmediate   : in std_logic_vector(15 downto 0); 
	o_MIPSOutputRS,o_MIPSOutputRT  : out std_logic_vector(31 downto 0);
	i_RegFilesrc : in std_logic;
	i_RAMwe : in std_logic);
end MIPSAppTwo;

architecture structure of MIPSAppTwo is

component RegisterFile
port(i_WriteSignal   : in std_logic_vector(4 downto 0);
		i_InputData   : in std_logic_vector(N-1 downto 0);
		i_CLK   : in std_logic;
		i_MasterWriteEn   : in std_logic;
		i_MasterRes   : in std_logic_vector(N-1 downto 0);
		i_ReadRS   : in std_logic_vector(4 downto 0);
		i_ReadRT   : in std_logic_vector(4 downto 0);
		o_OutputRS   : out std_logic_vector(N-1 downto 0);
		o_OutputRT   : out std_logic_vector(N-1 downto 0));
end component;

component AdderSubtractorALU
port( i_Aalu  :  in std_logic_vector(N-1 downto 0);
	i_Balu :  in std_logic_vector(N-1 downto 0);
	nAdd_Sub :  in std_logic;
	o_Falu :  out std_logic_vector(N-1 downto 0);
	o_carOutalu : out std_logic);
end component;

component ThirtyTwoBitTwoToOneMux
port(i_A, i_B   :   in std_logic_vector(31 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(31 downto 0));
end component;

component mem
port 
	(
		clk		: in std_logic;
		addr	        : in std_logic_vector((10-1) downto 0);
		data	        : in std_logic_vector((32-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((32-1) downto 0)
	);
end component;

component SignedNumberExtender

port( i_input	: in	std_logic_vector(15 downto 0);
	o_output	: out std_logic_vector(31 downto 0));

end component;

signal s_OutputRS, s_OutputRT, s_ALUMUXOutput, s_RouteALUData, s_ExtendedImmed, s_RegFilesrc, s_MemoryQ : std_logic_vector(31 downto 0);
signal s_ALUCarryOut : std_logic;

begin



--Create register file
GRegisters: for i in 0 to 0 generate
	BuildRegister : RegisterFile
port map( i_WriteSignal => i_MIPSWriteAddress,
	i_InputData => s_RegFilesrc,
	i_CLK => i_MIPSCLK,
	i_MasterWriteEn => i_MIPSWriteEnable,
	i_MasterRes => i_MIPSRes,
	i_ReadRS => i_MIPSReadRS,
	i_ReadRT => i_MIPSReadRT,
	o_OutputRS => s_OutputRS,
	o_OutputRT => s_OutputRT);
end generate;

o_MIPSOutputRS <= s_OutputRS;
o_MIPSOutputRT <= s_OutputRT;

--Create memory module
Gmemory: for i in 0 to 0 generate
	RAM : mem
port map(clk => i_MIPSCLK,
	addr => s_RouteALUData(9 downto 0),
	data => s_OutputRT,
	we => i_RAMwe,
	q => s_MemoryQ);
end generate;

--Create 2:1 MUX in front of Reg file
--0 = memory, 1 = ALU
GRegfilesel: for i in 0 to 0 generate
	REGFILEMUX : ThirtyTwoBitTwoToOneMux
port map(i_A => s_MemoryQ,
	i_B => s_RouteALUData,
	i_SELECT => i_RegFilesrc,
	o_OUTPUT => s_RegFilesrc);
end generate;

--Create signed extender
Gextender: for i in 0 to 0 generate
	EXTEND: SignedNumberExtender
port map( i_input => i_MIPSImmediate,
	o_output => s_ExtendedImmed);
end generate;

--Create 2:1 MUX in front of ALU
--0 = OutputRT, 1 = ExtendedImmediate
GALUsel: for i in 0 to 0 generate
	ALUMUX : ThirtyTwoBitTwoToOneMux
port map(i_A => s_OutputRT,
	i_B => s_ExtendedImmed,
	i_SELECT => i_ALUsrc,
	o_OUTPUT => s_ALUMUXOutput);
end generate;

--Create ALU with MUXed input
GALU: for i in 0 to 0 generate
	BuildALU : AdderSubtractorALU
port map( i_Aalu => s_OutputRS,
	i_Balu => s_ALUMUXOutput,
	nAdd_Sub => i_MIPSnAddSub,
	o_Falu => s_RouteALUData,
	o_carOutalu => s_ALUCarryOut);
end generate;


end structure;