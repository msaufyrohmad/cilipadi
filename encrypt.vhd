--
-- take from encrypt.c in cilipadi c implementation
-- fixed message and ad size is use.
-- 
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encrypt is
    Port ( 
        signal  ciphertext  :   in std_logic_vector(255 downto 0);
        signal  plaintext   :   in std_logic_vector(127 downto 0);
        signal  ad          :   in std_logic_vector(63 downto 0);    
        signal  nsec        :   in std_logic_vector(127 downto 0);
        signal  nonce        :   in std_logic_vector(127 downto 0);
        signal  key        :   in std_logic_vector(127 downto 0)
        );
end encrypt;

architecture Behavioral of encrypt is
component permutation_n is
       Port (   
            state        : in std_logic_vector(255 downto 0);
            round        : in integer;
            state_out    :out std_logic_vector(255 downto 0)    
       );
end component;

component xor_bytes is
    Port (
        x   : in    std_logic_vector(63 downto 0);
        y   : in    std_logic_vector(63 downto 0);
        z   : out   std_logic_vector(63 downto 0)
         );
end component;

    signal state            : std_logic_vector(255 downto 0):= key & nonce;
    signal state_out        : std_logic_vector(255 downto 0);
    
    signal state_r          : std_logic_vector(63 downto 0);
    signal  i               : integer;
    signal  j               : integer;
    signal  round18         : integer :=18;
    signal  round16         : integer := 16;
    signal  test            : std_logic_vector(63 downto 0);
    
begin
    perm    : permutation_n port map(state,round18,state_out);
   
   -- alot to do here!
   
   
end Behavioral;
