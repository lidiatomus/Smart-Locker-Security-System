library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ssd is
    Port ( digit : in  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           anod : out  STD_LOGIC_VECTOR (3 downto 0);
           catod : out  STD_LOGIC_VECTOR (6 downto 0));
end ssd;

architecture Behavioral of ssd is
signal counter:std_logic_vector(15 downto 0);
signal rez_mux:std_logic_vector(3 downto 0);
begin

process(clk)
begin
 if clk'event and clk = '1'  then  
	counter <= counter + 1;
 end if;
end process;


--selectie anod
process(counter)
begin
	case (counter(15 downto 14)) is 
		when "00" => anod <= "1110";
		when "01" => anod <= "1101";
		when "10" => anod <= "1011";
		when others => anod <= "0111";
	end case;
end process;


process(counter, digit)
begin
	case (counter(15 downto 14)) is 
		when "00" => rez_mux <= digit(15 downto 12);
		when "01" => rez_mux <= digit(11 downto 8);
		when "10" => rez_mux <= digit(7 downto 4);
		when others => rez_mux <= digit(3 downto 0);
	end case;
end process;


process(rez_mux)
begin
	case rez_mux is
        when "0000" => catod <= "0000001";
		when "0001" => catod <= "1001111";
		when "0010" => catod <= "0010010";
		when "0011" => catod <= "0000110";
		when "0100" => catod <= "1001100";
		when "0101" => catod <= "0100100";
		when "0110" => catod <= "0100000";
		when "0111" => catod <= "0001111";
		when "1000" => catod <= "0000000";
		when "1001" => catod <= "0000100";
		when "1010" => catod <= "0001000";
		when "1011" => catod <= "1100000";
		when "1100" => catod <= "0110001";
		when "1101" => catod <= "1000010";
		when "1110" => catod <= "0110000";
		when others => catod <= "0111000";
	end case;
end process;

end Behavioral;
