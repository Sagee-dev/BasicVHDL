entity loopw is
end entity;

architecture sim of loopw is
begin

	process is
	begin
	report "process begins";
		loop
			report "Hello world"; --loop runs repetedly
			exit;-- use exit to break the loop
		end loop;
	report "process ends";
	wait; -- hold the process
	end process;
	
end architecture;