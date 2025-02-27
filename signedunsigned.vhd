library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;   -- import ieee signed unsigned library

entity signedunsigned is
end entity;

architecture sim of signedunsigned is
	signal usig_1 : unsigned(3 downto 0) := (others => '0'); -- standered ways of defining and assing values to singe
	signal usig_2 : unsigned(3 downto 0) := "0010";          -- unsigned signals
	signal usig_3 : unsigned(3 downto 0) := "0001";
	
	signal ssig_1 : signed(3 downto 0) := (others => '0');
	signal ssig_2 : signed(3 downto 0) := "0010";
	signal ssig_3 : signed(3 downto 0) := "0001";
	
begin
	usigupdater : process is 
	begin
	   -- for the correct intepretation of the results set  usig variables to radix unsign in the model sim simulator
		
		wait for 1000 ns;
		
		usig_2 <= usig_2 + 1;	
		usig_1 <= usig_2 + usig_3;


		ssig_2 <= ssig_2 + 1;
		ssig_1 <= ssig_2 + ssig_3;
		
		
	end process;
end architecture;