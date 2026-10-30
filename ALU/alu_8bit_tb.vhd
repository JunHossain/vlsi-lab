library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_8bit_tb is
end alu_8bit_tb;

architecture Behavioral of alu_8bit_tb is

    component alu_8bit
        Port ( A      : in  STD_LOGIC_VECTOR (7 downto 0);
               B      : in  STD_LOGIC_VECTOR (7 downto 0);
               CIN    : in  STD_LOGIC;
               SEL    : in  STD_LOGIC_VECTOR (1 downto 0);
               RESULT : out STD_LOGIC_VECTOR (7 downto 0);
               COUT   : out STD_LOGIC);
    end component;

    signal A_tb, B_tb, RESULT_tb : STD_LOGIC_VECTOR (7 downto 0);
    signal SEL_tb                : STD_LOGIC_VECTOR (1 downto 0);
    signal CIN_tb, COUT_tb       : STD_LOGIC;

begin

    UUT: alu_8bit port map ( A => A_tb, B => B_tb, CIN => CIN_tb, SEL => SEL_tb,
                             RESULT => RESULT_tb, COUT => COUT_tb );

    stim_proc: process
        variable errors : integer := 0;

        -- prints an error message and counts it when a check fails
        procedure check (ok : boolean; msg : string) is
        begin
            if not ok then
                report msg severity error;
                errors := errors + 1;
            end if;
        end procedure;
    begin
        -- ---------- ADD (SEL = 00) ----------
        -- 3C + 27 = 63, cout = 0
        A_tb <= x"3C"; B_tb <= x"27"; CIN_tb <= '0'; SEL_tb <= "00"; wait for 50 ns;
        check (RESULT_tb = x"63" and COUT_tb = '0', "FAIL: ADD 3C+27");

        -- FF + 01 = 00, cout = 1
        A_tb <= x"FF"; B_tb <= x"01"; CIN_tb <= '0'; SEL_tb <= "00"; wait for 50 ns;
        check (RESULT_tb = x"00" and COUT_tb = '1', "FAIL: ADD FF+01");

        -- 10 + 20 + carry-in = 31, cout = 0
        A_tb <= x"10"; B_tb <= x"20"; CIN_tb <= '1'; SEL_tb <= "00"; wait for 50 ns;
        check (RESULT_tb = x"31" and COUT_tb = '0', "FAIL: ADD 10+20+cin");

        -- ---------- AND (SEL = 01) ----------
        -- F0 and 3C = 30
        A_tb <= x"F0"; B_tb <= x"3C"; CIN_tb <= '0'; SEL_tb <= "01"; wait for 50 ns;
        check (RESULT_tb = x"30" and COUT_tb = '0', "FAIL: AND F0,3C");

        -- AA and 55 = 00
        A_tb <= x"AA"; B_tb <= x"55"; CIN_tb <= '0'; SEL_tb <= "01"; wait for 50 ns;
        check (RESULT_tb = x"00" and COUT_tb = '0', "FAIL: AND AA,55");

        -- FF and FF = FF, cout stays 0 (the adder would give a carry here)
        A_tb <= x"FF"; B_tb <= x"FF"; CIN_tb <= '1'; SEL_tb <= "01"; wait for 50 ns;
        check (RESULT_tb = x"FF" and COUT_tb = '0', "FAIL: AND FF,FF");

        -- ---------- OR (SEL = 10) ----------
        -- A0 or 0F = AF
        A_tb <= x"A0"; B_tb <= x"0F"; CIN_tb <= '0'; SEL_tb <= "10"; wait for 50 ns;
        check (RESULT_tb = x"AF" and COUT_tb = '0', "FAIL: OR A0,0F");

        -- 55 or AA = FF
        A_tb <= x"55"; B_tb <= x"AA"; CIN_tb <= '0'; SEL_tb <= "10"; wait for 50 ns;
        check (RESULT_tb = x"FF" and COUT_tb = '0', "FAIL: OR 55,AA");

        -- 00 or 00 = 00
        A_tb <= x"00"; B_tb <= x"00"; CIN_tb <= '0'; SEL_tb <= "10"; wait for 50 ns;
        check (RESULT_tb = x"00" and COUT_tb = '0', "FAIL: OR 00,00");

        -- ---------- XOR (SEL = 11) ----------
        -- FF xor 0F = F0
        A_tb <= x"FF"; B_tb <= x"0F"; CIN_tb <= '0'; SEL_tb <= "11"; wait for 50 ns;
        check (RESULT_tb = x"F0" and COUT_tb = '0', "FAIL: XOR FF,0F");

        -- 55 xor 55 = 00
        A_tb <= x"55"; B_tb <= x"55"; CIN_tb <= '0'; SEL_tb <= "11"; wait for 50 ns;
        check (RESULT_tb = x"00" and COUT_tb = '0', "FAIL: XOR 55,55");

        -- 3C xor C3 = FF
        A_tb <= x"3C"; B_tb <= x"C3"; CIN_tb <= '0'; SEL_tb <= "11"; wait for 50 ns;
        check (RESULT_tb = x"FF" and COUT_tb = '0', "FAIL: XOR 3C,C3");

        if errors = 0 then
            report "PASS: alu_8bit testbench completed" severity note;
        else
            report "FAIL: " & integer'image(errors) & " check(s) failed" severity error;
        end if;
        wait;
    end process;

end Behavioral;
