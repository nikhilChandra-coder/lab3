library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity clock_div is
    port (
        clk : in std_logic;
        en : out std_logic
    );
end clock_div;

architecture behavioral of clock_div is
    signal counter : std_logic_vector(11 downto 0) := (others => '0');
begin
    process(clk)
    begin

        if rising_edge(clk) then

            if (unsigned(counter) < 1085) then
                counter <= std_logic_vector(unsigned(counter) + 1);
                en <='0';
            else
                counter <= (others => '0');
                en <= '1';
            end if;
        end if;

    end process;
end Behavioral;