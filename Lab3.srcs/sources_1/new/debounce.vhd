library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    Port ( clk : in STD_LOGIC;
         btn : in STD_LOGIC;
         dbnc : out STD_LOGIC:='0');
end debounce;

architecture Behavioral of debounce is
    signal counter : std_logic_vector (21 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (btn = '1') then
                if unsigned(counter) > 2499999 then
                    dbnc <= '1';
                else
                    counter <= std_logic_vector(unsigned(counter) + 1);
                end if;
            else
                dbnc <= '0';
                counter <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;