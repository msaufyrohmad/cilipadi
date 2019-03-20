library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_addconstants is
end tb_addconstants;

architecture Behavioral of tb_addconstants is
component addconstants is
port(   x:	in std_logic_vector(63 downto 0);
        r   : in integer range 0 to 48;
	    y:	out std_logic_vector(63 downto 0)
	);
end component;

signal x    : std_logic_vector(63 downto 0);
signal r    : integer range 0 to 48;
signal y    : std_logic_vector(63 downto 0);

begin

uut: addconstants port map(x,r,y);

test_input: process
begin
    wait for 100ns;
    x <=x"0011223344556677";
    r <= 2;

    wait for 100ns;
    x <=x"7766554433221100";
    r <= 20;
end process;

end Behavioral;
