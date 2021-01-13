LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity lab_08_dp is
   port(
         clk    : IN STD_LOGIC ;
         load    : IN STD_LOGIC ;
         clear    : IN STD_LOGIC ;
         out_sel   : IN std_logic ;
         
         iNOT10    : out std_logic;
         dp_out   : out std_logic_vector(3 downto 0)
         
         );
END lab_08_dp;

Architecture dataflow of lab_08_dp is

   signal data : std_logic_vector(3 downto 0) := "0000"; --initialize
   begin
      process(clear, clk) is --register i(clocked process)
         begin 
         if (clear = '1') then
              data <= "0000"; --i initialize   
         elsif (clk'EVENT AND clk = '1') then
            if (load = '1' AND data /= "1010") then
               data <= data + '1'; --adder
               iNOT10 <= '1';
            else
               iNOT10 <= '0';
            end if;
            IF (out_sel = '1') THEN
               dp_out <= data; -- output
            ELSE
               dp_out <= "ZZZZ";
            END IF;
         end if;
      end process;
end dataflow;