library ieee;  --import ieee std_logic library
use ieee.std_logic_1164.all;

entity stdlogics is
end entity;

architecture sim of stdlogics is 

-- when designing digital electronics we have to work with bits rather than integers
-- IEEE std_logic librery provided required fuctionalities

	signal sig_1 : std_logic := '0'; -- note that the each siganal is a one bit value
	signal sig_2 : std_logic := '1'; -- there are another 7 values std_logic can can take rether than 1 and 0 such as undifiened
	signal sig_3 : std_logic := '1';

begin

	squrewave: process is
	begin

		sig_1 <= not sig_1; --not operator will inverse the current logic level of the sig_1 
		wait for 40 ns; -- wait 40 ns will held the logic level for 40 ns
		-- this process well results a square wave for sig_1 with 80 ns period
		-- shape of this or any signal can be observed in model sin easily
	end process;
	
	sig_2_driver: process(sig_1) is
	begin
		-- this process will be triggered every time sig_1 changed
		sig_2 <= not sig_2; -- assign inverse of the sig_2 to sig_2
	end process;
	
	sig_3_driver: process(sig_2) is
	begin
	--this process will trigered when sig_2 is changed
	sig_3 <= not sig_3;
	
	-- ** what would happen if two process updat the same signal at the same time?
	end process;

end architecture;