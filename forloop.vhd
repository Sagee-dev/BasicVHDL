entity forloop is
end entity;

architecture sim of forloop is
begin

	process is
	begin
		for i in 1 to 10 loop -- for loop with fixed increment of 1
			report "i = " & integer'image(i); -- special conversion to print i
			wait for 10 ns;

		end loop;
	wait; -- hold the process
	end process;
	
end architecture;