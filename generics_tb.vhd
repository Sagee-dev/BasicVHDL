library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--test bench for the mux
entity generics_tb is

end entity;

architecture sim of generics_tb is
		constant dataWidth    : integer := 11;
		constant controlWidth : integer := 3;
		
		signal inData:    unsigned(dataWidth    downto 0) := x"9A1";
		signal incontrol: unsigned(controlWidth downto 0) := "0000";
		signal outData:   std_logic;
begin 
	
	mux_1: entity work.mux 
	generic map(
		dataWidth    => dataWidth,
		controlWidth => controlWidth
	)
	port map( --create a instant of mux
	
	inData => inData, --bind test bench signal to mux signals
	inControl => inControl,
	outData => outData
	);
	
	controller: process is 
	begin
		
		wait for 100 ns;
		if incontrol < 11 then
			inControl <= inControl + 1; --change the selec signal
		else
			incontrol <= (others => '0');
		end if;
		
	end process;
	
end architecture;