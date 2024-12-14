library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu_tester is
    port (
        o_clk : out std_logic;
        o_rst : out std_logic;
        o_first_operand, o_second_operand : out std_logic_vector(31 downto 0);
        o_manage : out std_logic_vector(16 downto 0)
    );
end entity alu_tester;

architecture alu_tester_arch of alu_tester is

    constant ADDI_OP   : std_logic_vector := "00000000000010011";
    constant SLTI_OP   : std_logic_vector := "00000000100010011";
    constant SLTIU_OP  : std_logic_vector := "00000000110010011";
    constant XORI_OP   : std_logic_vector := "00000001000010011";
    constant ORI_OP    : std_logic_vector := "00000001100010011";
    constant ANDI_OP   : std_logic_vector := "00000001110010011";
    constant SLLI_OP   : std_logic_vector := "00000000010010011";
    constant SRLI_OP   : std_logic_vector := "00000001010010011";
    constant SRAI_OP   : std_logic_vector := "01000001010010011";

    constant ADD_OP    : std_logic_vector := "00000000000110011";
    constant SUB_OP    : std_logic_vector := "01000000000110011";
    constant SLL_OP    : std_logic_vector := "00000000010110011";
    constant SLT_OP    : std_logic_vector := "00000000100110011";
    constant SLTU_OP   : std_logic_vector := "00000000110110011";
    constant XOR_OP    : std_logic_vector := "00000001000110011";
    constant SRL_OP    : std_logic_vector := "00000001010110011";
    constant SRA_OP    : std_logic_vector := "01000001010110011";
    constant OR_OP     : std_logic_vector := "00000001100110011";
    constant AND_OP    : std_logic_vector := "00000001110110011";
    constant MUL_OP    : std_logic_vector := "00000011000110011";
    constant MULH_OP   : std_logic_vector := "00000011010110011";
    constant MULHSU_OP : std_logic_vector := "00000010100110011";
    constant MULHU_OP  : std_logic_vector := "00000010110110011";
    
    constant clk_period : time := 10 ns;
    signal clk : std_logic := '1';

begin
    
    clk <= not clk after clk_period / 2;
    o_clk <= clk;
    process
    begin
        o_rst <= '1';
        wait for clk_period;
        o_rst <= '0';

        -- arithmetic tests

        o_first_operand <= x"00000005"; -- +5
        o_second_operand <= x"00000008"; -- +8
        o_manage <= ADD_OP;
        wait for clk_period;
        o_manage <= SUB_OP;
        wait for clk_period;
        o_manage <= ADDI_OP;
        wait for clk_period;
        
        o_first_operand <= x"FFFFFFFB"; -- -5
        o_second_operand <= x"00000008"; -- +8
        o_manage <= ADD_OP;
        wait for clk_period;
        o_manage <= SUB_OP;
        wait for clk_period;
        o_manage <= ADDI_OP;
        wait for clk_period;

        o_first_operand <= x"00000005"; -- +5
        o_second_operand <= x"FFFFFFF8"; -- -8
        o_manage <= ADD_OP;
        wait for clk_period;
        o_manage <= SUB_OP;
        wait for clk_period;
        o_manage <= ADDI_OP;
        wait for clk_period;

        o_first_operand <= x"FFFFFFFB"; -- -5
        o_second_operand <= x"FFFFFFF8"; -- -8
        o_manage <= ADD_OP;
        wait for clk_period;
        o_manage <= SUB_OP;
        wait for clk_period;
        o_manage <= ADDI_OP;
        wait for clk_period;

        -- shift tests

        o_first_operand <= x"00001000";
        o_second_operand <= x"00000010"; -- сдвиг на 16 двоичных бит, или на 4 шестнадцатиричных 
        o_manage <= SLL_OP;
        wait for clk_period;
        o_manage <= SLLI_OP;
        wait for clk_period;
        o_manage <= SRL_OP;
        wait for clk_period;
        o_manage <= SRLI_OP;
        wait for clk_period;
        o_manage <= SRA_OP;
        wait for clk_period;
        o_manage <= SRAI_OP;
        wait for clk_period;
        o_first_operand <= x"80000000"; -- отрицательное число
        o_manage <= SRA_OP;
        wait for clk_period;
        o_manage <= SRAI_OP;
        wait for clk_period;

        -- compare test

        o_first_operand <= x"00000010"; -- +16
        o_second_operand <= x"00000001"; -- +1
        o_manage <= SLT_OP;
        wait for clk_period;
        o_manage <= SLTU_OP;
        wait for clk_period;
        o_manage <= SLTI_OP;
        wait for clk_period;
        o_manage <= SLTIU_OP;
        wait for clk_period;

        o_first_operand <= x"00000001"; -- +1
        o_second_operand <= x"00000010"; -- +16
        o_manage <= SLT_OP;
        wait for clk_period;
        o_manage <= SLTU_OP;
        wait for clk_period;
        o_manage <= SLTI_OP;
        wait for clk_period;
        o_manage <= SLTIU_OP;
        wait for clk_period;

        o_first_operand <= x"FFFFFFF0"; --  -0000002(-2)       /FFFFFFF0(+286331152)
        o_second_operand <= x"F0000001"; -- -FFFFFF1(-17895697)/F0000001(+268435457)
        o_manage <= SLT_OP;
        wait for clk_period;
        o_manage <= SLTU_OP;
        wait for clk_period;
        o_manage <= SLTI_OP;
        wait for clk_period;
        o_manage <= SLTIU_OP;
        wait for clk_period;

        -- logic test

        o_first_operand <= x"00000005"; -- +5
        o_second_operand <= x"00000008"; -- +8
        o_manage <= XOR_OP;
        wait for clk_period;
        o_manage <= OR_OP;
        wait for clk_period;
        o_manage <= AND_OP;
        wait for clk_period;
        o_manage <= XORI_OP;
        wait for clk_period;
        o_manage <= ORI_OP;
        wait for clk_period;
        o_manage <= ANDI_OP;
        wait for clk_period;

        o_manage <= MUL_OP;
        wait for clk_period;
        o_manage <= MULH_OP;
        wait for clk_period;
        o_manage <= MULHSU_OP;
        wait for clk_period;
        o_manage <= MULHU_OP;
        wait for clk_period;

    end process ;
end architecture;