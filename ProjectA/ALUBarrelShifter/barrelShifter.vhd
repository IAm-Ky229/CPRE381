library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity barrelShifter is
    Port ( i_sign_extend : in  STD_LOGIC;
           i_left_shift  : in  STD_LOGIC;
           i_arithmetic  : in  STD_LOGIC;
           i_shift_amt   : in  STD_LOGIC_VECTOR (4 downto 0);           
           i_data_in     : in  STD_LOGIC_VECTOR (31 downto 0);
           o_data_out    : out STD_LOGIC_VECTOR (31 downto 0));
end barrelShifter;

architecture Behavioral of barrelShifter is
    constant zero     : STD_LOGIC_VECTOR (23 downto 0) := (others => '0');
    constant one      : STD_LOGIC_VECTOR (23 downto 0) := (others => '1');
begin

process (i_sign_extend, i_left_shift, i_arithmetic, i_shift_amt, i_data_in)
   variable temp : STD_LOGIC_VECTOR (31 downto 0);
   begin

           -- Reverse bits depending on shift direction, or flip depending on sign and sign extention

	   -- if sign extend is one we check for the sign extension
           if i_sign_extend = '1' then
	      -- checkes the msb for a 1 then flips bits depending on value
              if i_data_in(i_data_in'high) = '1' then
                  temp := not i_data_in;
              else
                  temp := i_data_in;
              end if;

	   -- else we check for a left shift and flip the data depending on its value
           else
              if i_left_shift = '1' then
                 for i in 0 to 31 loop 
                    temp(i)  := i_data_in(31-i);
                 end loop; 
              else
                 temp := i_data_in;
              end if;
          end if; 
        


          -- shifter
	  -- checks for logical operation type
	  if i_arithmetic = '0' then
	     -- shifts the amount for the 4th bit
             case i_shift_amt(4 downto 4) is
                 when "0"    => temp := temp; 
                 when others => temp := zero(15 downto 0) & temp(31 downto 16);
             end case;

	     -- shifts the amount for the 3rd and 2nd bit
             case i_shift_amt(3 downto 2) is
                 when "00"   => temp := temp; 
                 when "01"   => temp := zero(3 downto 0) & temp(31 downto  4);
                 when "10"   => temp := zero(7 downto 0) & temp(31 downto  8);
                 when others => temp := zero(11 downto 0) & temp(31 downto 12);
             end case;

	     -- shift the amount for the 1st and 0th bit
             case i_shift_amt(1 downto 0) is
                 when "00"   => temp := temp; 
                 when "01"   => temp := zero(0 downto 0) & temp(31 downto 1);
                 when "10"   => temp := zero(1 downto 0) & temp(31 downto 2);
                 when others => temp := zero(2 downto 0) & temp(31 downto 3);
             end case;

	  -- else it applies arithmetic type
  	  else 
             -- shifts the amount for the 4th bit
             case i_shift_amt(4 downto 4) is
                 when "0"    => temp := temp; 
                 when others => temp := one(15 downto 0) & temp(31 downto 16);
             end case;

	     -- shifts the amount for the 3rd and 2nd bit
             case i_shift_amt(3 downto 2) is
                 when "00"   => temp := temp; 
                 when "01"   => temp := one(3 downto 0) & temp(31 downto  4);
                 when "10"   => temp := one(7 downto 0) & temp(31 downto  8);
                 when others => temp := one(11 downto 0) & temp(31 downto 12);
             end case;

	     -- shift the amount for the 1st and 0th bit
             case i_shift_amt(1 downto 0) is
                 when "00"   => temp := temp; 
                 when "01"   => temp := one(0 downto 0) & temp(31 downto 1);
                 when "10"   => temp := one(1 downto 0) & temp(31 downto 2);
                 when others => temp := one(2 downto 0) & temp(31 downto 3);
             end case;
	  end if;

          
          -- Reverse bits depending on shift direction, or flip depending on sign and sign extention

	  -- if sign extend is one we check for the sign extension
          if i_sign_extend = '1' then
	     -- checkes the msb for a 1 then flips bits depending on value
             if i_data_in(i_data_in'high) = '1' then
                o_data_out <= not temp;
             else
                o_data_out <= temp;
             end if;

	  -- else we check for a left shift and flip the data depending on its value
          else
             if i_left_shift = '1' then
                for i in 0 to 31 loop 
                   o_data_out(i)  <= temp(31-i);
                end loop; 
             else
                o_data_out <= temp;
             end if;
          end if; 
   end process;
end Behavioral;
