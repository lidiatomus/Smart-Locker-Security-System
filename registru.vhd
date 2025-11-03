library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity registru is
    Port (data_in: in std_logic_vector(3 downto 0); -- cod tastatura
           rst : in STD_LOGIC;
           clk: in std_logic; 
           en : in std_logic;
           data_out : out STD_LOGIC_VECTOR (15 downto 0); -- cod introdus pe ssd
           count : out STD_LOGIC_VECTOR(2 downto 0));
end registru;

architecture Behavioral of registru is
    signal d1 : std_logic_vector(15 downto 0) := "0000000000000000";
    signal count1 : std_logic_vector(2 downto 0) := "000";
begin
    process(rst, d1, clk, en, count1)
    begin
        if rst = '1' then 
            d1 <= x"0000";
            count1 <= "000";
        elsif rising_edge(clk) then
            if en = '1' then
                if count1 = "100" then
                    d1 <= x"0000";
                    count1 <= "000";
                else 
                    d1 <= data_in & d1(15 downto 4);
                    count1 <= count1 + 1;
                end if;
            end if;
        end if;
    end process;
    data_out <= d1;
    count <= count1;
end Behavioral;

