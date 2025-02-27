library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
	port(
	--to accept external signals signals need to be define in entity 
	--inside the port statement
		--inputs
		inData   : in unsigned(7 downto 0);
		inControl: in unsigned(2 downto 0);
	
		--outputs
		outData : out std_logic);

end entity;

architecture rtl of mux is
begin
	behaviour: process(inData, inControl) is
	begin --demostration of case statements
		case inControl is
			when "000"  =>
				outData <= inData(0);
			when "001"  =>
				outData <= inData(1);
			when "010"  =>
				outData <= inData(2);
			when "011"  =>
				outData <= inData(3);
			when "100"  =>
				outData <= inData(4);
			when "101"  =>
				outData <= inData(5);
			when "110"  =>
				outData <= inData(6);
			when "111"  =>
				outData <= inData(7);
			when others =>
				report "Invalid input signal0";
				
		end case;
	end process;

end architecture;

