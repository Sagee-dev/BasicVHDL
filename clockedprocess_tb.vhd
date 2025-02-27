library ieee;
use ieee.std_logic_1164.all;

entity flipflop_tb is
end entity;

architecture sim of flipflop_tb is
	
	constant clkfrequency: integer := 100e6;
	constant clkperiod: time := 1000 ms/ clkfrequency;
	
	signal clk: std_logic := '0';
	signal input: std_logic := '1';
	signal reset: std_logic := '0';
	signal output: std_logic := '0';
begin

	flipflop_1 : entity work.flipflop
	port map(
		clk => clk,
		input => input,
		reset => reset,
		output => output
	);
	
	clk <= not clk after clkperiod;
	
	testFlipflop: process is
	begin
	
	wait for 20 ns;
	input <= '1';
	wait for 22 ns;
	assert output = '1' report "Wrong output" & std_logic'image(output);
	
	wait for 20 ns;
	input <= '0';
	wait for 22 ns;
	assert output = '0' report "Wrong output";
	
	wait for 20 ns;
	input <= '1';
	wait for 22 ns;
	assert output = '1' report "Wrong output" & std_logic'image(output);
	 wait;
	end process;
end architecture;

