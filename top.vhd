library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( rst: in  STD_LOGIC;
           btn: in  STD_LOGIC;
		   clk : in  STD_LOGIC;
		   JA : inout  STD_LOGIC_VECTOR (7 downto 0); 
           an : out  STD_LOGIC_VECTOR (3 downto 0);   
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           free_locker : out STD_LOGIC;
           led_locked : out STD_LOGIC);
end top;

architecture Behavioral of top is

component button_counter is
    Port ( clk : in std_logic;
           btn : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (2 downto 0));
end component button_counter;

component Decoder is
	Port ( clk : in  STD_LOGIC;
           Row : in  STD_LOGIC_VECTOR (3 downto 0);
	       Col : out  STD_LOGIC_VECTOR (3 downto 0);
           DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
end component Decoder;


component ssd is
    Port ( digit : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           anod : out  STD_LOGIC_VECTOR (3 downto 0);
           catod : out  STD_LOGIC_VECTOR (6 downto 0));
end component ssd;

component SR_Register is
    Port ( data_in: STD_LOGIC_VECTOR(3 downto 0);
           clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (15 downto 0);
		   count : out STD_LOGIC_VECTOR(2 downto 0));
end component SR_Register;

type state_type is (free, locked);
signal current_state : state_type := free;
signal data_out4 : STD_LOGIC_VECTOR (2 downto 0); -- used to check if all 4 digits have been typed
signal DecodeDigit: STD_LOGIC_VECTOR (3 downto 0);
signal DecodeAll: STD_LOGIC_VECTOR (15 downto 0);
signal correct_pin_entered : STD_LOGIC_VECTOR (15 downto 0);

signal count_aux : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal firsttime : STD_LOGIC := '1';
begin

C1: Decoder port map (clk => clk, Row => JA(7 downto 4), Col => JA(3 downto 0), DecodeOut => DecodeDigit);
C3: SSD port map (clk => clk, digit => DecodeAll, anod => an, catod => seg);
C2: SR_Register port map (data_in => DecodeDigit, clk => clk,  btn => btn, rst => rst, data_out => DecodeAll, count => count_aux);
l1: button_counter port map (clk => clk, btn => btn, reset => rst, data_out => data_out4);

process(clk, btn, rst, count_aux)
begin
if rising_edge(clk) then
    if rst = '1' then current_state <= free;
    else case current_state is
    when free =>  if count_aux = "100" then
                       if firsttime = '1' then
                            free_locker <= '1';
                       else free_locker <= '0';
                            led_locked <= '1';
                       end if;
                  else free_locker <= '1';
                       led_locked <= '0';
                  end if;
                  
                        
                  if data_out4 < "101" then
                     correct_pin_entered <= DecodeAll;        
                  else if data_out4 = "101" then 
                            firsttime <= '0';
                            current_state <= locked;
                            free_locker <= '0';    
                       end if;
                  end if;
                        
    when locked =>  free_locker <= '0';
                    led_locked <= '1';
                    
                    if DecodeAll = correct_pin_entered then
                        current_state <= free;
                            
                    end if; 
    end case;
    end if;
end if;
end process;
end Behavioral;

