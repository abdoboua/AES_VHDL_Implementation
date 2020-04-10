--BOUAGOUN Abdellah

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;

entity FSM_AES is

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

end entity FSM_AES;

architecture FSM_AES_arch of FSM_AES is

TYPE State_type IS (reset_state,key_state,idle_state,Round_0,Round_n,Round_10,done_state);  
SIGNAL current_state,next_state : State_Type;   
signal s_counter: integer range 0 to 9 :=0 ;

BEGIN 



comb0 : process ( end_key_expander_i,start_i,current_state,s_counter)
begin -- process comb0
	case current_state is

		when reset_state =>
			next_state <= key_state;

		when key_state =>
			if end_key_expander_i = '1' then
				next_state <= idle_state ;
			else next_state <= key_state ;
			end if;

		when idle_state =>
			if start_i ='0' then
				next_state <= idle_state;
			else next_state <= Round_0;
			end if;

		when Round_0 =>
			next_state <= Round_n;

		when Round_n =>
			
			if s_counter < 9 then
				next_state <= Round_n;
			else next_state <= Round_10;
			end if;

		when Round_10 =>
			next_state <= done_state;

		when done_state =>
			if start_i ='0' then
				next_state <= idle_state;
			else next_state <= done_state;
			end if;

	end case ;
end process comb0 ;



seq_0 : process (clock_i , resetb_i,s_counter )
begin -- process seq_0
	if resetb_i = '0' then
		current_state <= reset_state ;

	elsif clock_i'event and clock_i = '1' then
		current_state <= next_state ;
		case next_state is
			when Round_n => 
			s_counter <= s_counter + 1;
			when others => 
			s_counter <= 0 ;
		end case;
	end if;
end process seq_0 ;


comb1 : process ( current_state,s_counter)
begin -- process comb1

	case current_state is
		when reset_state =>
			done_o <= '0';
      			enableMixcolumns_o <= '0';
      			enableOutput_o <= '0';
      			enableRoundcomputing_o <= '0';
      			reset_key_expander_o <= '0';
      			round_key_expander_o <= "0000";
    			start_key_expander_o <= '0';
		when key_state =>
			done_o <= '0';
      			enableMixcolumns_o <= '0';
      			enableOutput_o <= '0';
      			enableRoundcomputing_o <= '0';
      			reset_key_expander_o <= '1';  
      			round_key_expander_o <= "0000";
    			start_key_expander_o <= '1';
		when idle_state =>
			done_o <= '0';
      			enableMixcolumns_o <= '0';
      			enableOutput_o <= '0';
      			enableRoundcomputing_o <= '0';
      			reset_key_expander_o <= '1';
      			round_key_expander_o <= "0000";
    			start_key_expander_o <= '0';
		when Round_0 =>
			done_o <= '0';
      			enableMixcolumns_o <= '0';
      			enableOutput_o <= '0';
      			enableRoundcomputing_o <= '0';
      			reset_key_expander_o <= '1';
      			round_key_expander_o <= "0000";
    			start_key_expander_o <= '0';
		when Round_n =>
			done_o <= '0';
      			enableMixcolumns_o <= '1';
      			enableOutput_o <= '0';
      			enableRoundcomputing_o <= '1';
      			reset_key_expander_o <= '1';
      			round_key_expander_o <= std_logic_vector(to_unsigned(s_counter,4));
    			start_key_expander_o <= '0';
		when Round_10 =>
			done_o <= '0';
      			enableMixcolumns_o <= '0';
      			enableOutput_o <= '0';
      			enableRoundcomputing_o <= '1';
      			reset_key_expander_o <= '1';
      			round_key_expander_o <= "1010";
    			start_key_expander_o <= '0';
		when done_state =>
			done_o <= '1';
      			enableMixcolumns_o <= '0';
      			enableOutput_o <= '1';
      			enableRoundcomputing_o <= '0';
      			reset_key_expander_o <= '1';
      			round_key_expander_o <= "0000";
    			start_key_expander_o <= '0';


	end case ;
end process comb1 ;
end FSM_AES_arch;



