library ieee;
use ieee.std_logic_1164.all;
--code reduction using procedures
-- a timer module
entity proceduretimmer is
generic(clockFrequency: integer);--- define clock frequency as a generic input
--define external input output signals
port(
	clk     : in std_logic;
	reset   : in std_logic;
	seconds : inout integer;
	minutes : inout integer;
	hours   : inout integer);
end entity;

architecture rtl of proceduretimmer is
	signal   ticks  : integer := 0; 
	
	
	-- define procesdure and input outputs counter is a inout signal
	procedure incrementWrap(signal counter     : inout integer;
	                        constant wrapvalue : in integer;
	                        constant enable    : in boolean;
	                        variable wraped    : out boolean) is
	begin
		if enable then-- if revious set of counts are completed
		
			if counter = wrapvalue then --current count reached threshold
				wraped := true;
				counter <= 0; --reset counter
			else
			
				wraped := false;
				counter <= counter + 1;
				
			end if;
		end if;
	end procedure;
begin
	
	timmer: process(clk) is
		variable wraped : boolean;
	begin
	
		if rising_edge(clk) then
	
			if reset = '0' then
			--setup resent functionality
				ticks   <= 0;
				seconds <= 0;
				minutes <= 0;
				hours   <= 0;
			
			else
			
				incrementWrap(ticks, clockFrequency ,true ,wraped); -- count pulses for a seconds
				incrementWrap(seconds, 59 ,wraped ,wraped); -- count up to 59 seconds and back to zer0
				incrementWrap(minutes, 59 ,wraped ,wraped); -- count up to 59 minutes and back to zero
				incrementWrap(hours, 35 ,wraped ,wraped); --count up to 24 h and back to zero
		
			
			end if;
		end if;
	end process;

end architecture;