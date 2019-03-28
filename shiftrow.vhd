library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shiftrow is
    Port ( 
           clk      : in std_logic;
           reset    : in std_logic; 
           x        : in STD_LOGIC_VECTOR (63 downto 0);
           y        : out STD_LOGIC_VECTOR (63 downto 0));
end shiftrow;

architecture shiftrows_arc of shiftrow is
signal r0,r1,r2,r3 : STD_LOGIC_VECTOR (15 downto 0);
begin

-- row by row
r0 <= x(63 downto 48);
r1 <= x(43 downto 32) & x(47 downto 44);
r2 <= x(23 downto 16) & x(31 downto 24);
r3 <= x( 3 downto  0) & x(15 downto  4); 

process(clk,reset)
begin    
    if reset='1' then
        y <= (others => '0');
    elsif clk'event and clk='1' then
        y <= r0 & r1 & r2 & r3;
    end if;
end process;
end shiftrows_arc;
