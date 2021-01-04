LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY lab_06_1 IS
 PORT (	data_in	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			wr		 	: IN STD_LOGIC;
			data_out	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) );
END lab_06_1;

ARCHITECTURE rtl OF lab_06_1 IS
 TYPE MEM IS ARRAY(0 TO 255) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
 SIGNAL ram_block: MEM;
BEGIN
 PROCESS (wr, data_in, address)
 BEGIN
   IF (wr = '1') THEN ram_block(to_integer(unsigned(address))) <= data_in;
  	   data_out <= (others => 'Z');
   else  data_out <= ram_block(to_integer(unsigned(address))); 
  END IF;
 END PROCESS;
END rtl;
