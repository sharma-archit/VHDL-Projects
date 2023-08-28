----------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: S.G, B.C, and Archit Sharma
-- 
---- Create Date: 28/09/2022 04:52:32 PM
---- Design Name: 
-- Module Name: seq_fsm_tb - Behavioral
-- Project Name: 
-- Target Devices: Zybo Z7-10 
-- Tool Versions: 
-- Description: SEQUENCE DETECTOR : 11011 - OVERLAPPING CASE : MEALY FSM
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq_fsm_tb is
end seq_fsm_tb;

architecture Behavioral of seq_fsm_tb is
    
component seq_fsm is 
Port (clk           : in std_logic;
      reset         : in std_logic;
      seq_in        : in std_logic;
      output_detect : out std_logic);
end component;

signal clk_design : std_logic;
signal rst        : std_logic;
signal sequence_in      : std_logic := '0';
signal fsm_detector_out : std_logic;
constant clk_period : time := 40ns;

signal testSequence: std_logic_vector (0 to 22) := "00001000101010100010001"; 

begin
    --*** add the design lines to port map the entity here
    FSM_SEQ : seq_fsm port map (seq_in => sequence_in,
                                reset => rst,
                                output_detect => fsm_detector_out,
                                clk => clk_design);
    --*** end design lines
   clk_process :process
   begin
        clk_design <= '0';
        wait for clk_period/2;  
        clk_design <= '1';
        wait for clk_period/2;  
   end process;
    
    stim_proc: PROCESS
    begin
    
    -- old test sequence : "0110101"
    rst <= '1';
    wait for clk_period;
    rst <= '0';
    wait for clk_period;
    
    testLoop: for i in 0 to testSequence'length loop
        sequence_in <= testSequence(i);
        wait for clk_period;
    end loop testLoop;
    
    wait;
    end process;
end Behavioral;
