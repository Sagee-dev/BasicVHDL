entity signals is
end entity;

architecture sim of signals is
--signals can be accesed in all processes
signal upcounter : integer := 1; -- define signal between architecture and begin tags
signal downcounter : integer := 12; -- defined two signals to count up and douwn
begin

	updatecounters :process is --label process for clarity
	begin
	
	upcounter <= upcounter + 1; --increment and decrement two signals
	wait for 1000000 us;
	downcounter <= downcounter -1; -- use signal assign operator 
	wait for 1000000 us;
	
	end process;
	
	onsignalchange: process is
	begin
		wait on upcounter,downcounter; -- wait for any of two sinals to change the value
		report "upcounter = " & integer'image(upcounter) 
		&"downcounter = " & integer'image(downcounter);
	end process;
	
	countercheck: process is
	begin
		wait until upcounter = downcounter; -- wait two counters are equal
		report "*** Two counters are equal";
		wait;
	end process;
end architecture;