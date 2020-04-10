
--BOUAGOUN Abdellah

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity SubBytes_tb is
end SubBytes_tb;

architecture SubBytes_tb_arch of SubBytes_tb is

component SubBytes
port ( input_i : in type_state;  
       output_o: out type_state );
end component;

signal input:type_state;
signal output:type_state;

begin

substitution : SubBytes port map(
input_i => input,
output_o => output
);

input <= ((X"01",X"02",X"03",X"04"),(X"05",X"06",X"07",X"08"),(X"09",X"0A",X"0B",X"0C"),(X"AB",X"FC",X"AD",X"EA")) ;

end SubBytes_tb_arch;

