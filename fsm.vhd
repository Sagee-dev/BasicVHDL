library ieee;
use ieee.std_logic_1164.all;
-- model a finite state machine 
-- 4 way trafic light system
-- north next -> north sart -> north -> north stop -> west next -> west start -> west -> west stop

entity fsm is 
generic(clockFrequency: integer);--set clock frequency as a generic
--defien input and output signals
port(
	
	signal clk: in std_logic;
	signal rst: in std_logic;
	signal northRed   : out std_logic;
	signal northYellow: out std_logic;
	signal northGreen : out std_logic;
	signal westRed    : out std_logic;
	signal westYellow : out std_logic;
	signal westGreen  : out std_logic);
	
end entity;

architecture rtl of fsm is
	--define states as a new type
	type tState is (northNext, northStart, north, northStop,
	                westNext, westStart, west, westStop);
					
	signal state: tState;
	
	signal counter: integer range 0 to clockFrequency-1; -- define counter from o to clock frequency -1
begin

	fsmModel: process(clk) is
	begin
	
		if rising_edge(clk) then
		
			if rst = '0' then
			
				state <= northNext;
				counter <= 0;
			else
				
				counter <= counter + 1; -- increment counter at every rising edge of the clock signal
			
				case state is
				-- state change will take place at equal intervals
					when northNext =>
						northRed   <= '1';
						northYellow<= '0';
						northGreen <= '0';
						westRed    <= '1';
						westYellow <= '0';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0; -- reset counter at the stage change
							state <= northStart; --update state
						end if;
					when northStart =>
						northRed   <= '0';
						northYellow<= '1';
						northGreen <= '1';
						westRed    <= '1';
						westYellow <= '0';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0;
							state <= north;
						end if;
					when north =>
						northRed   <= '0';
						northYellow<= '0';
						northGreen <= '1';
						westRed    <= '1';
						westYellow <= '0';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0;
							state <= northStop;
						end if;
					when northStop =>
						northRed   <= '0';
						northYellow<= '1';
						northGreen <= '0';
						westRed    <= '1';
						westYellow <= '0';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0;
							state <= westNext;
						end if;
					when westNext =>
						northRed   <= '1';
						northYellow<= '0';
						northGreen <= '0';
						westRed    <= '1';
						westYellow <= '0';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0;
							state <= westNext;
						end if;
					when westStart =>
						northRed   <= '1';
						northYellow<= '0';
						northGreen <= '0';
						westRed    <= '1';
						westYellow <= '1';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0;
							state <= west;
						end if;
					when west =>
						northRed   <= '1';
						northYellow<= '0';
						northGreen <= '0';
						westRed    <= '0';
						westYellow <= '0';
						westGreen  <= '1';
						if counter = clockFrequency then
							counter <= 0;
							state <= westStop;
						end if;
					when westStop =>
						northRed   <= '1';
						northYellow<= '0';
						northGreen <= '0';
						westRed    <= '0';
						westYellow <= '1';
						westGreen  <= '0';
						if counter = clockFrequency then
							counter <= 0;
							state <= northNext;
						end if;
					
				end case;
			
			end if;
		
		else
		end if;
	
	end process;

end architecture;
