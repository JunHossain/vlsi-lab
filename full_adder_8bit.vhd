library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_8bit is
    Port ( a0, a1, a2, a3, a4, a5, a6, a7 : in  STD_LOGIC;
           b0, b1, b2, b3, b4, b5, b6, b7 : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7 : out STD_LOGIC;
           cout : out STD_LOGIC);
end full_adder_8bit;

architecture Structural of full_adder_8bit is
    signal c0, c1, c2, c3, c4, c5, c6 : STD_LOGIC;
begin
    fa0: entity work.full_adder port map (a => a0, b => b0, cin => cin, sum => sum0, cout => c0);
    fa1: entity work.full_adder port map (a => a1, b => b1, cin => c0,  sum => sum1, cout => c1);
    fa2: entity work.full_adder port map (a => a2, b => b2, cin => c1,  sum => sum2, cout => c2);
	 fa3: entity work.full_adder port map (a => a3, b => b3, cin => c2,  sum => sum3, cout => c3);
    fa4: entity work.full_adder port map (a => a4, b => b4, cin => c3,  sum => sum4, cout => c4);
    fa5: entity work.full_adder port map (a => a5, b => b5, cin => c4,  sum => sum5, cout => c5);
	 fa6: entity work.full_adder port map (a => a6, b => b6, cin => c5,  sum => sum6, cout => c6);
    fa7: entity work.full_adder port map (a => a7, b => b7, cin => c6,  sum => sum7, cout => cout);
end Structural;
