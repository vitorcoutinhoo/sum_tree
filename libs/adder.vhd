library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.custom.all;

entity adder is
    port(
        clk : in std_logic;
        a, b : in sum_word_t;
        res : out sum_word_t
    );
end adder;

architecture Behavioral of adder is
    signal reg : sum_word_t;
begin
    -- processo somador de 2 entradas
    sum : process(clk)
    begin
        if rising_edge(clk) then
            reg <= a + b;
        end if;
    end process;
    
    res <= reg;
end Behavioral;
