library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package body custom is
    -- func pra achar log2(n), arredondando para cima
    function log2(n : natural) return natural is
        variable res : natural := 0;
        variable val : natural := n - 1; -- valor a ser manipulado
    begin
        -- divide o valor por 2 ate val = 0
        while val > 0 loop
            val := val / 2;
            res := res + 1; -- conta quantas vezes consegue dividir por 2
        end loop;
        
        -- res vai ser igual log2(n)
        return res; 
    end function;
end package body;