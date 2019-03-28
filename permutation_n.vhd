
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity permutation_n is
       Port (
            clk         :   in std_logic;
            reset       : in std_logic;   
            state        : in std_logic_vector(255 downto 0);
            round        : in integer;
            state_out    :out std_logic_vector(255 downto 0)    
       );
end permutation_n;

architecture Behavioral of permutation_n is
component f_function is
    Port ( 
        x   : in std_logic_vector(63 downto 0);
        y   : out std_logic_vector(63 downto 0)        
    );
end component;

component xor_bytes is
    Port (
        x   : in    std_logic_vector(63 downto 0);
        y   : in    std_logic_vector(63 downto 0);
        z   : out   std_logic_vector(63 downto 0)
         );
end component;

    signal x1       : std_logic_vector(63 downto 0):=state(63 downto 0);
    signal x2       : std_logic_vector(63 downto 0):=state(127 downto 64);
    signal x3       : std_logic_vector(63 downto 0):=state(191 downto 128);
 --   signal x4       : std_logic_vector(63 downto 0):=state(255 downto 192);
     signal x4       : std_logic_vector(63 downto 0):=state(63 downto 0);
    signal temp     : std_logic_vector(63 downto 0);
    
    signal x1xorx2  : std_logic_vector(63 downto 0);
    signal x3xorx4  : std_logic_vector(63 downto 0);
    
    
begin

--ff: process
--begin
    --ffunction:for k in 0 to round'length-1 loop
        f_func1 :   f_function port map(x1);
        x1x2    :   xor_bytes port map(x1,x2,x1xorx2);

        f_func2 :   f_function port map(x3);
        x3x4    :   xor_bytes port map(x3,x4,x3xorx4);

            temp <= x1;
            x1 <= x2;
            x2 <= x3;
            x3 <= x4;
            x4 <= temp;

    --end loop ffunction;
--end process ff;
  
process(clk,reset)
begin
	if reset='1' then
    		state_out <=(others =>'0');
	elsif clk'event and clk='1' then
	       state_out(63 downto 0)<=x1;
    	   state_out(127 downto 64)<=x2;
    	   state_out(191 downto 128)<=x3;
    	   state_out(255 downto 192)<=x4;
    end if;
end process;
   
end Behavioral;
