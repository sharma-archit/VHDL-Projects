----------------------------------------------------------------------------------
-- Company: University of Alberta - Department of Electrical and Computer Engineering
-- Engineer: Bruce Cockburn, Chengzhang Lyu, Shyama Gandhi, Antonio Andara
-- 
-- Create Date: 09/13/2022 07:35:27 AM
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

ENTITY priority_encoder_tb IS
--  Port ( );
END priority_encoder_tb;

ARCHITECTURE Behavioral OF priority_encoder_tb IS

    --Setting 
    component priority_encoder_3_2
    PORT ( 
        priority_in : in STD_LOGIC_VECTOR (2 DOWNTO 0);
        priority_out : out STD_LOGIC_VECTOR (1 DOWNTO 0)
        );
    end component;
    
    --Input Signals
    signal p_in: std_logic_vector (2 downto 0) := "000";
        
    --Output
    signal p_out: std_logic_vector(1 downto 0) := "00";
    
begin
    --Instantiate component
    encoder_io:
        priority_encoder_3_2 port map(
            priority_in(2 downto 0) => p_in(2 downto 0),
            priority_out(1 downto 0) => p_out(1 downto 0)
        );


--Stimulus process
    encoder_test:
        process
        begin
                p_in(2 downto 0) <= "000";
                wait for 40ns;
                
                p_in(2 downto 0) <= "001";
                wait for 40ns;
                
                p_in(2 downto 0) <= "010";
                wait for 40ns;
                
                p_in(2 downto 0) <= "011";
                wait for 40ns;
                
                p_in(2 downto 0) <= "100";
                wait for 40ns;
                
                p_in(2 downto 0) <= "101";
                wait for 40ns;
                
                p_in(2 downto 0) <= "110";
                wait for 40ns;
                
                p_in(2 downto 0) <= "111";
                wait;
                wait;
                
        end process;

END BEHAVIORAL;