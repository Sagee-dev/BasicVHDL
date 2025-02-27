library ieee;
use ieee.std_logic_1164.all;
-- 4way trafic light model
-- use procedures to reduce code redundency

entity procedurefsm is 
generic(clockFrequency: integer);
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

architecture rtl of procedurefsm is

	-- define states	
	type tState is (northNext, northStart, north, northStop,
	                westNext, westStart, west, westStop);
					
	--separate signal to store current state
	signal state: tState;
	
	--signal to store number of clock pluses limited to 0 to clock frequency * 60
	signal counter: integer range 0 to clockFrequency * 60;
begin

	fsmModel: process(clk) is
			
		-- define new procedure to reduce code redundency with 3 inputs
		procedure setState(toState : tState;
		                   minutes : integer := 0;
						   seconds : integer := 0) is
			--variables need to define inside the procedure
			variable totalSeconds  : integer;
			variable clockCycles   : integer;
			
		begin
			--count total seconds
			totalSeconds := seconds + minutes * 60;
			--count total clock cycles
			clockCycles  := (totalSeconds *clockFrequency)-1;
		
			if counter = clockCycles then
				counter <= 0; --reset counter
				state   <= toState; -- set newsate
			end if;
		
		end procedure;
		
	begin
	
		if rising_edge(clk) then
		
			if rst = '0' then
			    --setup reset
				state <= northNext;
				counter <= 0;
			else
				--default signal states
				northRed   <= '0';
				northYellow<= '0';
				northGreen <= '0';
				westRed    <= '0';
				westYellow <= '0';
				westGreen  <= '0';
				
				counter <= counter + 1;
			
				case state 
				-- case statement to state changes 

					when northNext =>
					report "state 1";
						northRed   <= '1';
						westRed    <= '1';
						setState(northStart,seconds => 5); --changge to next state if 5 seconds are completed
						
					when northStart =>
					report "state 2";
						northYellow<= '1';
						northGreen <= '1';
						westRed    <= '1';
						setState(north,seconds => 5);--changge to next state if 5 seconds are completed
						
					when north =>
					report "state 3";
						northGreen <= '1';
						westRed    <= '1';
						setState(northStop,minutes => 1);--changge to next state if 60 seconds are completed
						
					when northStop =>
					report "state 4";
						northYellow<= '1';
						westRed    <= '1';
						setState(westNext,seconds => 5);--changge to next state if 5 seconds are completed
						
					when westNext =>
					report "state 5";
						northRed   <= '1';
						westRed    <= '1';
						setState(westStart,seconds => 5);--changge to next state if 5 seconds are completed
						
					when westStart =>
					report "state 6";
						northRed   <= '1';
						westRed    <= '1';
						westYellow <= '1';
						setState(west,seconds => 5);--changge to next state if 5 seconds are completed
						
					when west =>
					report "state 7";
						northRed   <= '1';
						westGreen  <= '1';
						setState(westStop,minutes => 1);--changge to next state if 60 seconds are completed

					when westStop =>
					report "state 8";
						northRed   <= '1';
						westYellow <= '1';
						setState(northNext,seconds => 5);--changge to next state if 5 seconds are completed

				end case;
			
			end if;

		end if;
	
	end process;

end architecture;