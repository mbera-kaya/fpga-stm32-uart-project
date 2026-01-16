library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
    generic (
        CLK_FREQ  : integer := 100_000_000;
        BAUD_RATE : integer := 9600
    );
    port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        rx         : in  std_logic;
        data_out   : out std_logic_vector(7 downto 0);
        data_valid : out std_logic
    );
end entity;

architecture rtl of uart_rx is
    constant BAUD_CNT : integer := CLK_FREQ / BAUD_RATE;
    signal cnt        : integer range 0 to BAUD_CNT := 0;
    signal bit_cnt    : integer range 0 to 7 := 0;
    signal rx_shift   : std_logic_vector(7 downto 0) := (others => '0');
    signal busy       : std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt        <= 0;
                bit_cnt    <= 0;
                busy       <= '0';
                data_valid <= '0';
            else
                data_valid <= '0';

                if busy = '0' then
                    if rx = '0' then -- start bit
                        busy    <= '1';
                        cnt     <= BAUD_CNT / 2;
                        bit_cnt <= 0;
                    end if;
                else
                    if cnt = BAUD_CNT then
                        cnt <= 0;
                        rx_shift(bit_cnt) <= rx;

                        if bit_cnt = 7 then
                            busy       <= '0';
                            data_out   <= rx_shift;
                            data_valid <= '1';
                        else
                            bit_cnt <= bit_cnt + 1;
                        end if;
                    else
                        cnt <= cnt + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

end architecture;
