----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2015 20:52:02
-- Design Name: 
-- Module Name: Aula4 - Behavioral
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
----------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

ENTITY aula4 IS
    PORT(
            -- Clk e rst
            clk : in std_logic; -- 100Mhz
            btnCpuReset   : in std_logic; -- RST em '0'
            -- IOs
            sw : in std_logic_vector(15 downto 0);
            led : out std_logic_vector(15 downto 0)
        );
END aula4;

ARCHITECTURE bhv OF aula4 IS

signal in_mux : std_logic_vector (2 downto 0);
signal ss_mux : std_logic_vector (1 downto 0);
signal out_mux1 : std_logic;
signal out_mux2 : std_logic;

BEGIN
--sequencial   
mux: process(ss_mux, in_mux)
    begin
       if(ss_mux = "00") then
            out_mux1 <= sw(0);
        elsif(ss_mux = "01") then
            out_mux1 <= in_mux(1);
        else
            out_mux1 <= in_mux(2);
       end if;    
    end process;
    
    process(ss_mux, in_mux)
    begin
           case ss_mux is
            when "00" =>
                    out_mux2 <= in_mux(0);
            when "01" =>
                    out_mux2 <= in_mux(1);
            when OTHERS =>
                    out_mux2 <= in_mux(2);
           end case;    
    end process;
    
    -- operações concorrentes
    ss_mux <= sw(4 downto 3);
    in_mux <= sw(2 downto 0);
    led(0) <= out_mux1;
    led(15) <= out_mux2;
END bhv;
