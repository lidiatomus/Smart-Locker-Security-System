library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity button_counter is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(2 downto 0));
end button_counter;

architecture Behavioral of button_counter is
    signal counter : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal inter : STD_LOGIC;
    component mpg is
    Port ( btn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           enable : out  STD_LOGIC);
end component mpg;
begin
    l1: mpg port map (btn => btn, clk => clk, enable => inter);
    process(btn, reset)
    begin
        if reset = '1' then
            counter <= "000";
        else 
            if inter = '1' and rising_edge(clk) then
                counter <= counter + 1;
            end if;
       
        end if;
    end process;
    data_out <= counter;
end Behavioral;
