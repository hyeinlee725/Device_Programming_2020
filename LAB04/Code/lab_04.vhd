library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY lab_04 is
	PORT (clk 		: IN std_logic;
			s			: IN std_logic_vector(2 DOWNTO 0) ;
			F			: OUT std_logic_vector(2 DOWNTO 0) );
END lab_04 ;

ARCHITECTURE sample of lab_04 is

component rom_example
	PORT ( address			: IN std_logic_vector(2 DOWNTO 0);
			 Clock			: IN std_logic ;
			 q					: OUT std_logic_vector(2 DOWNTO 0));
END component;

BEGIN
	rom_example_inst:rom_example PORT MAP(
			address	=> s,
			Clock 	=> clk,
			q			=> F );

END sample ;