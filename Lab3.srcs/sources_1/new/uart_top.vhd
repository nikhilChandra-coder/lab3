library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity uart_top is
    port (
        TXD, clk : in std_logic;
        btn : in std_logic_vector(1 downto 0);
        CTS, RTS, RXD : out std_logic);
end uart_top;
architecture Behavioral of uart_top is
    component sender is
        port(
            rst, clk, en, btn, ready : in std_logic;
            send : out std_logic;
            char : out std_logic_vector(7 downto 0));
    end component;
    component clock_div is
        port(
            clk : in std_logic;
            en : out std_logic);
    end component;
    component debounce is
        port (
            clk : in std_logic;
            btn : in std_logic;
            dbnc : out std_logic);
    end component;
    component uart is
        port (
            clk, en, send, rx, rst      : in std_logic;
            charSend                    : in std_logic_vector (7 downto 0);
            ready, tx, newChar          : out std_logic;
            charRec                     : out std_logic_vector (7 downto 0));
    end component;

    signal dbncrst, dbncbtn, ensignal : std_logic;
    signal sendsignal : std_logic;
    signal char_signal : std_logic_vector(7 downto 0);
    signal read_signal : std_logic;

begin
    u1 : debounce
        port map (
            clk => clk,
            btn => btn(0),
            dbnc => dbncrst);
    u2 : debounce
        port map (
            clk => clk,
            btn => btn(1),
            dbnc => dbncbtn);
    u3 : clock_div
        port map (
            clk  => clk,
            en => ensignal);
    u4 : sender
        port map (
            rst => dbncrst,
            clk => clk,
            en => ensignal,
            btn => dbncbtn,
            ready => read_signal,
            send => sendsignal,
            char => char_signal);
    u5 : uart
        port map (
            clk => clk,
            en => ensignal,
            send => sendsignal,
            rx => TXD,
            rst => dbncrst,
            charSend => char_signal,
            ready => read_signal,
            tx => RXD);
    RTS <= '0';
    CTS <= '0';
end Behavioral;