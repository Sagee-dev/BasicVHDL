library ieee;
use ieee.std_logic_1164.all; --import ieee standerd logic library
use ieee.numeric_std.all;

entity cases is
begin
end entity;

architecture sim of cases is
--case statements are prity much simillar to other high level languages
-- to demostrate use of case statements lets model a 8 to 1 multiplexer
-- 8 to 1 multiplexer has 8 input 1 output and 3 control signals 
-- lets use 2 logic vectors and one logic output
	
	signal input: unsigned(7 downto 0)   := x"f1"; -- asign random value 11110001 to input
	signal control: unsigned(2 downto 0) :=  "000"; -- lets assign 000 to cotrol
	signal output: std_logic; --assign output to undefined initially
begin
		controller: process is
		begin
			wait for 10 ns;
			control <= control + 1; --increment control signal by 1
		end process;
		
		outputcontrol: process(control) is
		begin
		
			case control is
				when "000" =>
					output <= input(0);
				when "001" =>
					output <= input(1);
				when "010" =>
					output <= input(2);
				when "011" =>
					output <= input(3);
				when "100" =>
					output <= input(4);
				when "101" =>
					output <= input(5);
				when "110" =>
					output <= input(6);
				when "111" =>
					output <= input(7);
				when others =>
					report "invalid control";
					
			end case;

			
		end process;
end architecture;