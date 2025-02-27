library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity concurrent is
begin
end entity;

architecture sim of concurrent is

	signal mul_1 : unsigned(7 downto 0 ) := "00000001";
	signal mul_2 : unsigned(7 downto 0 );
	signal mul_3 : unsigned(7 downto 0 );
	

begin
	mul1: process is
	begin 
		mul_1 <= shift_left(mul_1,1); --equal to multiply by 2
		wait for 10 ns;
	end process;
	
	mul2: process(mul_1) is
	begin
		mul_2 <= mul_1;
	end process;
	mul_3 <= mul_1;

	--whaen this code is simulated in model sim you can see all signal simulteniously update
	--what ever in the architecture and out side the process evaluated as soon as uperendes update

end architecture;