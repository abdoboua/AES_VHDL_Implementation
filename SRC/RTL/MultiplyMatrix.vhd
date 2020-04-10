

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity MultiplyMatrix is
port(   data_i : in column_state;
        data_o : out column_state);
end MultiplyMatrix;

architecture MultiplyMatrix_arch of MultiplyMatrix is
signal col1_s : column_state;
signal col2_s : column_state;
begin
	x : for i in 0 to 3 generate
		col1_s(i) <= (data_i(i)(6 downto 0) & '0') xor "00011011" when data_i(i)(7) = '1'  
                              else data_i(i)(6 downto 0) & '0';
	end generate;

	y: for i in 0 to 3 generate
		col2_s(i) <= col1_s(i) xor data_i(i);
	end generate;

	data_o(0) <= col1_s(0) xor col2_s(1) xor data_i(2) xor data_i(3);
	data_o(1) <= data_i(0) xor col1_s(1) xor col2_s(2) xor data_i(3);
	data_o(2) <= data_i(0) xor data_i(1) xor col1_s(2) xor col2_s(3);
	data_o(3) <= col2_s(0) xor data_i(1) xor data_i(2) xor col1_s(3);
end architecture MultiplyMatrix_arch;


