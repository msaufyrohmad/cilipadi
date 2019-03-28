--
-- dummy mixcolumn because the real mix column is not working
-- just pass the value to output
-- msr, cilipadi
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mixcolumn is
    Port ( 
        clk     : in std_logic;
        reset   : in std_logic;
        x       : in std_logic_vector(63 downto 0);
        y       : out std_logic_vector(63 downto 0)
    );
end mixcolumn;

architecture Behavioral of mixcolumn is
begin
process(clk,reset)
begin
    if reset='1' then
            y <= (others => '0');
    elsif clk'event and clk ='1' then                                                                                                                                                                                                                                                                                                                                                                          
            y <= x;
    end if;
end process;
end Behavioral;
