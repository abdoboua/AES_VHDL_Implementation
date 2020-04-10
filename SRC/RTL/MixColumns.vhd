
-- BOUAGOUN Abdellah

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity MixColumns is
port( data_i : in type_state;
      data_o : out type_state);
end entity MixColumns;

architecture MixColumns_arch of MixColumns is
component MultiplyMatrix
port(	data_i : in column_state;
	data_o : out column_state);
end component;
begin
	F0 : for i in 0 to 3 generate
		U0 : MultiplyMatrix 
		port map(
			data_i(0) => data_i(0)(i),
			data_i(1) => data_i(1)(i),
			data_i(2) => data_i(2)(i),
			data_i(3) => data_i(3)(i),
			data_o(0) => data_o(0)(i),
			data_o(1) => data_o(1)(i),
			data_o(2) => data_o(2)(i),
			data_o(3) => data_o(3)(i));
	end generate;

end architecture MixColumns_arch;

