-- BOUAGOUN Abdellah

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
library LIB_AES;
use LIB_AES.crypt_pack.all;
library LIB_RTL;
use LIB_RTL.all;

entity AES_Top_tb is
end AES_Top_tb;

architecture AES_Top_tb_arch of AES_Top_tb is

component AES_Top
port (clock_i : in std_logic;
      key_i:in bit128;
      reset_i: in std_logic ;
      start_i: in std_logic;
      data_i: in bit128;
      aes_on_o: out std_logic ;
      data_o: out bit128 );
end component;


 signal output :bit128;
 signal key: bit128 ;
 signal rst: std_logic;
 signal txt: bit128;
 signal start_s: std_logic ;
 signal aes_on_s : std_logic;
 signal  clock : std_logic := '0';
 constant num_cycles : integer := 30;
begin

round : AES_Top port map(
      clock_i =>clock,
      key_i =>key,
      reset_i =>rst,
      start_i =>start_s,
      data_i =>txt,
      aes_on_o =>aes_on_s,
      data_o =>output
);

a:for i in 1 to num_cycles generate
     clock <= not clock after 5 ns;
 end generate;

rst <= '1','0' after 3 ns;
start_s <= '0', '1' after 18 ns ;
	
key <= X"2b7e151628aed2a6abf7158809cf4f3c";
txt <= x"526573746f20656e2076696c6c65203f";  

end AES_Top_tb_arch;
