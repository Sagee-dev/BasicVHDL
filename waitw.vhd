entity waitw is
end entity;

architecture sim of waitw is
begin

	process is
	begin
		report "Hello world";
		wait for 1000 ns;   --wait for 1000 ns every process must include a wait
	end process;
	
end architecture;