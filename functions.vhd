library ieee;
use ieee.std_logic_1164.all;


entity fsmfunctions is 
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

architecture rtl of fsmfunctions is

	function counterVal(minutes : integer := 0;
	                    seconds : integer := 0) return integer is
		variable totalSeconds: integer;
	begin
		totalSeconds := seconds + minutes * 60;
		return totalSeconds * (clockFrequency-1);
	end function;
	
	type tState is (northNext, northStart, north, northStop,
	                westNext, westStart, west, westStop);
					
	signal state: tState;
	
	signal counter: integer range 0 to CounterVal(Minutes => 1)+1;
begin

	fsmModel: process(clk) is
	begin
	
		if rising_edge(clk) then
		
			if rst = '0' then
			
				state <= northNext;
				counter <= 0;
			else
			
				northRed   <= '0';
				northYellow<= '0';
				northGreen <= '0';
				westRed    <= '0';
				westYellow <= '0';
				westGreen  <= '0';
				
				counter <= counter + 1;
			
				case state is

					when northNext =>
						northRed   <= '1';
						westRed    <= '1';
						if counter = counterVal(seconds => 5) then
							counter <= 0;
							state <= northStart;
						end if;
					when northStart =>
						northYellow<= '1';
						northGreen <= '1';
						westRed    <= '1';
						if counter = counterVal(seconds => 5) then
							counter <= 0;
							state <= north;
						end if;
					when north =>
						northGreen <= '1';
						westRed    <= '1';
						if counter = counterVal(minutes => 1) then
							counter <= 0;
							state <= northStop;
						end if;
					when northStop =>
						northYellow<= '1';
						westRed    <= '1';
						if counter = counterVal(seconds => 5) then
							counter <= 0;
							state <= westNext;
						end if;
					when westNext =>
						northRed   <= '1';
						westRed    <= '1';
						if counter = counterVal(seconds => 5) then
							counter <= 0;
							state <= westNext;
						end if;
						state <= westStart;
					when westStart =>
						northRed   <= '1';
						westRed    <= '1';
						westYellow <= '1';
						if counter = counterVal(seconds => 5) then
							counter <= 0;
							state <= west;
						end if;
					when west =>
						northRed   <= '1';
						westGreen  <= '1';
						if counter = counterVal(minutes => 1) then
							counter <= 0;
							state <= westStop;
						end if;
					when westStop =>
						northRed   <= '1';
						westYellow <= '1';
						if counter = counterVal(seconds => 5) then
							counter <= 0;
							state <= northNext;
						end if;
					
				end case;
			
			end if;
		
		else
		end if;
	
	end process;

end architecture;
