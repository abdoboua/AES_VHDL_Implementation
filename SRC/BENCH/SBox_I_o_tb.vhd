
-- ABDELLAH BOUAGOUN 

-- SBOX_tb

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity sbox_tb is
end sbox_tb;

architecture sbox_tb_arch of sbox_tb is

component sbox
port ( entree_i : in bit8;  
       sortie_o: out bit8 );
end component;

signal input:bit8;
signal output:bit8;

begin

Box : sbox port map(
entree_i => input,
sortie_o => output
);

input <= x"01" , x"ef" after 99 ns ,
x"ab" after 150 ns ;

end sbox_tb_arch;

