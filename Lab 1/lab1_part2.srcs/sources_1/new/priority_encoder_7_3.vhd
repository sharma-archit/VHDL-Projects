----------------------------------------------------------------------------------
-- Company: University of Alberta - Department of Electrical and Computer Engineering
-- Engineer: Bruce Cockburn, Chengzhang Lyu, Shyama Gandhi, Antonio Andara
-- 
-- Create Date: 09/13/2022 07:38:18 AM
-- Design Name: 
-- Module Name: priority_encoder - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY priority_encoder_7_3 IS

    PORT ( 
--        priority_in : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
--        priority_out : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        priority_in_7_3 : IN STD_LOGIC_VECTOR (6 DOWNTO 0);
        priority_out_7_3 : INOUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );

END priority_encoder_7_3;

ARCHITECTURE Behavioral of priority_encoder_7_3 IS

    --Creating signals for outputs of the 3:2 priority encoder
    signal priority_3_2Top: std_logic_vector (1 downto 0) := "00";
    signal priority_3_2Bottom: std_logic_vector (1 downto 0) := "00";
    --Temporary signal for one of the 7:3 priority encoder output
    signal prioritySelector: std_logic := '0';

BEGIN   

--    priority_out(2) <= priority_in(4) or priority_in(5) or priority_in(6) or priority_in(3);
--    priority_out(1) <= ((not(priority_in(4)) and (not(priority_in(3)))) and (priority_in(1) or priority_in(2))) or priority_in(5) or priority_in(6);
--    priority_out(0) <= priority_in(6) or (not priority_in(5) and priority_in(4)) or (not priority_in(5) and not priority_in(3) and priority_in(2)) or (not priority_in(5) and not priority_in(3) and not priority_in(1) and priority_in(0));

    --Creating two instances of the 3:2 priority encoder and mapping their outputs to the inputs of this design
    priorityEncoderTop: entity work.priority_encoder_3_2(Behavioral) port map ( priority_in => priority_in_7_3 (6 downto 4), priority_out => priority_3_2Bottom);
    priorityEncoderBottom: entity work.priority_encoder_3_2(Behavioral) port map (priority_in => priority_in_7_3 (2 downto 0), priority_out => priority_3_2Top);
    --Calculating the value of one of the outputs of the 7:3 priority encoder
    prioritySelector <= priority_in_7_3(3) or priority_in_7_3(4) or priority_in_7_3(5) or priority_in_7_3(6);
    priority_out_7_3(2) <= prioritySelector;
    
    --Checking the value of the second output fromt he 7:3 priority encoder to determine which 3:2 priority encoder has the correspoinding output
    check: process
    begin
        if (prioritySelector = '0') then
            priority_out_7_3 (1 downto 0) <= priority_3_2Top;
        else --elseif (prioritySelector = '1') then
            priority_out_7_3 (1 downto 0) <= priority_3_2Bottom;
        end if;
        wait;
        
    end process;

END Behavioral;