library ieee;
use ieee.std_logic_1164.all;


entity proceduretimmer_tb is
end entity;

architecture sim of proceduretimmer_tb is

	constant clkFrequency : integer := 10;
	constant clkPeriod    : time := 1000 ms/clkFrequency;

	signal clk     : std_logic := '0';
	signal reset   : std_logic := '0';
	signal seconds : integer   := 0;
	signal minutes : integer   := 0;
	signal hours   : integer   := 0;
begin

	dut: entity work.proceduretimmer(rtl)
	generic map (clkFrequency)
	port map(
		clk => clk,
		reset => reset,
		seconds => seconds,
		minutes => minutes,
		hours => hours
	
	);
	
	clk <= not clk after clkPeriod;
	
	unreset: process is 
	begin 
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		reset <= '1';
		wait;
	end process;

end architecture;