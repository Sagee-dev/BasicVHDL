library ieee;
use ieee.std_logic_1164.all;
-- model a clock module count seconds, minutes, hours
entity timmer is
generic(clockFrequency: integer);-- set clock frequency as a generic
--setup input and output inouts can be both read and written
port(
	clk     : in std_logic;
	reset   : in std_logic;
	seconds : inout integer;
	minutes : inout integer;
	hours   : inout integer);
end entity;

architecture rtl of timmer is
	signal ticks: integer := 0; 
begin
	
	timmer: process(clk) is
	begin
	
		if rising_edge(clk) then
	
			if reset = '0' then
			-- setup reset function
		
				ticks   <= 0;
				seconds <= 0;
				minutes <= 0;
				hours   <= 0;
				
				report "Reset";
			
			else
			-- use nested if clauses to create a timer
				if ticks = clockFrequency then
					--cout clock edgaes untill a second
			
					if seconds = 59 then
				
						seconds <= 0;
					
						if minutes = 59 then
					
							minutes <= 0;
						
							if hours = 23 then
						
								hours <= 0;
							
							else
						
								hours <= hours + 1;
								--count hours
						
							end if;
						
						else
					
							minutes <= minutes + 1;
							-count minutes
						
						end if;
				
					else
						seconds <= seconds +1;
						--count seconds
					end if;
				
				ticks <= 0;
			
				else
			
					ticks <= ticks + 1;
				
					report "ticks: " & integer'image(ticks);
				
				end if;
			
			end if;
		end if;
	end process;

end architecture;