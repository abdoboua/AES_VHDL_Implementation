


-- ABDELLAH BOUAGOUN 

-- ARK_tb

library IEEE;
use IEEE.std_logic_1164.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity AddRoundKey_tb is
end AddRoundKey_tb;

architecture ARK_tb_arch of AddRoundKey_tb is


component add_round_key
port ( a_i: in type_state;
	round_key_i: in type_state;
	a_o: out type_state );
end component;

signal input:type_state;
signal key:type_state;
signal output:type_state;
begin

ARK: add_round_key port map(
a_i => input,
round_key_i => key,
a_o => output
);

input <= ((X"bf",X"40",X"a3",X"9e"),(X"81",X"f3",X"d7",X"fb"),(X"7c",X"e3"
,X"11",X"39"),(X"82",X"9b",X"2f",X"ff"));

key <= ((X"ff",X"20",X"a3",X"9e"),(X"71",X"f3",X"d7",X"fb"),(X"7a",X"e1"
,X"11",X"39"),(X"82",X"9b",X"2f",X"ff"));

end ARK_tb_arch;

