-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
-- Date        : Fri Oct  7 12:54:53 2022
-- Host        : SurfacePro running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file {C:/Users/archi/OneDrive/Desktop/ECE 410/Labs/Lab
--               1/lab1_part2/lab1_part2.sim/sim_1/synth/func/xsim/priority_encoder_tb_func_synth.vhd}
-- Design      : priority_encoder_7_3
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity priority_encoder_7_3 is
  port (
    priority_in_7_3 : in STD_LOGIC_VECTOR ( 6 downto 0 );
    priority_out_7_3 : inout STD_LOGIC_VECTOR ( 2 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of priority_encoder_7_3 : entity is true;
end priority_encoder_7_3;

architecture STRUCTURE of priority_encoder_7_3 is
  signal priority_in_7_3_IBUF : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal priority_out_7_3_IBUF : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \priority_out_7_3_OBUF[0]_inst_i_2_n_0\ : STD_LOGIC;
begin
\priority_in_7_3_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(0),
      O => priority_in_7_3_IBUF(0)
    );
\priority_in_7_3_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(1),
      O => priority_in_7_3_IBUF(1)
    );
\priority_in_7_3_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(2),
      O => priority_in_7_3_IBUF(2)
    );
\priority_in_7_3_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(3),
      O => priority_in_7_3_IBUF(3)
    );
\priority_in_7_3_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(4),
      O => priority_in_7_3_IBUF(4)
    );
\priority_in_7_3_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(5),
      O => priority_in_7_3_IBUF(5)
    );
\priority_in_7_3_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => priority_in_7_3(6),
      O => priority_in_7_3_IBUF(6)
    );
\priority_out_7_3_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => priority_out_7_3_IBUF(0),
      O => priority_out_7_3(0)
    );
\priority_out_7_3_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F400FFFF"
    )
        port map (
      I0 => priority_in_7_3_IBUF(5),
      I1 => priority_in_7_3_IBUF(4),
      I2 => priority_in_7_3_IBUF(6),
      I3 => priority_out_7_3_IBUF(2),
      I4 => \priority_out_7_3_OBUF[0]_inst_i_2_n_0\,
      O => priority_out_7_3_IBUF(0)
    );
\priority_out_7_3_OBUF[0]_inst_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF0B"
    )
        port map (
      I0 => priority_in_7_3_IBUF(1),
      I1 => priority_in_7_3_IBUF(0),
      I2 => priority_in_7_3_IBUF(2),
      I3 => priority_out_7_3_IBUF(2),
      O => \priority_out_7_3_OBUF[0]_inst_i_2_n_0\
    );
\priority_out_7_3_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => priority_out_7_3_IBUF(1),
      O => priority_out_7_3(1)
    );
\priority_out_7_3_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFEFE0E"
    )
        port map (
      I0 => priority_in_7_3_IBUF(1),
      I1 => priority_in_7_3_IBUF(2),
      I2 => priority_out_7_3_IBUF(2),
      I3 => priority_in_7_3_IBUF(5),
      I4 => priority_in_7_3_IBUF(6),
      O => priority_out_7_3_IBUF(1)
    );
\priority_out_7_3_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => priority_out_7_3_IBUF(2),
      O => priority_out_7_3(2)
    );
\priority_out_7_3_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => priority_in_7_3_IBUF(3),
      I1 => priority_in_7_3_IBUF(6),
      I2 => priority_in_7_3_IBUF(5),
      I3 => priority_in_7_3_IBUF(4),
      O => priority_out_7_3_IBUF(2)
    );
end STRUCTURE;
