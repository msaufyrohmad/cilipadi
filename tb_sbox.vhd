library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity tb_sbox is
    
end tb_sbox;

architecture sbox_arc of tb_sbox is
component sbox is
    Port ( x : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

    signal x    :std_logic_vector(3 downto 0);
    signal y    :std_logic_vector(3 downto 0);
begin
    uut:sbox port map(x,y);
process
begin
    wait for 100ns;
    x <="0000";
    
    wait for 100ns;
    x <="0001";
    
    wait for 100ns;     
    x <= "0010";
    
    wait for 100ns;
    x <= "0011";
    
    wait for 100ns;
    x <= "0100";
    
    wait for 100ns;
    x <= "0101";
    
    wait for 100ns;
    x <= "0110";
    
    wait for 100ns;
    x <= "0111";
    
    wait for 100ns;
    x <= "1000";
    
    wait for 100ns;
    x <= "1001";
    
    wait for 100ns;
    x<= "1010";
    
    wait for 100ns;
    x <= "1011";
    
    wait for 100ns;
    x <= "1100";
    
    wait for 100ns;
    x <= "1101";
    
    wait for 100ns;
    x <= "1110";
    
    wait for 100ns;
    x <= "1111";
    
    wait;

end process;

end sbox_arc;
