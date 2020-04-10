
--BOUAGOUN Abdellah

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity FSM_AES_tb is
end FSM_AES_tb;

architecture FSM_AES_tb_arch of FSM_AES_tb is

component FSM_AES
port (clock_i : in std_logic;
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
end component;

 signal key:std_logic;
 signal rst: std_logic ;
 signal start: std_logic;
 signal done: std_logic;
 signal enMC: std_logic ;
 signal enO: std_logic;
 signal enRC: std_logic;
 signal rst_key_expander: std_logic;
 signal round: std_logic_vector(3 downto 0);
 signal start_key_expander: std_logic;

 constant num_cycles : integer := 30;
 signal  clock : std_logic := '0';

begin

fsm : FSM_AES port map(
      clock_i => clock,
      end_key_expander_i => key ,
      resetb_i => rst,
      start_i => start,
      done_o => done,
      enableMixcolumns_o => enMC,
      enableOutput_o => enO,
      enableRoundcomputing_o => enRC,
      reset_key_expander_o => rst_key_expander,
      round_key_expander_o => round,
      start_key_expander_o => start_key_expander
);

key <= '0','1' after 12 ns, '0' after 17 ns;
rst <= '0','1' after 3 ns;
start <= '0','1' after 17 ns, '0' after 140 ns,'1' after 150 ns;
 
 a:for i in 1 to num_cycles generate
     clock <= not clock after 5 ns;
 end generate;


end FSM_AES_tb_arch;

