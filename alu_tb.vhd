library IEEE;
use IEEE.std_logic_1164.all;

entity alu_tb is
end entity;

architecture alu_tb_arch of alu_tb is
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal manage : std_logic_vector(16 downto 0);
    signal first_operand : std_logic_vector(31 downto 0);
    signal second_operand : std_logic_vector(31 downto 0);
    signal result : std_logic_vector(31 downto 0);

begin

    alu_tester : entity work.alu_tester(alu_tester_arch) port map (
        o_clk => clk,
        o_rst => rst,
        o_first_operand => first_operand,
        o_second_operand  => second_operand,
        o_manage => manage
    );

    ALU : entity work.ALU(ALU_arch) port map (
        i_clk => clk,
        i_rst => rst,
        i_first_operand => first_operand,
        i_second_operand => second_operand,
        i_manage => manage,
        o_result => result
    );
    
end architecture;