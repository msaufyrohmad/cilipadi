
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cilipadi_datapath is
    Port (
        clk         : in std_logic;
        reset       : in std_logic;
        cp_ready    : out std_logic;--here 
        start       : in std_logic;
        init_done   : out std_logic;
        ad_start    : in std_logic;
        ad_done     : out std_logic;
        msg_start   : in std_logic;
        msg_done    : out std_logic;
        final_start : in std_logic;
        final_done  : out std_logic;
        tag_start   : in std_logic;
        tag_done    : out std_logic;-- until here is status and control signals from/to fsm.
        
        ciphertext  :   in std_logic_vector(255 downto 0);
        plaintext   :   in std_logic_vector(127 downto 0);
        ad          :   in std_logic_vector(63 downto 0);    
        nsec        :   in std_logic_vector(127 downto 0);
        nonce        :   in std_logic_vector(127 downto 0);
        key        :   in std_logic_vector(127 downto 0)   
     );
end cilipadi_datapath;

architecture Behavioral of cilipadi_datapath is
component encrypt is
    Port ( 
        signal  ciphertext  :   in std_logic_vector(255 downto 0);
        signal  plaintext   :   in std_logic_vector(127 downto 0);
        signal  ad          :   in std_logic_vector(63 downto 0);    
        signal  nsec        :   in std_logic_vector(127 downto 0);
        signal  nonce        :   in std_logic_vector(127 downto 0);
        signal  key        :   in std_logic_vector(127 downto 0)
        );
end component;

   -- signals for encrypt
    signal  ct              :   std_logic_vector(255 downto 0);
    signal  pt              :   std_logic_vector(127 downto 0);
    signal  authdata        :   std_logic_vector(63 downto 0);    
    signal  n               :   std_logic_vector(127 downto 0);
    signal  nonce_signal    :   std_logic_vector(127 downto 0);
    signal  key_signal      :   std_logic_vector(127 downto 0);

begin

enc: encrypt port map(ct,pt,authdata,n,nonce_signal,key_signal);

process(clk,reset)
begin
        if  reset ='1' then
            cp_ready  <= '0'; 
            init_done <= '0';
            ad_done   <= '0';
            msg_done  <= '0';
            final_done <= '0';
            tag_done   <= '0'; 
        elsif clk'event and clk='1' then
            if start = '1' then        
                cp_ready  <= '1'; 
                init_done <= '1';
            end if;
            if ad_start = '1' then
                ad_done   <= '1';
            end if;
            if msg_start = '1'then 
                msg_done  <= '1';
            end if;
            if final_start = '1' then
                final_done  <= '1';
            end if;
            if tag_start   ='1' then
                tag_done   <= '1'; 
            end if;
        end if;
end process;

end Behavioral;
