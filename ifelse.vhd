entity ifelse is
end entity;

architecture sm of ifelse is
signal upcounter  : integer := 0;  -- dwfine signal upcounter
signal downcounter: integer := 10; --define signal downcounter
begin
	count: process is
	begin
		--update counter signals
		upcounter   <= upcounter   +1;
		downcounter <= downcounter -1;
		wait for 10 ns; --wait for 10 ns
	end process;
	
	compare: process is
	begin
		wait on upcounter,downcounter; --wait till the upcounter or down counter change
		if upcounter > downcounter then --if greater than
			report "upcounter greater that downcounter";
		elsif upcounter < downcounter then -- else if lesser than
			report "Down counter is larger than upcounter";
		else -- else equal
			report "upcounter equals down counter ";
			wait; -- hold the program
		end if;
	end process;
end architecture;