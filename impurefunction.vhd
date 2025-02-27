library ieee;
use ieee.std_logic_1164.all;


entity fsmimpurefunctions is 
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

architecture rtl of fsmimpurefunctions is
	--function cannot update or read the signals defined out side thefunction
	--unless they are passed in to the function
	function counterVal(minutes : integer := 0;
	                    seconds : integer := 0) return integer is --return an int
		variable totalSeconds: integer;
	begin
		totalSeconds := seconds + minutes * 60; --calculate total seconds
		return (totalSeconds *clockFrequency)-1; -- retun total clock cycles
	end function;
	
	type tState is (northNext, northStart, north, northStop,
	                westNext, westStart, west, westStop);
					
	signal state: tState;
	
	signal counter: integer range 0 to clockFrequency * 60;
begin

	fsmModel: process(clk) is
	    -- major difference is impure functions can access the signals defined outside the impure function
		-- default values for minutes and seconds are zero
		impure function isCounterExpired(minutes : integer := 0;
		                                 seconds : integer := 0)
										 return boolean is
		begin
		    report "Counter: "& integer'image(counter)&" counterval: "&integer'image(counterVal(minutes,seconds));
			if counter = counterVal(minutes,seconds) then -- call the function to get current time elapsed
			
				counter <= 0; -- not defined with in the function
				return true;
				
			else
			
				return false;
			
			end if;
		
		end function;
		
	begin
	
		if rising_edge(clk) then
		
			if rst = '0' then
				-- set reset functionality
				state <= northNext;
				counter <= 0;
			else
				-- set default states
			
				northRed   <= '0';
				northYellow<= '0';
				northGreen <= '0';
				westRed    <= '0';
				westYellow <= '0';
				westGreen  <= '0';
				
				counter <= counter + 1;
			
				case state is

					when northNext =>
					report "state 1";
						northRed   <= '1';
						westRed    <= '1';
						if isCounterExpired(seconds => 5) then -- check whether 5 seconds have elaped
							state <= northStart;
						end if;
					when northStart =>
					report "state 2";
						northYellow<= '1';
						northGreen <= '1';
						westRed    <= '1';
						if isCounterExpired(seconds => 5) then -- check whether 5 seconds have elaped
							state <= north;
						end if;
					when north =>
					report "state 3";
						northGreen <= '1';
						westRed    <= '1';
						if isCounterExpired(minutes => 1) then-- check whether 60 seconds have elaped
							state <= northStop;
						end if;
					when northStop =>
					report "state 4";
						northYellow<= '1';
						westRed    <= '1';
						if isCounterExpired(seconds => 5) then-- check whether 5 seconds have elaped
							state <= westNext;
						end if;
					when westNext =>
					report "state 5";
						northRed   <= '1';
						westRed    <= '1';
						if isCounterExpired(seconds => 5) then-- check whether 5 seconds have elaped
							state <= westNext;
						end if;
					when westStart =>
					report "state 6";
						northRed   <= '1';
						westRed    <= '1';
						westYellow <= '1';
						if isCounterExpired(seconds => 5) then-- check whether 5 seconds have elaped
							state <= west;
						end if;
					when west =>
					report "state 7";
						northRed   <= '1';
						westGreen  <= '1';
						if isCounterExpired(minutes => 1) then-- check whether 60 seconds have elaped
							state <= westStop;
						end if;
					when westStop =>
					report "state 8";
						northRed   <= '1';
						westYellow <= '1';
						if isCounterExpired(seconds => 5) then-- check whether 5 seconds have elaped
							state <= northNext;
						end if;
				end case;
			
			end if;

		end if;
	
	end process;

end architecture;
