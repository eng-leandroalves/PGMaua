----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2015 20:40:27
-- Design Name: 
-- Module Name: Aula4Display7 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 

--configuração padrão de um display

--          

--  0 = '00000000'              a
--  1 = '00000000'           -------
--  2 = '00000000'          |       |
--  3 = '00000000'         f|   g   |b
--  4 = '00000000'          |-------|
--  5 = '00000000'          |       |
--  6 = '00000000'         e|   d   |c
--  7 = '00000000'           -------
--  8 = '00000000'          
--  9 = '00000000'       
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity SS_controller is
generic(
fclk : natural := 100; -- frequencia do clk (Mhz)
f7s : natural := 100 -- frequencia de atualizacao dos displays (Hz)
);
port(
    clk : in STD_LOGIC;
    btnCpuReset : in STD_LOGIC;
    led : out STD_LOGIC_VECTOR (15 downto 0);
    seg : out STD_LOGIC_VECTOR (6 downto 0);
    an : out STD_LOGIC_VECTOR (7 downto 0) := X"00";
    dp : out STD_LOGIC
);
end SS_controller;

ARCHITECTURE rtl OF SS_controller IS
-- Constantes que definem o valor mostrado no display
constant SS0_valor : integer range 0 to 9 := 0;
constant SS1_valor : integer range 0 to 9 := 1;
constant SS2_valor : integer range 0 to 9 := 2;
constant SS3_valor : integer range 0 to 9 := 3;
constant SS4_valor : integer range 0 to 9 := 4;
constant SS5_valor : integer range 0 to 9 := 5;
constant SS6_valor : integer range 0 to 9 := 6;
constant SS7_valor : integer range 0 to 9 := 7;
constant SS8_valor : integer range 0 to 9 := 8;
constant SS9_valor : integer range 0 to 9 := 9;

signal ss_1 : integer range 0 to 9:=2;
signal ss_2 : integer range 0 to 9:=1;

signal seg_atual : std_logic_vector(6 downto 0);
signal an_atual  : integer range 0 to 9;
signal cnt : integer range 0 to 100000000 := 0;
signal led_i : std_logic := '0';

BEGIN

process(clk, btnCpuReset)
    begin
        if(btnCpuReset = '0') then
        cnt <= 0;
        elsif(rising_edge(clk)) then
            if (cnt = 100000) then
                cnt <= 0;
                an_atual <= an_atual + 1;
            else
                cnt <= cnt + 1;
            end if;
            if (an_atual = 8) then
                an_atual <= 0;
            end if;
        end if;
    end process;

with ss_1 select
    seg_atual <=    "0111111" when 0,   --0
                    "0000110" when 1,   --1
                    "1011011" when 2,   --2
                    "1001111" when 3,   --3
                    "1100110" when 4,   --4
                    "1101101" when 5,   --5
                    "1111101" when 6,   --6
                    "0000111" when 7,   --7
                    "1111111" when 8,   --9
                    "1110011" when OTHERS;
                
with an_atual select
          an <=    "11111110" when 0,   --0
                   "11111101" when 1,   --1
                   "11111011" when 2,   --2
                   "11110111" when 3,   --3
                   "11101111" when 4,   --4
                   "11011111" when 5,   --5
                   "10111111" when 6,   --6
                   "01111111" when OTHERS;
    seg <= not seg_atual;
  
END rtl;