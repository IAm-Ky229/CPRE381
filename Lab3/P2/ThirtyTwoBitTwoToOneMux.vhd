library IEEE;
use IEEE.std_logic_1164.all;

entity ThirtyTwoBitTwoToOneMux is

port(i_A, i_B   :   in std_logic_vector(31 downto 0);
	i_SELECT   : in std_logic;
	o_OUTPUT   : out std_logic_vector(31 downto 0));
end ThirtyTwoBitTwoToOneMux;

architecture dataflow of ThirtyTwoBitTwoToOneMux is

begin

with i_SELECT select
	o_OUTPUT <= i_A when '0',
		    i_B when '1',
"00000000000000000000000000000000" when others;

end dataflow;