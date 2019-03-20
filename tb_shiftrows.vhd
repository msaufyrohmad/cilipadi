library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_shiftrows is
end tb_shiftrows;

architecture Behavioral of tb_shiftrows is

component shiftrows is
    Port ( x : in STD_LOGIC_VECTOR (63 downto 0);
           y : out STD_LOGIC_VECTOR (63 downto 0));
end component;

    signal x    :std_logic_vector(63 downto 0);
    signal y    :std_logic_vector(63 downto 0);

begin
    uut: shiftrows port map(x,y);

process
begin
    wait for 100ns;
    x <=x"0011223344556677";
    
    wait for 100ns;
    x <=x"FFEEDDCCBBAA9988";
    
    wait for 100ns;
    x <=x"8899AABBCCDDEEFF";
    
    wait for 100ns;
    x <=x"7766554433221100";
    
    wait;
end process;

end Behavioral;
