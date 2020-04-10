
--BOUAGOUN Abdellah

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity AESRound_tb is
end AESRound_tb;

architecture AESRound_tb_arch of AESRound_tb is

component AESRound
port (clock_i : in std_logic;
      currentkey_i:in bit128;
      resetb_i: in std_logic ;
      text_i: in bit128;
      enableMixcolumns_i: in std_logic ;
      enableRoundcomputing_i: in std_logic;
      data_o: out bit128 );
end component;

 signal enMC:std_logic;
 signal key: bit128 ;
 signal rst: std_logic;
 signal txt: bit128;
 signal enRK: std_logic ;
 signal dt: bit128;
 


signal  clock : std_logic := '0';

begin

round : AESRound port map(
      clock_i => clock,
      currentkey_i => key ,
      resetb_i => rst,
      text_i => txt,
      enableMixcolumns_i => enMC,
      enableRoundcomputing_i => enRK,
      data_o => dt
);


P: process
	begin
	clock <= '1' after 100 ns,'0' after 200 ns,'1' after 300 ns ;
	rst <=  '1';
	enMC <= '0', '1' after 200 ns ;
	enRK <=  '0','1' after 200 ns;
	
	key <= x"2b7e151628aed2a6abf7158809cf4f3c", X"75ec78565d42aaf0f6b5bf78ff7af044" after 200 ns;
	txt <= x"526573746f20656e2076696c6c65203f";
	
	wait;
end process P;

end AESRound_tb_arch;
