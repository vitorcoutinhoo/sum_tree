library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

use work.custom.all;

entity sum_tree is
    port(
        clk : in std_logic;
        rst : in std_logic;
        vector : in signed_array(0 to N_SUM-1);
        sum : out sum_word_t
    );
end sum_tree;

architecture Behavioral of sum_tree is

    -- total de estagios da arvore
    constant stages : natural := log2(N_SUM);

    -- arvore de somas por estagio
    type tree_array is array (natural range <>) of sum_array(0 to N_SUM-1);
    signal tree : tree_array(0 to stages);

begin

    -- registra entradas no estagio 0
    load_input : for i in 0 to N_SUM-1 generate
        input_proc : process(clk)
        begin
            if rising_edge(clk) then
                if rst = '0' then
                    tree(0)(i) <= (others => '0');
                else
                    -- ajusta o tamanho pra a quantidade max de bits sem overflow
                    tree(0)(i) <= resize(vector(i), OUT_WIDTH);
                end if;
            end if;
        end process;
    end generate;

    -- gera estagios da arvore
    gen_stages : for stage in 1 to stages generate
        constant prev_len : natural := N_SUM / (2 ** (stage - 1));
        constant curr_len : natural := prev_len / 2;
    begin
        -- gera os somadores
        adder_gen : for j in 0 to curr_len - 1 generate
            -- cria um somador de 2 entradas
            sum_unit : entity work.adder
                port map (
                    clk => clk,
                    a   => tree(stage - 1)(2*j),
                    b   => tree(stage - 1)(2*j + 1),
                    res => tree(stage)(j)
                );
        end generate;
    end generate;

    -- saida final
    sum <= tree(stages)(0);
end Behavioral;
