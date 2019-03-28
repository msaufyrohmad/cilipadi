library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity subcell is
    Port ( 
            clk     : in std_logic;
            reset   : in std_logic;
            sc_in  : in STD_LOGIC_VECTOR (63 downto 0);
           sc_out : out STD_LOGIC_VECTOR (63 downto 0));
end subcell;

architecture subcells_arc of subcell is

component sbox is 
Port (  
        x : in  STD_LOGIC_VECTOR (3 downto 0);
        y : out STD_LOGIC_VECTOR (3 downto 0)
        );
end component;

begin
o1  : sbox port map (sc_in(63 downto 60), sc_out(63 downto 60));
o2  : sbox port map (sc_in(59 downto 56), sc_out(59 downto 56));
o3  : sbox port map (sc_in(55 downto 52), sc_out(55 downto 52));
o4  : sbox port map (sc_in(51 downto 48), sc_out(51 downto 48));
o5  : sbox port map (sc_in(47 downto 44), sc_out(47 downto 44));
o6  : sbox port map (sc_in(43 downto 40), sc_out(43 downto 40));
o7  : sbox port map (sc_in(39 downto 36), sc_out(39 downto 36));
o8  : sbox port map (sc_in(35 downto 32), sc_out(35 downto 32));
o9  : sbox port map (sc_in(31 downto 28), sc_out(31 downto 28));
o10 : sbox port map (sc_in(27 downto 24), sc_out(27 downto 24));
o11 : sbox port map (sc_in(23 downto 20), sc_out(23 downto 20));
o12 : sbox port map (sc_in(19 downto 16), sc_out(19 downto 16));
o13 : sbox port map (sc_in(15 downto 12), sc_out(15 downto 12));
o14 : sbox port map (sc_in(11 downto  8), sc_out(11 downto  8));
o15 : sbox port map (sc_in( 7 downto  4), sc_out( 7 downto  4));
o16 : sbox port map (sc_in( 3 downto  0), sc_out( 3 downto  0));
end subcells_arc;