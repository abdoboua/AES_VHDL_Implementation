



-- ABDELLAH BOUAGOUN 

-- MultiplyMatrix_tb

library IEEE;
use IEEE.std_logic_1164.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity MultiplyMatrix_tb is
end MultiplyMatrix_tb;

architecture MultiplyMatrix_tb_arch of MultiplyMatrix_tb is


component MultiplyMatrix
port ( data_i : in column_state;
        data_o : out column_state );
end component;

signal input:column_state; 
signal output:column_state;

begin

MC: MultiplyMatrix port map(
data_i => input,
data_o => output
);

input <= (X"14",X"e5",X"ff",X"00");
end MultiplyMatrix_tb_arch;

