
-- BOUAGOUN Abdellah

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity AESRound is

port( clock_i : in std_logic;
      currentkey_i:in bit128;
      resetb_i: in std_logic ;
      text_i: in bit128;
      enableMixcolumns_i: in std_logic ;
      enableRoundcomputing_i: in std_logic;
      data_o: out bit128
     );

end entity AESRound;

architecture AESRound_arch of AESRound is

component SubBytes
port ( input_i : in type_state;  
       output_o: out type_state );
end component;

component shift_rows is
  port ( 
	state_i: in type_state;
	state_o: out type_state );
end component;

component add_round_key is

  port ( 
	a_i: in type_state;
	round_key_i: in type_state;
	a_o: out type_state );
end component;

component MixColumns is
port( data_i : in type_state;
      data_o : out type_state);
end component;

signal input_sb: type_state;
signal sb_sr: type_state;
signal sr_mx:type_state;
signal mx_mux: type_state;
signal bet_mux:type_state;
signal mux_ak: type_state;
signal bef_out,out1: type_state;
signal fin: type_state;
signal new_text: type_state;
signal key_type_state : type_state;
begin

-- convert text_i to type_state
process(text_i)
begin

	for l in 0 to 3 loop
		for c in 0 to 3 loop 
			new_text(l)(c) <= text_i((127-32*c -8*l) downto (127-32*c-(8*l)-7));
		end loop;
	end loop;
end process;

-- convert current_key_i to type_state
process(currentkey_i)
begin
	for l in 0 to 3 loop
		for c in 0 to 3 loop 
			key_type_state(l)(c) <= currentkey_i((127-32*c -8*l) downto (127-32*c-(8*l)-7));
		end loop;
	end loop;
end process;

--convert type_state to bit128
process(fin)
begin
	for l in 0 to 3 loop
		for c in 0 to 3 loop 
			data_o((127-32*c -8*l) downto (127-32*c-(8*l)-7)) <= fin(l)(c) ;
		end loop;
	end loop;
end process;


input_sb <= fin;

SB: SubBytes port map (input_i => input_sb,
                       output_o => sb_sr);

SR: shift_rows port map (state_i => sb_sr,
                         state_o => sr_mx);

MX: MixColumns port map (data_i => sr_mx,
                         data_o=> mx_mux
                         );

bet_mux <= mx_mux when enableMixcolumns_i ='1' else sr_mx;
mux_ak  <= bet_mux when enableRoundcomputing_i='1' else new_text;

AK: add_round_key port map (a_i => mux_ak,
                            round_key_i => key_type_state,
                            a_o => bef_out);


process(clock_i,resetb_i,bef_out)
begin
	if resetb_i ='0' then 
		fin <=((X"00",X"00",X"00",X"00"),(X"00",X"00",X"00",X"00"),(X"00",X"00",X"00",X"00"),(X"00",X"00",X"00",X"00"));
	
	elsif (rising_edge(clock_i)) then
	fin <= bef_out;
	end if;
end process;

end AESRound_arch;





