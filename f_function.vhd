library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity f_function is
    Port (
	   clk	    : in std_logic;
	   reset	: in std_logic;	 
        x   	: in std_logic_vector(63 downto 0);
        y   	: out std_logic_vector(63 downto 0)        
    );
end f_function;

architecture Behavioral of f_function is

component addconstants is
    Port ( 
	clk	: in std_logic;
	reset	: in std_logic;
        x   	: in std_logic_vector(63 downto 0);
        y   	: out std_logic_vector(63 downto 0)        
    );
end component;

component subcell is
    Port ( 
	       clk	: in std_logic;
	       reset	: in std_logic;
            sc_in   : in std_logic_vector(63 downto 0);
            sc_out   : out std_logic_vector(63 downto 0)        
        );
end component;

component shiftrow is
    Port ( 
	   clk	: in std_logic;
	   reset	: in std_logic;
        x   	: in std_logic_vector(63 downto 0);
        y   	: out std_logic_vector(63 downto 0)        
    );
end component;

component mixcolumn is
        Port ( 
        clk     : in std_logic;
        reset   : in std_logic;
            x   : in std_logic_vector(63 downto 0);
            y   : out std_logic_vector(63 downto 0)        
        );
end component;

signal x1   :std_logic_vector(63 downto 0);
signal y1   :std_logic_vector(63 downto 0);
signal y2   :std_logic_vector(63 downto 0);
signal y3   :std_logic_vector(63 downto 0);
signal y4   :std_logic_vector(63 downto 0);
signal y5   :std_logic_vector(63 downto 0);
signal y6   :std_logic_vector(63 downto 0);
signal y7   :std_logic_vector(63 downto 0);
signal y8   :std_logic_vector(63 downto 0);
signal y9   :std_logic_vector(63 downto 0);
signal y10   :std_logic_vector(63 downto 0);

begin

    add1    : addconstants port map(clk,reset,x1,y1);
    sub1    : subcell port map(clk,reset,y1,y2);
    shift1  : shiftrow  port map(clk,reset,y2,y3);
    mix1    : mixcolumn port map(clk,reset,y3,y4);
    
    add2    : addconstants port map(clk,reset,y4,y5);
    sub2    : subcell port map(clk,reset,y5,y6);
    shift2  : shiftrow  port map(clk,reset,y7,y8);
    mix2    : mixcolumn port map(clk,reset,y9,y10);

process(clk,reset)
begin
	if reset='1' then
		y<= (others=>'0');
	elsif clk'event and clk='1' then
    		y <= y10;
	end if;
end process;

end Behavioral;
