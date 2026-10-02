library IEEE;

use IEEE.STD_LOGIC_1164.ALL;



entity full_adder_8bit_tb is

end full_adder_8bit_tb;



architecture behavior of full_adder_8bit_tb is



    component full_adder_8bit

    port (

        a0, a1, a2, a3, a4, a5, a6, a7 : in  std_logic;

        b0, b1, b2, b3, b4, b5, b6, b7 : in  std_logic;

        cin : in  std_logic;

        sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7 : out std_logic;

        cout : out std_logic

    );

    end component;

	 

	 signal a0, a1, a2, a3, a4, a5, a6, a7 : std_logic := '0';

    signal b0, b1, b2, b3, b4, b5, b6, b7 : std_logic := '0';

    signal cin : std_logic := '0';



    signal sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7 : std_logic;

    signal cout : std_logic;

	 

begin



    uut: full_adder_8bit port map (

        a0 => a0, a1 => a1, a2 => a2, a3 => a3,

        a4 => a4, a5 => a5, a6 => a6, a7 => a7,

        b0 => b0, b1 => b1, b2 => b2, b3 => b3,

        b4 => b4, b5 => b5, b6 => b6, b7 => b7,

        cin => cin,

        sum0 => sum0, sum1 => sum1, sum2 => sum2, sum3 => sum3,

        sum4 => sum4, sum5 => sum5, sum6 => sum6, sum7 => sum7,

        cout => cout

    );

	 

	 stim_proc: process

    begin

        a7 <= '0'; a6 <= '0'; a5 <= '0'; a4 <= '0'; a3 <= '0'; a2 <= '0'; a1 <= '0'; a0 <= '0';

        b7 <= '0'; b6 <= '0'; b5 <= '0'; b4 <= '0'; b3 <= '0'; b2 <= '0'; b1 <= '0'; b0 <= '0';

        cin <= '0'; wait for 50 ns;

		  

		  a7 <= '0'; a6 <= '0'; a5 <= '0'; a4 <= '1'; a3 <= '1'; a2 <= '0'; a1 <= '0'; a0 <= '1';

        b7 <= '0'; b6 <= '0'; b5 <= '1'; b4 <= '1'; b3 <= '0'; b2 <= '0'; b1 <= '1'; b0 <= '0';

        cin <= '0'; wait for 50 ns;

		  

		  a7 <= '0'; a6 <= '1'; a5 <= '1'; a4 <= '0'; a3 <= '0'; a2 <= '1'; a1 <= '0'; a0 <= '0';

        b7 <= '0'; b6 <= '1'; b5 <= '1'; b4 <= '0'; b3 <= '0'; b2 <= '1'; b1 <= '0'; b0 <= '0';

        cin <= '0'; wait for 50 ns;

		  

		  a7 <= '1'; a6 <= '0'; a5 <= '1'; a4 <= '0'; a3 <= '1'; a2 <= '0'; a1 <= '1'; a0 <= '0';

        b7 <= '0'; b6 <= '1'; b5 <= '0'; b4 <= '1'; b3 <= '0'; b2 <= '1'; b1 <= '0'; b0 <= '1';

        cin <= '0'; wait for 50 ns;

		  

		  cin <= '1'; wait for 50 ns;

		  

		  a7 <= '1'; a6 <= '1'; a5 <= '1'; a4 <= '1'; a3 <= '1'; a2 <= '1'; a1 <= '1'; a0 <= '1';

        b7 <= '0'; b6 <= '0'; b5 <= '0'; b4 <= '0'; b3 <= '0'; b2 <= '0'; b1 <= '0'; b0 <= '1';

        cin <= '0'; wait for 50 ns;

		  

		  b7 <= '1'; b6 <= '1'; b5 <= '1'; b4 <= '1'; b3 <= '1'; b2 <= '1'; b1 <= '1'; b0 <= '1';

        cin <= '1'; wait for 50 ns;

        wait;

    end process;



end behavior;
