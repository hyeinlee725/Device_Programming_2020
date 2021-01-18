LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity lab_08_2 is
   port(
         clk    	: IN STD_LOGIC ;
			load    	: IN STD_LOGIC ;
         clear    : IN STD_LOGIC ;
         out_sel  : IN std_logic ;
			iNOT10   : out std_logic;
         dp_out   : out std_logic_vector(3 downto 0)
         );
END lab_08_2;

Architecture dataflow of lab_08_2 is
	TYPE state_type is (s0, s1, s2, s3);
	signal state : state_type;
   signal data : std_logic_vector(3 downto 0) := "0000"; --initialize
   begin
      process(clear, clk) is --register i(clocked process)
         begin 
			if clear = '1' then
				state <= s0;
			elsif (clk'event AND clk = '1') then
				CASE state is
					WHEN s0 =>
						if (load = '1') then
							data <= "0000"; --i initialize
							state<=s1;
						end if;
					WHEN s1 =>
						if (load = '1') then
							data <= data + '1'; --adder
							dp_out<=data;
							state<=s2;
						elsif (out_sel='0') then
                     dp_out <= "ZZZZ";
						end if;
					WHEN s2 =>
						if (load = '1' AND out_sel = '1' AND data/="1010") then
							data <= data + '1'; --adder
							dp_out <= data;
						end if;
						if(data = "1010") then
							dp_out <= data;
							state<=s3;
							iNOT10 <= '0';
						else
							iNOT10 <= '1';
						end if;
					WHEN s3 =>
						if (out_sel = '0') then
							dp_out <= "ZZZZ";
						state<= s3;
						end if;
				END CASE;
			end if;
      end process;
end dataflow;