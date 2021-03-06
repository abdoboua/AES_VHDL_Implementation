



-- ABDELLAH BOUAGOUN 

-- MixColumns_tb

library IEEE;
use IEEE.std_logic_1164.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity MuxColumns_tb is
end MuxColumns_tb;

architecture MuxColumns_tb_arch of MuxColumns_tb is


component MixColumns
port ( data_i : in type_state;
      data_o : out type_state );
end component;

signal input:type_state;
signal output:type_state;
begin

MC: MixColumns port map(
data_i => input,
data_o => output
);

input <= ((X"af",X"16",X"ce",X"bc"),(X"e6",X"91",X"62",X"44"),(X"01",X"06"
,X"d3",X"20"),(X"d5",X"ab",X"b1",X"ae"));
end MuxColumns_tb_arch;

