library ieee;
use ieee.std_logic_1164.all;

entity ZeroExtender is

 port( i_input	: in	std_logic_vector(15 downto 0);
	i_LUI : in std_logic;
	o_output	: out std_logic_vector(31 downto 0));

end ZeroExtender;

architecture dataflow of ZeroExtender is

signal extendedLUI, extended	:	std_logic_vector(31 downto 0);

begin


extendedLUI(31 downto 16) <= i_input(15 downto 0);
extendedLUI(15 downto 0) <= "0000000000000000";

extended(15 downto 0) <= i_input(15 downto 0);
extended(31 downto 16) <= "0000000000000000";

with i_LUI select

o_output <= extendedLUI when '1',
		extended when '0',
		"00000000000000000000000000000000" when others;

end dataflow;