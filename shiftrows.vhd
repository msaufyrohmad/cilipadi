
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shiftrows is
    Port ( x : in STD_LOGIC_VECTOR (63 downto 0);
           y : out STD_LOGIC_VECTOR (63 downto 0));
end shiftrows;

architecture shiftrows_arc of shiftrows is
signal r0,r1,r2,r3 : STD_LOGIC_VECTOR (15 downto 0);
begin

-- row by row
r0 <= x(63 downto 48);
r1 <= x(43 downto 32) & x(47 downto 44);
r2 <= x(23 downto 16) & x(31 downto 24);
r3 <= x( 3 downto  0) & x(15 downto  4); 

y <= r0 & r1 & r2 & r3;

end shiftrows_arc;