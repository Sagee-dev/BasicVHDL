library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--test bench for the mux
entity mux_tb is

end entity;

architecture sim of mux_tb is
		signal inData:    unsigned(7 downto 0) := x"A1";
		signal incontrol: unsigned(2 downto 0) := "000";
		signal outData:   std_logic;
begin 
	
	mux_1: entity work.mux port map( --create a instant of mux
	
	inData => inData, --bind test bench signal to mux signals
	inControl => inControl,
	outData => outData
	);
	
	controller: process is 
	begin
		
		wait for 100 ns;
		inControl <= inControl + 1; --change the selec signal
	end process;
	
end architecture;
