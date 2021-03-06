


-- ABDELLAH BOUAGOUN 
-- AddRoundKey Design

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity add_round_key is

  port ( 
	a_i: in type_state;
	round_key_i: in type_state;
	a_o: out type_state

 ); 
end add_round_key; 
 
architecture ARK_arch of add_round_key is 

begin

process(a_i,round_key_i)

begin 
a:for i in 0 to 3 loop
	b:for j in 0 to 3 loop
	a_o(i)(j) <= round_key_i(i)(j) xor a_i(i)(j);
	end loop b;
end loop a;

end process;
end ARK_arch;
