-- fsm to control cilipadi data path
-- msr, cilipadi

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cilipadi_fsm is
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
end cilipadi_fsm;

architecture Behavioral of cilipadi_fsm is
    type cilipadi_state is (idle,init_phase, ad_phase,msg_phase,final_phase,tag_phase);
    signal next_state,current_state: cilipadi_state;
    
begin
process(clk,reset)
begin
    if reset ='1' then
        current_state <= idle;
    elsif clk'event and clk='1' then
        current_state <= next_state;
    end if;
end process;

comb_logic:process(current_state,init_done,ad_done,msg_done,final_done,tag_done)
begin
    case current_state is
        when idle =>    if cp_ready ='1' then
                            start <= '1';
                            next_state <= init_phase;
                        elsif cp_ready='0' then
                            next_state <= idle;
                        end if;
                        
        when init_phase => if init_done = '1' then
                                ad_start <= '1';
                                next_state <= ad_phase;
                           elsif init_done = '0' then
                                next_state <= init_phase;
                           end if;   
        
        when ad_phase  => if ad_done = '1' then
                                msg_start <= '1';
                                next_state <= msg_phase;
                          elsif ad_done = '0' then
                                next_state <= ad_phase;
                          end if;
        
        when msg_phase => if msg_done = '1' then
                                final_start <= '1';
                                next_state <= final_phase;
                          elsif msg_done = '0' then
                                next_state <= msg_phase;
                          end if;
        
        when final_phase => if final_done = '1' then
                                tag_start <= '1';
                                next_state <= tag_phase;
                          elsif final_done = '0' then
                                next_state <= final_phase;
                          end if;
                                  
        when tag_phase => if tag_done = '1' then
                               next_state <= idle;
                          elsif tag_done = '0' then
                                next_state <= tag_phase;
                          end if;
        when others => next_state <= idle;
        end case;
      end process;
end Behavioral;
