library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
    generic (
        CLK_FREQ  : integer := 100_000_000;
        BAUD_RATE : integer := 9600
    );
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        tx_start : in  std_logic;
        data_in  : in  std_logic_vector(7 downto 0);
        tx       : out std_logic;
        busy     : out std_logic
    );
end entity;

architecture rtl of uart_tx is
    constant BAUD_CNT : integer := CLK_FREQ / BAUD_RATE;
    signal cnt        : integer range 0 to BAUD_CNT := 0;
    signal bit_cnt    : integer range 0 to 9 := 0;
    signal shift_reg  : std_logic_vector(9 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                tx   <= '1';
                busy <= '0';
                cnt  <= 0;
            else
                if tx_start = '1' and busy = '0' then
                    shift_reg <= '1' & data_in & '0'; -- stop + data + start
                    busy      <= '1';
                    bit_cnt   <= 0;
                    cnt       <= 0;
                elsif busy = '1' then
                    if cnt = BAUD_CNT then
                        cnt <= 0;
                        tx  <= shift_reg(bit_cnt);

                        if bit_cnt = 9 then
                            busy <= '0';
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
