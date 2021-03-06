library IEEE;
use IEEE.std_logic_1164.all;

entity tb_MIPSAppBarrelShiftALU is

generic(N : integer := 32;
        gCLK_HPER   : time := 50 ns;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

end tb_MIPSAppBarrelShiftALU;

architecture behavior of tb_MIPSAppBarrelShiftALU is

constant cCLK_PER  : time := gCLK_HPER * 2;

component MIPSAppBarrelShiftALU
port(i_MIPSCLK   : in std_logic; -- Input clock to the processor
	i_MIPSReadRS, i_MIPSReadRT, i_MIPSWriteAddress   : in std_logic_vector(4 downto 0);  -- Register read and write addresses
	i_MIPSWriteEnable, i_ALUSRC, i_MIPSnAddSub  : in std_logic; -- Register write enable, immediate vs RT source select for ALU, and ALU add sub control
	i_MIPSRes : in std_logic_vector(31 downto 0); -- Register reset control
	i_MIPSImmediate   : in std_logic_vector(15 downto 0); -- MIPS immediate value to be added
	o_MIPSOutputRS,o_MIPSOutputRT  : out std_logic_vector(31 downto 0); -- Output RS and RT of register file
	i_RegFilesrc : in std_logic; -- control whether register file reads from itself or the memory module
	i_RAMwe : in std_logic; -- Write enable for ram
	i_MIPSOpControl : in std_logic_vector(2 downto 0); -- operation control for ALU
	i_sign_extended_barrel : in std_logic; -- Sign extender for barrel shifter control
	i_left_shift_barrel : in std_logic; -- shift left and shift right commands for barrel shifter
	i_arithmetic_barrel : in std_logic;
	i_shift_amt_barrel : in std_logic_vector(4 downto 0); -- How much to shift the input to the barrel shifter 
	i_shifterRSInputSelect : in std_logic; -- Select whether we want RS to be shifted or not
	o_Zero : out std_logic; -- Whether the output of the ALU is zero
	o_Overflow : out std_logic; -- Whether the output of the ALU has overflow
	o_Cout : out std_logic);-- The final carry of the last arithmetic operation for the ALU
end component;

signal s_MIPSCLK, s_MIPSWriteEnable, s_ALUsrc, s_MIPSnAddSub, s_RegFilesrc, s_RAMwe : std_logic;
signal s_MIPSReadRS, s_MIPSReadRT, s_MIPSWriteAddress : std_logic_vector(4 downto 0);
signal s_MIPSRes : std_logic_vector(31 downto 0);
signal s_MIPSInputData : std_logic_vector(31 downto 0);
signal s_MIPSImmediate : std_logic_vector(15 downto 0);
signal s_OutputRS, s_OutputRT : std_logic_vector(31 downto 0);
signal s_Zero, s_Overflow, s_Cout : std_logic;
signal s_sign_extended_barrel, s_left_shift_barrel : std_logic;
signal s_arithmetic_barrel : std_logic;
signal s_shift_amt_barrel : std_logic_vector(4 downto 0);
signal s_shifterRSInputSelect : std_logic;
signal s_MIPSOpControl : std_logic_vector(2 downto 0);

begin

DUT : MIPSAppBarrelShiftALU
port map(i_MIPSCLK => s_MIPSCLK,
	i_MIPSReadRS => s_MIPSReadRS,
	i_MIPSReadRT => s_MIPSReadRT,
	i_MIPSWriteAddress => s_MIPSWriteAddress,
	i_MIPSWriteEnable => s_MIPSWriteEnable,
	i_ALUSRC => s_ALUsrc,
	i_MIPSnAddSub => s_MIPSnAddSub,
	i_MIPSRes => s_MIPSRes,
	i_MIPSImmediate => s_MIPSImmediate,
	o_MIPSOutputRS => s_OutputRS,
	o_MIPSOutputRT => s_OutputRT,
	i_RegFilesrc => s_RegFilesrc,
	i_RAMwe => s_RAMwe,
	i_MIPSOpControl => s_MIPSOpControl,
	i_sign_extended_barrel => s_sign_extended_barrel,
	i_left_shift_barrel => s_left_shift_barrel,
	i_arithmetic_barrel => s_arithmetic_barrel,
	i_shift_amt_barrel => s_shift_amt_barrel,
	i_shifterRSInputSelect => s_shifterRSInputSelect,
	o_Zero => s_Zero,
	o_Overflow => s_Overflow,
	o_Cout => s_Cout);

P_CLK: process
  begin
    s_MIPSCLK <= '0';
    wait for gCLK_HPER;
    s_MIPSCLK <= '1';
    wait for gCLK_HPER;
  end process;

S_VALUES: process
begin


wait for gCLK_HPER;

--load &A into $25
s_MIPSOpControl <= "000";
s_shifterRSInputSelect <= '0';
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "11001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';
wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--load &B into $26
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "11010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000001000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--load A[0] into $1
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--load A[1] into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000001";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$1 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';
s_sign_extended_barrel <= '0';
s_left_shift_barrel <= '0';
s_arithmetic_barrel <= '0';
s_shift_amt_barrel <= "00000";
s_shifterRSInputSelect <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11010";
s_MIPSImmediate <= "0000000000000000";
s_MIPSReadRT <= "00001";
--low

wait for gCLK_HPER;

--Store $1 into B[0]

s_MIPSWriteEnable <= '0';
s_MIPSnAddSub <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--Load A[2] into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000010";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$1 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_RegFilesrc <= '0';
s_ALUsrc <= '1';
s_MIPSWriteEnable <= '0';
s_MIPSReadRT <= "00001";
s_MIPSReadRS <= "11010";
s_MIPSImmediate <= "0000000000000001";
--low

wait for gCLK_HPER;

--Store $1 into B[1]

s_MIPSnAddSub <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--Load A[3] into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000011";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$1 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11010";
s_MIPSReadRT <= "00001";
s_MIPSImmediate <= "0000000000000010";
--low

wait for gCLK_HPER;

--Store $1 into B[2]

s_MIPSnAddSub <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--Load A[4] into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00001";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000100";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$1 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11010";
s_MIPSReadRT <= "00001";
s_MIPSImmediate <= "0000000000000011";
--low

wait for gCLK_HPER;

--Store $1 into B[3]

s_MIPSnAddSub <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--Load A[5] into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000101";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$1 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11010";
s_MIPSReadRT <= "00001";
s_MIPSImmediate <= "0000000000000100";
--low

wait for gCLK_HPER;

--Store $1 into B[4]

s_MIPSnAddSub <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--Load A[6] into $2
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000110";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$1 = $1 + $2
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00010";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_MIPSWriteEnable <= '0';

--low

wait for gCLK_HPER;

--Load &B[128] into $27 ($27 = $26 + 512)
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11010";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "11011";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000010000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11011";
s_MIPSReadRT <= "00001";
s_MIPSImmediate <= "0000000000000001";
s_MIPSnAddSub <= '1';
--low

wait for gCLK_HPER;

--Store $1 into B[127]


s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';
wait for gCLK_HPER;

--###############################

wait for gCLK_HPER;

--load &C (200) into $28
s_MIPSOpControl <= "000";
s_shifterRSInputSelect <= '0';
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "11100";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000011001000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--load &D (260) into $29
s_MIPSOpControl <= "000";
s_shifterRSInputSelect <= '0';
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00000";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "11101";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000100000100";
s_RegFilesrc <= '1';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--load A[0] into $1
s_ALUsrc <= '1';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "11001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00001";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '0';
s_RAMwe <= '0';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;
--$2 = $1 srl(1) + $0

s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';
s_sign_extended_barrel <= '0';
s_left_shift_barrel <= '0';
s_arithmetic_barrel <= '0';
s_shift_amt_barrel <= "00001";
s_shifterRSInputSelect <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_shifterRSInputSelect <= '0';
s_RegFilesrc <= '0';
s_ALUsrc <= '1';
s_MIPSWriteEnable <= '0';
s_MIPSReadRT <= "00010";
s_MIPSReadRS <= "11101";
s_MIPSImmediate <= "0000000000000000";
--low

wait for gCLK_HPER;

--Store $2 into D[0]

s_MIPSWriteEnable <= '0';
s_MIPSnAddSub <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$2 = $1 sll(1) + $0
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';
s_sign_extended_barrel <= '0';
s_left_shift_barrel <= '1';
s_arithmetic_barrel <= '0';
s_shift_amt_barrel <= "00001";
s_shifterRSInputSelect <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

wait for gCLK_HPER;

--low

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_shifterRSInputSelect <= '0';
s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11101";
s_MIPSImmediate <= "0000000000000001";
s_MIPSReadRT <= "00010";

wait for gCLK_HPER;

--Store $2 into D[1]

s_MIPSnAddSub <= '0';
s_MIPSWriteEnable <= '0';
s_MIPSWriteAddress <= "11101";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$2 = $1 sra(1) + $0
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';
s_sign_extended_barrel <= '0';
s_left_shift_barrel <= '0';
s_arithmetic_barrel <= '1';
s_shift_amt_barrel <= "00001";
s_shifterRSInputSelect <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_shifterRSInputSelect <= '0';
s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11101";
s_MIPSImmediate <= "0000000000000010";
s_MIPSReadRT <= "00010";
--low

wait for gCLK_HPER;

--Store $2 into D[2]

s_MIPSnAddSub <= '0';
s_MIPSWriteEnable <= '0';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

--$2 = $1 sla(1) + $0
s_ALUsrc <= '0';
s_MIPSnAddSub <= '0';
s_MIPSReadRS <= "00001";
s_MIPSReadRT <= "00000";
s_MIPSWriteAddress <= "00010";
s_MIPSWriteEnable <= '1';
s_MIPSRes <= "00000000000000000000000000000001";
s_MIPSImmediate <= "0000000000000000";
s_RegFilesrc <= '1';
s_RAMwe <= '0';
s_sign_extended_barrel <= '0';
s_left_shift_barrel <= '1';
s_arithmetic_barrel <= '1';
s_shift_amt_barrel <= "00001";
s_shifterRSInputSelect <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

wait for gCLK_HPER;

--regfilesrc
--mipswriteenable
--alusrc
--mipsreadrs
--mipsimmediate
--mipsreadrt

s_shifterRSInputSelect <= '0';
s_RegFilesrc <= '0';
s_MIPSWriteEnable <= '0';
s_ALUsrc <= '1';
s_MIPSReadRS <= "11101";
s_MIPSImmediate <= "0000000000000011";
s_MIPSReadRT <= "00010";
--low

wait for gCLK_HPER;

--Store $2 into D[3]

s_MIPSnAddSub <= '0';
s_MIPSWriteEnable <= '0';
s_MIPSWriteAddress <= "11101";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';

wait for gCLK_HPER;

--low

wait for gCLK_HPER;

wait;
end process;
end behavior;