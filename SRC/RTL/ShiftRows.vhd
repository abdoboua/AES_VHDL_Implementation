


-- ABDELLAH BOUAGOUN 
-- ShiftRows Design

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity shift_rows is
  port ( 
	state_i: in type_state;
	state_o: out type_state

 ); 
end shift_rows; 
 
architecture shift_rows_arch of shift_rows is 

begin

process(state_i)
begin

		state_o(0) <=state_i(0);
	
		state_o(1)(3)<=state_i(1)(0);
		a:
		for i in 0 to 2 loop
			state_o(1)(i)<=state_i(1)(i+1);
		end loop a;
	

		state_o(2)(2)<=state_i(2)(0);
		state_o(2)(3)<=state_i(2)(1);
		b:
		for i in 0 to 1 loop
			state_o(2)(i)<=state_i(2)(i+2);
		end loop b;
		
		state_o(3)(0)<=state_i(3)(3);
		c:
		for i in 1 to 3 loop
			state_o(3)(i)<=state_i(3)(i-1);
		end loop c;

end process;

end shift_rows_arch;

