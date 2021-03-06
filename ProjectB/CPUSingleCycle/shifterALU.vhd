library IEEE;
use IEEE.std_logic_1164.all;

entity shifterALU is

generic(N : integer := 32);

port (-- barrelshifter input
      i_sign_extended : in  STD_LOGIC;
      i_left_shift  : in  STD_LOGIC;
      i_arithmetic  : in  STD_LOGIC;
      i_shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0); 
      -- both 32 bit inputs          
      i_inputRS     : in  STD_LOGIC_VECTOR (N-1 downto 0);
      i_inputRT     : in  STD_LOGIC_VECTOR (N-1 downto 0);
      -- 32 bit ALU controls
      i_AddSubMaster : in std_logic;
      i_OpControl : in std_logic_vector(2 downto 0);
      -- Shifter mux control
      i_shifterMuxControl : in std_logic;
      -- final outputs
      o_Zero : out std_logic;
      o_Overflow : out std_logic;
      o_Cout : out std_logic;
      o_BiggerALU : out std_logic_vector(N-1 downto 0));
      --o_ALUdata     : out STD_LOGIC_VECTOR (N-1 downto 0));


end shifterALU;

architecture structure of shifterALU is

component ThirtyTwoBitALU

port (i_A, i_B : in std_logic_vector(N-1 downto 0);
	i_AddSubMaster : in std_logic;
	i_OpControl : in std_logic_vector(2 downto 0);
	o_Zero : out std_logic;
	o_Overflow : out std_logic;
	o_Cout : out std_logic;
	o_BiggerALU : out std_logic_vector(N-1 downto 0));

end component;

component barrelShifter

Port (i_sign_extend : in  STD_LOGIC;
           i_left_shift  : in  STD_LOGIC;
           i_arithmetic  : in  STD_LOGIC;
           i_shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0);           
           i_data_in     : in  STD_LOGIC_VECTOR (31 downto 0);
           o_data_out    : out STD_LOGIC_VECTOR (31 downto 0));

end component;

-- 0 = Y, 1 = Z
component TwoToOneMuxNBitDataflow

port(i_X  : in std_logic;
       i_Y  : in std_logic_vector(N-1 downto 0);
       i_Z  : in std_logic_vector(N-1 downto 0);
       o_RES  : out std_logic_vector(N-1 downto 0));

end component;

signal s_barrelShifterOutput : STD_LOGIC_VECTOR (N-1 downto 0);
signal s_muxOutput : STD_LOGIC_VECTOR (N-1 downto 0);


begin

barrelShifter_1: barrelShifter

port map(i_sign_extend => i_sign_extended,
      i_left_shift => i_left_shift,
      i_arithmetic => i_arithmetic,
      i_shift_amt => i_shift_amt,
      i_data_in => i_inputRT,
      o_data_out => s_barrelShifterOutput);

TwoToOneMuxNBitDataflow_1: TwoToOneMuxNBitDataflow

port map(i_X => i_shifterMuxControl,
       i_Y => i_inputRT, 
       i_Z => s_barrelShifterOutput,
       o_RES => s_muxOutput);


ThirtyTwoBitALU_1: ThirtyTwoBitALU

port map (i_A => i_inputRS, 
        i_B => s_muxOutput,
	i_AddSubMaster => i_AddSubMaster,
	i_OpControl => i_OpControl,
	o_Zero => o_Zero,
	o_Overflow => o_Overflow,
	o_Cout => o_Cout,
	o_BiggerALU => o_BiggerALU);


end structure;