library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package custom is
    -- parametros gerais
    constant N_WORD : natural := 8; -- largura de cada numero (bits)
    constant N_SUM  : natural := 16; -- numero de elementos a somar
    
    -- funcao para log2 inteiro (arredondado para cima)
    function log2(n : natural) return natural;
    -- largura da saida 
    constant OUT_WIDTH : natural := N_WORD + log2(N_SUM);
    
    -- tipo de palavra individual
    subtype word_t is signed(N_WORD-1 downto 0);
    -- tipo para valores somados com tamanho adequado
    subtype sum_word_t is signed(OUT_WIDTH - 1 downto 0);

    -- vetor de entradas
    type signed_array is array (natural range <>) of word_t;
    -- vetor de somas
    type sum_array is array (natural range <>) of sum_word_t;
end package;
