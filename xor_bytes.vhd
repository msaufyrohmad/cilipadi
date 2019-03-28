
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_bytes is
    Port (
        x   : in    std_logic_vector(63 downto 0);
        y   : in    std_logic_vector(63 downto 0);
        z   : out   std_logic_vector(63 downto 0)
         );
end xor_bytes;

architecture Behavioral of xor_bytes is
begin
    z <= y xor x;
end Behavioral;
