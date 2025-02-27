library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
	generic(
	--define generics
		dataWidth   : integer;
		controlWidth: integer);
	port(
	--to accept external signals signals need to be define in entity 
	--inside the port statement
		--inputs
		inData   : in unsigned(dataWidth    downto 0); --set bus size as generic
		inControl: in unsigned(controlWidth downto 0);
	
		--outputs
		outData : out std_logic);

end entity;

architecture rtl of mux is
begin
	behaviour: process(inControl) is
	begin
	
		outData <= inData(to_integer(inControl));
		
	end process;

end architecture;