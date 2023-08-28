
-----------------------------------------------------------------------------------------------------------
-- Company: Department of Electrical and Computer Engineering, University of Alberta
-- Engineer: S.G, B.C and Archit Sharma
--
-- Create Date: 28/09/2022 09:50:46 PM
-- Design Name:
-- Module Name: vending - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description: VENDING MACHINE - LAB 2 : ECE 410 (2022)
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--*********************************************************************************
-- The Vending Machine accepts $5, $10, $20, and $50 denominations. 
-- Items: Phone case - 10$, Earbuds - 15$
-- The current sum of the total money inserted should be displayed on the seven segment during each state of the Finite State Machine (FSM)
-- Hand over the change to the customer, and then dispense the item (phone case/ earbuds)
-- Seven segment should update the amount as the change dispenses.
----------------------------------------------------------------------------------

-- 0: ABCDEF
-- 1: BC
-- 2: ABDEG
-- 3: ABCDG
-- 4: BCEFG
-- 5: ACDFG
-- 6: ACDEFG
-- 7: ABC
-- 8: ABCDEFG
-- 9: ABCFG


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity vending_m is
  Port ( clk            : in std_logic;
         reset          : in std_logic;
         item_sel       : in std_logic;                           -- sel=0 for phone case (10 $), sel=1 for earbuds (15 $)
         coins_in       : in std_logic_vector(2 downto 0);        -- "000" - 0$, "001" - 5$, "010" - 10$, "011" - 20$ and "100" - 50$ (Use three push buttons on the board)
         change_out     : out std_logic_vector(2 downto 0);       -- changeout is displayed on three leds - "000" - 0$, "001" - 5$, "010" - 10$, "011" - 20$ and "100" - 50$
         display_sum    : out std_logic_vector(6 downto 0);       -- display the current sum of inserted money on the seven segment
         select_segment : out std_logic;                          -- select the left or right segment
         phone_case     : out std_logic;                          -- turn on the LED to dispense phone case, use the RGB led in the xdc file
         earbuds        : out std_logic);                         -- turn on the LED to dispense earbuds, use the RGB led in the xdc file
         
end vending_m;

architecture Behavioral of vending_m is

---------------------------------------------
-- clk_divider component here is used here!
-- Remember, this is used later to have the divided clock by a factor of 62500000
---------------------------------------------
component clk_divider is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end component;

component seven_segment is
    Port ( clk : in STD_LOGIC;
           val : in STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC;
           seg_lines : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal clk_o : std_logic;
type state_type is (sum_0,              -- state names represent the total sum of inserted money by the user so far
                    sum_5,         
                    sum_10,
                    sum_15,
                    sum_20,
                    sum_25,
                    sum_30,
                    sum_50,
                    sum_55,
                    sum_60,
                    dispense);

signal present_state,next_state: state_type;    -- current and next state declaration.
signal two_segment_signal : std_logic_vector(7 downto 0);

signal multipleBills : std_logic_vector(2 downto 0) := "000";   -- flag if multiple bills are needed for change_out, "000" - no other bills, 
                                                                -- "001" - last bill to dispense, "010" - $15 left to dispense, 
                                                                -- "011" - $25 left to dispense, "100" - $30 left to dispense, 
                                                                -- "101" - $50 left to dispense, "110" - $60 left to dispense

begin

    label_clk_divider: clk_divider port map(clk_in => clk, clk_out => clk_o);
    label_seven_seg: seven_segment port map(
                                   clk => clk,
                                   val => two_segment_signal,
                                   anode   => select_segment,
                                   seg_lines  => display_sum);

    process(clk,reset)
    begin
        if(reset = '1')then
        --- *** write one line of code to update the present state when reset=1 *** ---
        present_state <= sum_0;
        --- ****************************** ---
        elsif(rising_edge(clk))then
        --- *** write one line of code to update the present state *** ---
        present_state <= next_state;
        --- ****************************** ---
        end if;
    end process;

    process(present_state,coins_in,item_sel)
        begin
        case present_state is
            when sum_0 =>
                phone_case <= '0';
                earbuds <= '0';
                change_out <= "000";
                multipleBills <= "000";

                -- Explanation:
                --*** Remember, the seven segment file is written in such a way that both the left and right segment are working almost simultaneously (i.e., 3 ms switching rate)
                --*** To display say, 50 on the segments, you need to pass "0101 0000" to the 'two_segment_signal' input signal declared for you!
                --*** To display say, 25, you need to pass the value "0010 0101". It should be clear by now that you pass the binary of 2 and 5!!!
                --*** This is because the seven segment code is designed in such a way!
                
                two_segment_signal <= "00000000";

                -- you may use any conditional assignment format
                -- based on the inserted coins, update the next state
                if(coins_in="000")then       -- nothing inserted
                    next_state <= sum_0;
                elsif(coins_in="001")then    -- again 5$ inserted
                    next_state <= sum_5;
                elsif(coins_in="010")then    -- again 10$ inserted
                    next_state <= sum_10;
                elsif(coins_in="011")then    -- again 20$ inserted
                    next_state <= sum_20;
                elsif(coins_in="100")then    -- again 50$ inserted
                    next_state <= sum_50;
                end if;

            -- COMPLETE THE REMAINING STATES!!!
            -- Remember, when you reach or exceed the required sum of money for a product, give the change and then dispense the product.
            -- For example: you input 5$ and then 20$ for phone case (10$). So, the state machine, first goes to sum5 and then again 20$ takes it to sun_25 state!
            -- Now, you are suppose to give out a change of 10$ to the customer and then dispense the product.
            -- So, from the state sum_25, there will be a state transition to say sum_(z) where 'z' denotes a state less than sum_25! Meaning, once you are in state sum_25, the change will be handed
            -- either in the same state or in the state sum_z. Thereafter, the final state "dispense" will be executed that dispenses the phone case......
                                        
            when sum_5 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "00000101";
            
                if(coins_in="000")then       -- nothing inserted
                    if (multipleBills = "001") then
                        change_out <= "001";
                        multipleBills <= "000";
                        next_state <= dispense;
                    else
                        change_out <= "000";
                        multipleBills <= "000";
                        next_state <= sum_5;
                    end if;
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_10;
                elsif(coins_in="010")then    -- 10$ inserted
                    next_state <= sum_15;
                elsif(coins_in="011")then    -- 20$ inserted
                    next_state <= sum_25;
                elsif(coins_in="100")then    -- 50$ inserted
                    next_state <= sum_55;
                end if;
            
            when sum_10 =>
            
                phone_case <= '0';
                earbuds <= '0';
                
                two_segment_signal <= "00010000";
            
                if(coins_in="000")then       -- nothing inserted
                    if (multipleBills = "010") then
                        change_out <= "010";
                        multipleBills <= "001";
                        next_state <= sum_5;
                    elsif (multipleBills = "011") then
                        change_out <= "011";
                        multipleBills <= "001";
                        next_state <= sum_5;
                    elsif (item_sel = '0') then
                        change_out <= "000";
                        multipleBills <= "000";
                        next_state <= dispense;
                    else
                        change_out <= "000";
                        multipleBills <= "000";
                        next_state <= sum_10;
                    end if;    
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_15;
                elsif(coins_in="010")then    -- 10$ inserted
                    next_state <= sum_20;
                elsif(coins_in="011")then    -- 20$ inserted
                    next_state <= sum_30;
                elsif(coins_in="100")then    -- 50$ inserted
                    next_state <= sum_60;
                end if;
            
            when sum_15 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "00010101";
            
                if(coins_in="000")then       -- nothing inserted
                    if (item_sel = '0') then
                        change_out <= "001";
                    else
                        change_out <= "000";
                    end if;
                    multipleBills <= "000";
                    next_state <= dispense;
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_20;
                elsif(coins_in="010")then    -- 10$ inserted
                    next_state <= sum_25;
                end if;
            
            when sum_20 =>
            
                phone_case <= '0';
                earbuds <= '0';
                
                two_segment_signal <= "00100000";
            
                if(coins_in="000")then       -- nothing inserted
                    
                    if ((item_sel = '0' or item_sel = '1') and multipleBills = "011") then
                        change_out <="011";
                        multipleBills <= "001";
                        next_state <= sum_5;
                    elsif ((item_sel = '0' or item_sel = '1') and multipleBills = "001") then
                        change_out <= "011";
                        multipleBills <= "000";
                        next_state <= dispense;
                    elsif (item_sel = '0' and multipleBills = "000") then
                        change_out <= "010";
                        next_state <= dispense;
                    elsif (item_sel = '1' and multipleBills = "000") then
                        change_out <= "001";
                        next_state <= dispense;
                    end if;
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_25;
                elsif(coins_in="010")then    -- 10$ inserted
                    next_state <= sum_30;
                end if;
            
            when sum_25 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "00100101";
            
                if(coins_in="000")then       -- nothing inserted
                    if (item_sel = '0') then
                        change_out <= "010";
                        multipleBills <= "001";
                        next_state <= sum_5;
                    else
                        change_out <= "010";
                        next_state <= dispense;
                    end if;
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_30;
                end if;
            
            when sum_30 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "00110000";
                
                if(coins_in="000")then       -- nothing inserted
                    if (item_sel = '0') then
                        change_out <= "011";
                        multipleBills <= "000";
                        next_state <= dispense;
                    else
                        change_out <= "010";
                        multipleBills <= "001";
                        next_state <= sum_20;
                    end if;
                elsif(coins_in="011")then    -- 20$ inserted
                    next_state <= sum_50;
                end if;
            
            when sum_50 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "01010000";
                
                if(coins_in="000")then       -- nothing inserted
                    if (item_sel = '0') then
                        change_out <= "011";
                        multipleBills <= "001";
                        next_state <= sum_20;
                    else
                        multipleBills <= "010";
                        change_out <= "011";
                        next_state <= sum_30;
                    end if;
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_55;
                elsif(coins_in="010")then    -- 10$ inserted
                    next_state <= sum_60;
                end if;
            
            when sum_55 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "01010101";
                
                if(coins_in="000")then       -- nothing inserted
                    if (item_sel = '0') then
                        change_out <= "011";
                        multipleBills <= "011";
                        next_state <= sum_20;
                    else
                        change_out <= "011";
                        multipleBills <= "001";
                        next_state <= sum_20;
                    end if;
                elsif(coins_in="001")then    -- 5$ inserted
                    next_state <= sum_60;
                end if;
                
            when sum_60 =>
            
                phone_case <= '0';
                earbuds <= '0';
            
                two_segment_signal <= "01100000";
                
                if(coins_in="000")then       -- nothing inserted
                    if (item_sel = '0') then
                        change_out <= "100";
                        multipleBills <= "000";
                        next_state <= dispense;
                    else
                        change_out <= "011";
                        multipleBills <= "011";
                        next_state <= sum_20;
                    end if;
                end if;
            
            when dispense =>
                change_out <= "000";
                two_segment_signal <= "00000000";

                if(item_sel='0')then
                    phone_case <= '1';
                    earbuds <= '0';
                else
                    phone_case <= '0';
                    earbuds <= '1';
                end if;

                next_state <= sum_0;

            end case;
    end process;
end Behavioral;
