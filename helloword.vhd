entity helloword is -- Basic structure of vhd file contain entity architecture of the entity
end entity; -- and process

architecture sim of helloword is
begin

	process is
	begin --process runs from begining to end repetedly
		report "Hello world";
		wait; --pause the program
	end process;
	
end architecture;
