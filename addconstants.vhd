--/* addConstants in c */
--void addConstants(STATE *s, int r) {
--  s->b[0] ^=               (((RCONST[r] >> 3) & 0x7) << 24) ^ (0x1 << 12) ^ (((RCONST[r] >> 0) & 0x7) << 8);
--  s->b[1] ^= (0x2 << 28) ^ (((RCONST[r] >> 3) & 0x7) << 24) ^ (0x3 << 12) ^ (((RCONST[r] >> 0) & 0x7) << 8);
--}
-- msr, cilipadi

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  

entity addconstants is
port(   
        clk     : in std_logic;
        reset   : in std_logic;
        x       :	in std_logic_vector(63 downto 0);
     --   r   : in integer range 0 to 48;
	    y      :	out std_logic_vector(63 downto 0)
	);
end addconstants;


architecture behavioral of addconstants is

signal r                : integer range 0 to 48:=10;
signal r0,r1            : STD_LOGIC_VECTOR (31 downto 0);

signal r0_in            : std_logic_vector(31 downto 0);
signal r1_in            : std_logic_vector(31 downto 0);

signal pad24              :std_logic_vector(23 downto 0):=x"000000";
signal pad28              :unsigned(27 downto 0):=(others=>'0');


signal r0_consts_left    : std_logic_vector(31 downto 0):=x"00000000";

signal r0_consts_right   : unsigned(31 downto 0):=x"00000000";

signal r1_consts_left    :   std_logic_vector(31 downto 0):=x"00000000";
signal r1_consts_right   :   unsigned(31 downto 0):=x"00000000";

signal r0_consts_inter   :   unsigned(31 downto 0):=x"00000000";
signal r1_consts_inter   :   unsigned(31 downto 0):=x"00000000";

signal r1_consts_begin   :   unsigned(31 downto 0):=x"00000000";

signal con      : std_logic_vector(7 downto 0);
type rconsts is array (0 to 47) of unsigned(7 downto 0);

signal led_rconsts :rconsts;

--  s->b[0] ^=               (((RCONST[r] >> 3) & 0x7) << 24) ^ (0x1 << 12) ^ (((RCONST[r] >> 0) & 0x7) << 8); s is the whole state 64 bit
--  s->b[1] ^= (0x2 << 28) ^ (((RCONST[r] >> 3) & 0x7) << 24) ^ (0x3 << 12) ^ (((RCONST[r] >> 0) & 0x7) << 8); s is the whole state 64 bit

begin
led_rconsts <=(x"01",x"03",x"07",x"0F",
                x"1F",x"3E",x"3D",x"3B",
                x"37",x"2F",x"1E",x"3C",
                x"39",x"33",x"27",x"0E",
                x"1D",x"3A",x"35",x"2B",
                x"16",x"2C",x"18",x"30",
                x"21",x"02",x"05",x"0B",
                x"17",x"2E",x"1C",x"38",
                x"31",x"23",x"06",x"0D",
                x"1B",x"36",x"2D",x"1A",
                x"34",x"29",x"12",x"24",
                x"08",x"11",x"22",x"04");

r0_calc : process
begin
    r0_consts_left <= pad24 & std_logic_vector(shift_left(shift_right(led_rconsts(r),3) and x"07",24));
   r0_consts_inter <= pad28 & shift_left(x"1",12);
   r0_consts_right <= unsigned(pad24) & shift_right((led_rconsts(r) and x"07"),8);
   r0_in <= x(31 downto 0);
   r0 <= r0_in xor r0_consts_left xor std_logic_vector(r0_consts_inter xor r0_consts_right);
    
end process;

r1_calc: process
begin
   r1_consts_left <= pad24 & std_logic_vector(shift_left(shift_right(led_rconsts(r),3) and x"07",24));
   r1_consts_inter <= pad28 & shift_left(x"3",12);
   r1_consts_right <= unsigned(pad24) & shift_right((led_rconsts(r) and x"07"),8);
   r1_in <= x(63 downto 32);   
   r1 <= r1_in xor r1_consts_left xor std_logic_vector(r1_consts_inter xor r1_consts_right);
end process;

output: process(clk,reset,r0,r1)
begin
    if reset = '1' then
        y <= (others => '0');
    elsif clk'event and clk = '1' then
        y <= r0 & r1;
    end if;
end process;
end behavioral;