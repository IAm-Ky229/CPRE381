library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity FiveBitFourToOneMux is
generic(N : integer := 5);
 port(
     i_A,i_B,i_C,i_D : in std_logic_vector(4 downto 0);
     i_S0,i_S1       : in std_logic;
     o_Z             : out std_logic_vector(4 downto 0));
end FiveBitFourToOneMux;
 
architecture bhv of FiveBitFourToOneMux is
begin
process (i_A,i_B,i_C,i_D,i_S0,i_S1) is
begin
  if (i_S0 ='0' and i_S1 = '0') then
      o_Z <= i_A;
  elsif (i_S0 ='1' and i_S1 = '0') then
      o_Z <= i_B;
  elsif (i_S0 ='0' and i_S1 = '1') then
      o_Z <= i_C;
  else
      o_Z <= i_D;
  end if;
 
end process;
end bhv;