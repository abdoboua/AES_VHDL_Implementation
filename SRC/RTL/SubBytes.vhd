
-- BOUAGOUN Abdellah

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity SubBytes is
  port ( input_i : in type_state;  
       output_o: out type_state ); 
end SubBytes; 
 
architecture SubBytes_arch of SubBytes is 

component sbox
port ( entree_i : in bit8;  
       sortie_o: out bit8 );
end component;

begin

a:for i in 0 to 3 generate
	b:for j in 0 to 3 generate
		Box: sbox port map(entree_i => input_i(i)(j),sortie_o => output_o(i)(j));
	end generate b;
end generate a;

end SubBytes_arch ;
