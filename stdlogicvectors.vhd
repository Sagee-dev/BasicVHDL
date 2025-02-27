library ieee;
use ieee.std_logic_1164.all;

entity stdlogicvectors is 

end entity; 

architecture sim of stdlogicvectors is

--often time electronic desings required bytes which is a set of signals
--this is equals to arrays in high level programing languages
--in VHDL ieee standered logic library provide standered logic vectors

signal sig_1    : std_logic := '0';
signal sigvec_1 : std_logic_vector(7 downto 0)  := x"01"; --standered way of defining a vector
--sigvec_1(7 downto 0) := (others => '0'); --standered way of assing zero to a vector 
begin


	
	shiftregister: process is
	begin
		wait for 40 ns;
		for i in sigvec_1'left downto sigvec_1'right + 1 loop
			sigvec_1(i) <= sigvec_1(i-1);
		end loop;
	
	end process;
	
end architecture;