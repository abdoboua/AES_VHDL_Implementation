

-- ABDELLAH BOUAGOUN 

-- Shift_Rows_tb

library IEEE;
use IEEE.std_logic_1164.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity Shift_Rows_tb is
end Shift_Rows_tb;

architecture Shift_Rows_tb_arch of Shift_Rows_tb is


component shift_rows
port ( state_i: in type_state;
	state_o: out type_state );
end component;

signal input:type_state;
signal output:type_state;

begin

Shift_Row: shift_rows port map(
state_i => input,
state_o => output
);

input <= ((X"bf",X"40",X"a3",X"9e"),(X"81",X"f3",X"d7",X"fb"),(X"7c",X"e3"
,X"11",X"39"),(X"82",X"9b",X"2f",X"ff"));

end Shift_Rows_tb_arch;

