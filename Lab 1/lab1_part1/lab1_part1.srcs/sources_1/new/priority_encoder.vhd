----------------------------------------------------------------------------------
-- Company: University of Alberta - Department of Electrical and Computer Engineering
-- Engineer: Bruce Cockburn, Chengzhang Lyu, Shyama Gandhi, Antonio Andara
-- 
-- Create Date: 09/13/2022 07:29:02 AM
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY priority_encoder_3_2 IS
    PORT ( 
        priority_in : in STD_LOGIC_VECTOR (2 DOWNTO 0);
        priority_out : out STD_LOGIC_VECTOR (1 DOWNTO 0)
        );
END priority_encoder_3_2;

ARCHITECTURE Behavioral of priority_encoder_3_2 IS
-- write your code here
BEGIN
    priority_out(1) <= priority_in(1) or priority_in(2);
    priority_out(0) <= (priority_in(0)and not priority_in(1)) or priority_in(2);
END Behavioral;