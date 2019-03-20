
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_subcells is
end tb_subcells;

architecture Behavioral of tb_subcells is

component subcells is
    Port ( sc_in  : in STD_LOGIC_VECTOR (63 downto 0);
           sc_out : out STD_LOGIC_VECTOR (63 downto 0)
           );
end component;

signal sc_in    :std_logic_vector(63 downto 0);
signal sc_out   : std_logic_vector(63 downto 0);

begin
    uut: subcells port map(sc_in,sc_out);


test: process
begin
    wait for 100 ns;
    sc_in <="0000000000000000";

    wait for 100 ns;
    sc_in <="0000000011111111";

    wait for 100 ns;
    sc_in <="1111111100000000";

    wait for 100 ns;
    sc_in <="1111111111111111";
    
    wait;

end process;
end Behavioral;
