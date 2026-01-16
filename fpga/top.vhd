library ieee;
use ieee.std_logic_1164.all;

entity top is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        rx  : in  std_logic;
        tx  : out std_logic
    );
end entity;

architecture rtl of top is
    signal rx_data   : std_logic_vector(7 downto 0);
    signal rx_valid  : std_logic;
    signal tx_start  : std_logic;
    signal tx_busy   : std_logic;
begin

    uart_rx_inst : entity work.uart_rx
        port map (
            clk        => clk,
            rst        => rst,
            rx         => rx,
            data_out   => rx_data,
            data_valid => rx_valid
        );

    uart_tx_inst : entity work.uart_tx
        port map (
            clk      => clk,
            rst      => rst,
            tx_start => rx_valid,
            data_in  => rx_data,
            tx       => tx,
            busy     => tx_busy
        );

end architecture;
