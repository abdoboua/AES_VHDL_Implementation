
-- BOUAGOUN Abdellah

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity AES_Top is

port( clock_i : in std_logic;
      key_i:in bit128;
      reset_i: in std_logic ;
      start_i: in std_logic;
      data_i: in bit128;
      aes_on_o: out std_logic ;
      data_o: out bit128 );

end entity AES_Top;

architecture AES_Top_arch of AES_Top is

component KeyExpansion_I_O_table is
  port (key_i           : in  bit128;
        clock_i         : in  std_logic;
        reset_i         : in  std_logic;
        start_i         : in  std_logic;
        round_i         : in  bit4;
        end_o           : out std_logic;
        expansion_key_o : out bit128);
end component KeyExpansion_I_O_table;

component FSM_AES is

port( clock_i : in std_logic;
      end_key_expander_i:in std_logic;
      resetb_i: in std_logic ;
      start_i: in std_logic;
      done_o: out std_logic;
      enableMixcolumns_o: out std_logic ;
      enableOutput_o: out std_logic;
      enableRoundcomputing_o: out std_logic;
      reset_key_expander_o:out std_logic;
      round_key_expander_o: out std_logic_vector(3 downto 0);
      start_key_expander_o:out std_logic );

end component FSM_AES;


component AESRound is

port( clock_i : in std_logic;
      currentkey_i:in bit128;
      resetb_i: in std_logic ;
      text_i: in bit128;
      enableMixcolumns_i: in std_logic ;
      enableRoundcomputing_i: in std_logic;
      data_o: out bit128
     );

end component AESRound;

signal reset_s:std_logic;
signal not_reset:std_logic;
signal start_s:std_logic;
signal round_s: std_logic_vector(3 downto 0);
signal end_s:std_logic;
signal key_s: bit128;
signal enMC:std_logic;
signal enRC:std_logic;
signal enO:std_logic;
signal data_s:bit128;

begin

not_reset <= not reset_i;

key_expansion: KeyExpansion_I_O_table port map ( key_i => key_i,
        					 clock_i => clock_i,
       						 reset_i => reset_s,
        					 start_i=> start_s,
        					 round_i => round_s,
        					 end_o => end_s,
        					 expansion_key_o => key_s);

fsm: FSM_AES port map ( clock_i => clock_i,
      			end_key_expander_i =>end_s,
      			resetb_i => not_reset,
      			start_i =>start_i,
      			done_o =>aes_on_o,
      			enableMixcolumns_o =>enMC,
      			enableOutput_o => enO,
      			enableRoundcomputing_o =>enRC ,
      			reset_key_expander_o => reset_s, 
      			round_key_expander_o =>round_s,
      			start_key_expander_o =>start_s);

round: AESRound port map ( clock_i => clock_i,
      			    currentkey_i => key_s,
     			    resetb_i => not_reset,
      			    text_i => data_i,
      			    enableMixcolumns_i => enMC,
      			    enableRoundcomputing_i => enRC,
      			    data_o => data_s);


process(data_s, enO)
	begin
	   if (enO'event and enO = '1') then
	       data_o <= data_s;
	   end if;
	end process;


end AES_Top_arch;
