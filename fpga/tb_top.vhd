library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is
end entity;

architecture sim of tb_top is

    constant CLK_PERIOD : time := 10 ns;      -- 100 MHz
    constant BAUD_TICK  : time := 104166 ns;  -- 9600 baud

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal rx  : std_logic := '1';
    signal tx  : std_logic;

begin

    ------------------------------------------------------------------
    -- Clock generation
    ------------------------------------------------------------------
    clk <= not clk after CLK_PERIOD / 2;

    ------------------------------------------------------------------
    -- DUT (Device Under Test)
    ------------------------------------------------------------------
    uut : entity work.top
        port map (
            clk => clk,
            rst => rst,
            rx  => rx,
            tx  => tx
        );

    ------------------------------------------------------------------
    -- UART stimulus
    ------------------------------------------------------------------
    stimulus : process
    begin
        -- Reset
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 us;

        ------------------------------------------------------------------
        -- Send byte 0x41 ('A')
        ------------------------------------------------------------------

        -- Start bit
        rx <= '0';
        wait for BAUD_TICK;

        -- Data bits (LSB first)
        rx <= '1'; wait for BAUD_TICK; -- bit 0
        rx <= '0'; wait for BAUD_TICK; -- bit 1
        rx <= '0'; wait for BAUD_TICK; -- bit 2
        rx <= '0'; wait for BAUD_TICK; -- bit 3
        rx <= '0'; wait for BAUD_TICK; -- bit 4
        rx <= '0'; wait for BAUD_TICK; -- bit 5
        rx <= '1'; wait for BAUD_TICK; -- bit 6
        rx <= '0'; wait for BAUD_TICK; -- bit 7

        -- Stop bit
        rx <= '1';
        wait for 2 ms;

        wait;
    end process;

end architecture;
