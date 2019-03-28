-- cilipadi top. instantiate data path and fsm
-- msr

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cilipadi_top is
        Port (
            clock   : in std_logic;
            cp_reset   : in std_logic
         );
end cilipadi_top;

architecture Behavioral of cilipadi_top is
component cilipadi_fsm is
    Port ( 
        clk         : in std_logic;
        reset       : in std_logic;
        cp_ready    : in std_logic;
        start       : out std_logic;
        init_done   : in std_logic;
        ad_start    : out std_logic;
        ad_done     : in std_logic;
        msg_start   : out std_logic;
        msg_done    : in std_logic;
        final_start : out std_logic;
        final_done  : in std_logic;
        tag_start   : out std_logic;
        tag_done    : in std_logic
    );
end component;

component cilipadi_datapath is
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
end component;

-- local signal declarations
        signal cp_ready    : std_logic;--here 
        signal start       : std_logic;
        signal init_done   : std_logic;
        signal ad_start    : std_logic;
        signal ad_done     : std_logic;
        signal msg_start   : std_logic;
        signal msg_done    : std_logic;
        signal final_start : std_logic;
        signal final_done  : std_logic;
        signal tag_start   : std_logic;
        signal tag_done    : std_logic;-- until here is status and control signals from/to fsm.
        
        signal ciphertext  :   std_logic_vector(255 downto 0);
        signal plaintext   :   std_logic_vector(127 downto 0);
        signal ad          :   std_logic_vector(63 downto 0);    
        signal nsec        :   std_logic_vector(127 downto 0);
        signal nonce       :  std_logic_vector(127 downto 0);
        signal key         :   std_logic_vector(127 downto 0);  


begin
    cp_cu   : cilipadi_fsm port map(clock,cp_reset,cp_ready,start,init_done,ad_start,ad_done,msg_start,msg_done,final_start,final_done,tag_start,tag_done);    
    cp_dp   : cilipadi_datapath port map(clock,cp_reset,cp_ready,start,init_done,ad_start,ad_done,msg_start,msg_done,final_start,final_done,tag_start,tag_done,ciphertext,plaintext,ad,nsec,nonce,key); 

end Behavioral;
