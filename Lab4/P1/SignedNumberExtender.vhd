library ieee;
use ieee.std_logic_1164.all;

entity SignedNumberExtender is

 port( i_input	: in	std_logic_vector(15 downto 0);
	o_output	: out std_logic_vector(31 downto 0));
end SignedNumberExtender;

architecture dataflow of SignedNumberExtender is

signal leftmost	:	std_logic;
signal extended	:	std_logic_vector(31 downto 0);

begin

leftmost <= i_input(15);
extended(15 downto 0) <= i_input(15 downto 0);

with leftmost select
	extended(31 downto 16) <= "1111111111111111" when '1',
				  "0000000000000000" when '0',
				  "0000000000000000" when others;
o_output <= extended;

end dataflow;