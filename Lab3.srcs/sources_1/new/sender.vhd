library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity sender is
    Port (
        rst, clk, en, btn, ready : in std_logic;
        send : out std_logic;
        char : out std_logic_vector(7 downto 0)
    );
end sender;

architecture Behavioral of sender is

    --netid = nd808 (need array of size = 5, length 12 bits)
    type array_type is array(0 to 4) of std_logic_vector(7 downto 0);
    --n = 110, d = 100, 8 = 56, 0 = 48, 8 = 56
    signal netid : array_type := (
        "01101110", -- n
        "01100100", -- d
        "00111000", -- 8
        "00110000", -- 0
        "00111000");-- 8
    signal i : std_logic_vector(2 downto 0) := (others => '0');
    signal j : std_logic_vector(2 downto 0);

    type state_type is (idle, busyA, busyB, busyC);
    signal state: state_type := idle;
begin
    process(clk, rst, state)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                char <= (others => '0');
                send <= '0';
                i <= (others => '0');
                state <= idle;
            elsif (en = '1') then
                case state is
                    when idle =>
                        if (ready = '1' and btn = '1') then
                            if (to_integer(unsigned(i)) < 6) then
                                send <= '1';
                                char <= netid(to_integer(unsigned(i)));
                                i <= std_logic_vector(unsigned(i) + 1);
                                state <= busyA;
                            elsif (to_integer(unsigned(i)) = 6) then
                                i <= (others => '0');
                                state <= idle;
                            end if;
                        end if;
                    when busyA =>
                        state <= busyB;
                    when busyB =>
                        send <= '0';
                        state <= busyC;
                    when busyC =>
                        if (ready = '1' and btn = '0') then
                            state <= idle;
                        else
                            state <= busyC;
                        end if;
                    when others =>
                        char <= (others => '0');
                        send <= '0';
                        i <= (others => '0');
                        state <= idle;
                end case;
            end if;
        end if;
    end process;
end Behavioral;