library ieee;
use ieee.std_logic_1164.all;
library work;
use work.alu_package.all;

entity ALU is
    port(
        i_first_operand, i_second_operand : in std_logic_vector(31 downto 0);
        i_manage : in std_logic_vector(16 downto 0);
        i_clk : in std_logic;
        i_rst : in std_logic;
        o_result : out std_logic_vector(31 downto 0)
    );
end entity;

architecture ALU_arch of ALU is

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

    
    begin
    process(i_clk)
        variable result : std_logic_vector(31 downto 0);
    begin
        if(i_rst = '1') then
            result := x"00000000";
        elsif(i_manage = ADDI_OP or i_manage = ADD_OP) then
            result := addition(i_first_operand, i_second_operand);
        elsif(i_manage = SLTI_OP or i_manage = SLT_OP) then 
            result := set_less_then(i_first_operand, i_second_operand);            
        elsif(i_manage = SLTIU_OP) then 
            result := set_less_then_unsigned(i_first_operand, i_second_operand);            
        elsif(i_manage = XORI_OP or i_manage = XOR_OP) then
            result := i_first_operand xor i_second_operand;            
        elsif(i_manage = ORI_OP or i_manage = OR_OP) then
            result := i_first_operand or i_second_operand;            
        elsif(i_manage = ANDI_OP or i_manage = AND_OP) then 
            result := i_first_operand and i_second_operand;            
        elsif(i_manage = SLLI_OP or i_manage = SLL_OP) then 
            result := shift_left_logic(i_first_operand, i_second_operand); 
        elsif(i_manage = SRLI_OP or i_manage = SRL_OP) then 
            result := shift_right_logic(i_first_operand, i_second_operand); 
        elsif(i_manage = SRAI_OP or i_manage = SRA_OP) then
            result := shift_right_arithmetic(i_first_operand, i_second_operand); 
        elsif(i_manage = SUB_OP) then
            result := substraction(i_first_operand, i_second_operand); 
        elsif(i_manage = MUL_OP) then 
            result := multiplication(i_first_operand, i_second_operand); 
        elsif(i_manage = MULH_OP) then 
            result := multiplication_high(i_first_operand, i_second_operand); 
        elsif(i_manage = MULHSU_OP) then
            result := multiplication_high_signed_unsigned(i_first_operand, i_second_operand);
        elsif(i_manage = MULHU_OP) then
            result := multiplication_high_unsigned(i_first_operand, i_second_operand);
        end if;
        o_result <= result;
    end process;
end architecture;