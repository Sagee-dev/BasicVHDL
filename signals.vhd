entity signals is
end entity;

architecture sim of signals is

signal signali : integer := 0; -- define signal between architecture and begin tags

begin

	process is
		--variables are scope dependent
		--only can be access from the defined scope
		variable i : integer := 0; -- defien varibles between process and begin tags
	
	begin
	
		while i < 10 loop -- iterate while i < 10
			report "i = " & integer'image(i); -- print variable i
			report "signal_i = " & integer'image(signali);
			
			signali <= signali + 1; -- this is how to assign values to signals
			
			i := i + 2; -- increment i by 2
			
			wait for 10 ns; -- for clarity
		
		end loop; -- end loop
	wait;
	end process;
	
end architecture;