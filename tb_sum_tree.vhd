library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.custom.all;

entity tb_sum_tree is
end entity;

architecture behavior of tb_sum_tree is
    -- sinais
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '0';
    signal vector  : signed_array(0 to N_SUM-1) := (others => (others => '0'));
    signal sum     : sum_word_t;

    -- clk
    constant CLK_PERIOD : time := 10 ns;
begin
    -- gerador de clock
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- UUT 
    uut: entity work.sum_tree
        port map (
            clk => clk,
            rst => rst,
            vector => vector,
            sum => sum
        );

    -- processo principal
    proc : process
    begin
        -- rst inicial
        rst <= '0';
        wait for CLK_PERIOD/2;
        rst <= '1';
        
        -- testando com 16 valores de 8 bits
        vector( 0) <= to_signed( 50, N_WORD);
        vector( 1) <= to_signed( 24, N_WORD);
        vector( 2) <= to_signed( 30, N_WORD);
        vector( 3) <= to_signed( 33, N_WORD);
        vector( 4) <= to_signed( 28, N_WORD);
        vector( 5) <= to_signed( 22, N_WORD);
        vector( 6) <= to_signed( 24, N_WORD);
        vector( 7) <= to_signed( 72, N_WORD);
        vector( 8) <= to_signed( 16, N_WORD);
        vector( 9) <= to_signed( 81, N_WORD);
        vector(10) <= to_signed( 12, N_WORD);
        vector(11) <= to_signed( 26, N_WORD);
        vector(12) <= to_signed( 50, N_WORD);
        vector(13) <= to_signed(  5, N_WORD);
        vector(14) <= to_signed( 27, N_WORD);
        vector(15) <= to_signed( 24, N_WORD);

        -- aguarda ciclos suficientes para todas as somas
        wait for log2(N_SUM) * CLK_PERIOD;
        wait;
    end process;

end architecture;
