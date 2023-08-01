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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY priority_encoder_tb IS
--  Port ( );
END priority_encoder_tb;

ARCHITECTURE Behavioral OF priority_encoder_tb IS

    --Setting IO for entity
    component priority_encoder_7_3
    PORT ( 
--        priority_in : in STD_LOGIC_VECTOR (6 DOWNTO 0);
--        priority_out : out STD_LOGIC_VECTOR (2 DOWNTO 0)
        priority_in_7_3 : in STD_LOGIC_VECTOR (6 DOWNTO 0);
        priority_out_7_3 : inout STD_LOGIC_VECTOR (2 DOWNTO 0)        
        );
    end component;
    
    --Input Signals
    signal p_in: std_logic_vector (6 downto 0) := "0000000";
        
    --Output
    signal p_out: std_logic_vector(2 downto 0) := "000";
    
begin
    --Mapping testbench to entity
    encoder_io:
        priority_encoder_7_3 port map(
--            priority_in(6 downto 0) => p_in(6 downto 0),
--            priority_out(2 downto 0) => p_out(2 downto 0)        
            priority_in_7_3(6 downto 0) => p_in(6 downto 0),
            priority_out_7_3(2 downto 0) => p_out(2 downto 0)
        );


--Stimulus process
    encoder_test:
        process
        begin
        
            p_in(6 downto 0) <= "0000000";
            wait for 10ns;
            
            testLoop : for i in 0 to 128 loop
                p_in(6 downto 0) <= std_logic_vector( unsigned(p_in(6 downto 0)) +1);
                wait for 10ns;
            end loop testLoop;
        wait;
        end process;

END BEHAVIORAL;