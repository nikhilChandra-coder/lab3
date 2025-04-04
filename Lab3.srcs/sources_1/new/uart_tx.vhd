library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
    Port (
        clk, en, send, rst : in std_logic;
        char : in std_logic_vector(7 downto 0);
        ready, tx : out std_logic
    );
end uart_tx;
architecture Behavioral of uart_tx is
    type state_type is (idle, start, data);
    signal state: state_type := idle;
    signal char_reg : std_logic_vector(7 downto 0) := (others => '0');
    signal bit_counter : std_logic_vector(2 downto 0) := "000";
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                ready <= '1';
                tx <= '1';
                bit_counter <= (others => '0');
            elsif (en = '1') then
                case state is
                    when idle =>
                        ready <= '1';
                        tx <= '1';
                        if send = '1' then
                            bit_counter <= (others => '0');
                            ready <= '0';
                            tx <= '0';
                            char_reg <= char;
                            state <= start;
                        else
                            ready <= '1';
                            tx <= '1';
                            state <= idle;
                        end if;
                    when start =>
                        tx <= char_reg(0);
                        bit_counter <= (others => '0');
                        state <= data;
                    when data =>
                        if (unsigned(bit_counter)) < 7 then
                            tx <= char_reg(to_integer(unsigned(bit_counter) + 1));
                            bit_counter <= std_logic_vector(unsigned(bit_counter) + 1);
                            state <= data;
                        else
                            tx <= '1';
                            state <= idle;
                            bit_counter <= (others => '0');
                            ready <= '1';
                        end if;
                    when others =>
                        state <= idle;
                end case;
            end if;
        end if;
    end process;
end Behavioral;