library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity sender_tb is
    --  Port ( );
end sender_tb;

architecture Behavioral of sender_tb is
    component sender is
        Port (
            rst, clk, en, btn, ready : in std_logic;
            send : out std_logic;
            char : out std_logic_vector(7 downto 0));
    end component;

    signal tb_rst, tb_clk, tb_en, tb_btn, tb_ready : std_logic := '0';
    signal tb_send : std_logic := '0';
    signal tb_char : std_logic_vector(7 downto 0) := (others => '0');

begin

    clk_gen_proc : process
    begin
        wait for 4 ns;
        tb_clk <= '1';

        wait for 4 ns;
        tb_clk <= '0';

    end process clk_gen_proc;

    ready_en_proc : process
    begin
        tb_rst <= '1';
        wait for 10 ns;
        tb_rst <= '0';

        tb_en <= '1';

        for i in 0 to 6 loop
            tb_btn <= '1';
            tb_ready <= '1';  -- making ready signal high to start processsing

            wait for 20 ns;
            tb_btn <= '0';  -- make btn 0 to get it to switch
            tb_ready <= '1';  -- keep ready at high

            wait for 40 ns;

        end loop;
    end process ready_en_proc;

    dut: sender port map (
            rst => tb_rst,
            clk => tb_clk,
            en => tb_en,
            btn => tb_btn,
            ready => tb_ready,
            send => tb_send,
            char => tb_char);
end Behavioral;