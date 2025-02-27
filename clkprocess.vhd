library ieee;
use ieee.std_logic_1164.all;

--model a flipflop 
-- set output 0 if the flipflop is reset
--set the input to output every signal
entity flipflop is
 
port(
	clk : in std_logic;
	input: in std_logic;
	reset : in std_logic;
	output: out std_logic);
	
end entity;

architecture sim of flipflop is
begin
	flipflopm: process(clk) is
	begin
	
		if rising_edge(clk) then
			if reset = '1' then
			--reset functionality
				output <= '0';
			else
			--set input to out put
				output <= input;
			end if;
		end if;
		
	end process;
end architecture;