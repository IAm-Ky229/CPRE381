library IEEE;
use IEEE.std_logic_1164.all;

entity tb_MIPSAppTwo is

generic(N : integer := 32;
        gCLK_HPER   : time := 50 ns;
	DATA_WIDTH : natural := 32;
	ADDR_WIDTH : natural := 10);

end tb_MIPSAppTwo;

architecture behavior of tb_MIPSAppTwo is

constant cCLK_PER  : time := gCLK_HPER * 2;

component MIPSAppTwo
port(i_MIPSCLK   : in std_logic;
	i_MIPSReadRS, i_MIPSReadRT, i_MIPSWriteAddress   : in std_logic_vector(4 downto 0); 
	i_MIPSWriteEnable, i_ALUSRC, i_MIPSnAddSub  : in std_logic;
	i_MIPSRes : in std_logic_vector(31 downto 0);
	i_MIPSImmediate   : in std_logic_vector(15 downto 0); 
	o_MIPSOutputRS,o_MIPSOutputRT  : out std_logic_vector(31 downto 0);
	i_RegFilesrc : in std_logic;
	i_RAMwe : in std_logic);
end component;

signal s_MIPSCLK, s_MIPSWriteEnable, s_ALUsrc, s_MIPSnAddSub, s_RegFilesrc, s_RAMwe : std_logic;
signal s_MIPSReadRS, s_MIPSReadRT, s_MIPSWriteAddress : std_logic_vector(4 downto 0);
signal s_MIPSRes : std_logic_vector(31 downto 0);
signal s_MIPSInputData : std_logic_vector(31 downto 0);
signal s_MIPSImmediate : std_logic_vector(15 downto 0);
signal s_OutputRS, s_OutputRT : std_logic_vector(31 downto 0);

begin

DUT : MIPSAppTwo
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
	i_RAMwe => s_RAMwe);

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
--low

wait for gCLK_HPER;

--Store $1 into B[127]

s_MIPSnAddSub <= '1';
s_MIPSWriteAddress <= "00000";
s_MIPSRes <= "00000000000000000000000000000001";
s_RAMwe <= '1';


wait;
end process;
end behavior;