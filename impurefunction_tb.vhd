library ieee;
use ieee.std_logic_1164.all;


entity fsmimpurefunctions_tb is
end entity;

architecture sim of fsmimpurefunctions_tb is

	constant clkFrequency : integer := 10;
	constant clkPeriod    : time := 1000 ms/clkFrequency;

	signal clk        : std_logic := '0';
	signal rst        : std_logic := '0';
	signal northRed   : std_logic;
	signal northYellow: std_logic;
	signal northGreen : std_logic;
	signal westRed    : std_logic;
	signal westYellow : std_logic;
	signal westGreen  : std_logic;
begin

	dut: entity work.fsmimpurefunctions(rtl)
	generic map (clkFrequency)
	port map(
		clk => clk,
		rst => rst,
		northRed   => northRed,
		northYellow=> northYellow,
		northGreen => northGreen,
		westRed    => westRed,
		westYellow => westYellow,
		westGreen  => westGreen
	);
	
	clk <= not clk after clkPeriod;
	
	unreset: process is 
	begin 
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		rst <= '1';
		wait;
	end process;

end architecture;