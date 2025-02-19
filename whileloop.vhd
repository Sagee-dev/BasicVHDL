entity flworld is
end entity;

architecture sim of flworld is
begin

	process is
	
	variable i: integer := 0;  -- define variables between process and begin tags
	begin
		
		while i  < 10 loop -- while loop will iterate aslong as i is less than 10
			
			report "i = " & integer'image(i);
			
			wait for 10 ns;  -- added for the clarity
			
			i := i + 2; --increment i by 2
		
		end loop;
	
	wait;	--holds the simulation
	end process;
	
end architecture;