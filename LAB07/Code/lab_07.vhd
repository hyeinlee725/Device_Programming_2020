LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

ENTITY lab_07 IS
 PORT (	input_sel	: IN STD_LOGIC ;
			ac_load		: IN STD_LOGIC ;
			mar_load		: IN STD_LOGIC ;
			alu_sel		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			ram_load		: IN STD_LOGIC ;
			input			: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			MAR_in		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
			clk			: IN STD_LOGIC ;
			data_check	: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			output		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			m1_out		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			m2_out		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
			--mux_out		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			--mar_out		: OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END lab_07;

ARCHITECTURE data_processor OF lab_07 IS
	SIGNAL MAR : STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL ram_out : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL AC : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL alu_out_signal : STD_LOGIC_VECTOR(3 DOWNTO 0);	
	SIGNAL mux : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	component asynch_ram
		port (	data_in	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
					address	: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
					wr			: IN STD_LOGIC;
					data_out	: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
					m1_out 	: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
					m2_out	: OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
	end component;
	
	component simple_alu
		PORT (	op1, op2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
					sel		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
					alu_out	: OUT STD_LOGIC_VECTOR (3 DOWNTO 0) );
	end component;
	
BEGIN
	RAM : asynch_ram
		port map (data_in => alu_out_signal, address => MAR, wr => ram_load, data_out => ram_out, m1_out=>m1_out, m2_out=>m2_out);
	ALU : simple_alu
		port map (op1 => AC, op2 => ram_out, sel => alu_sel, alu_out => alu_out_signal) ;
 PROCESS (mar_load, ac_load, input_sel, clk)
 BEGIN
 
	--AC
	IF clk'EVENT AND clk = '1' THEN
		IF ac_load = '1' THEN
			AC <= mux;
		END IF;
	END IF;
	
	--MAR
	IF clk'EVENT AND clk = '1' THEN
		IF mar_load = '1' THEN
			MAR <= Mar_in;
		END IF;
	END IF;
	
	--MUX
	IF input_sel = '1' THEN
		mux <= input;
	ELSE
		mux <= alu_out_signal;
	END IF;
 END PROCESS;
 output <= AC;
 data_check <= alu_out_signal;
 --mux_out <= mux;
 --mar_out <= MAR;
END data_processor;
