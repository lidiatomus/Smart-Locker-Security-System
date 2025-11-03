library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SR_Register is
    Port ( data_in : std_logic_vector(3 downto 0);
           clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (15 downto 0);
           count : out STD_LOGIC_VECTOR(2 downto 0));
end SR_Register;

architecture Behavioral of SR_Register is




component registru is
    Port ( data_in:std_logic_vector(3 downto 0);
           rst : in STD_LOGIC;
           clk: in std_logic;
           en : in std_logic;
           data_out : out STD_LOGIC_VECTOR (15 downto 0);
           count : out STD_LOGIC_VECTOR(2 downto 0));
end component;
component mpg is
    Port ( btn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           enable : out  STD_LOGIC);
end component;

signal inter: STD_LOGIC;

begin
mpg_1: mpg port map(btn => btn, clk => clk, enable => inter);
registru_shiftare_numarare: registru port map(data_in => data_in, -- cod tastatura
                                              clk => clk,
                                              rst => rst,
                                              en => inter, -- btn debounced
                                              data_out => data_out, 
                                              count => count);
end Behavioral;
