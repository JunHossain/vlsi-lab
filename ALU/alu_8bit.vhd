library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 8-bit ALU built from the gates, adder and mux of the project
-- SEL = "00" -> ADD   (A + B + CIN)
-- SEL = "01" -> AND   (A and B)
-- SEL = "10" -> OR    (A or  B)
-- SEL = "11" -> XOR   (A xor B)
entity alu_8bit is
    Port ( A      : in  STD_LOGIC_VECTOR (7 downto 0);
           B      : in  STD_LOGIC_VECTOR (7 downto 0);
           CIN    : in  STD_LOGIC;
           SEL    : in  STD_LOGIC_VECTOR (1 downto 0);
           RESULT : out STD_LOGIC_VECTOR (7 downto 0);
           COUT   : out STD_LOGIC);
end alu_8bit;

architecture Structural of alu_8bit is

    component adder_8bit
        Port ( A    : in  STD_LOGIC_VECTOR (7 downto 0);
               B    : in  STD_LOGIC_VECTOR (7 downto 0);
               CIN  : in  STD_LOGIC;
               SUM  : out STD_LOGIC_VECTOR (7 downto 0);
               COUT : out STD_LOGIC);
    end component;

    component and_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component or_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component xor_gate
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Y : out STD_LOGIC);
    end component;

    component mux4
        Port ( D0  : in  STD_LOGIC;
               D1  : in  STD_LOGIC;
               D2  : in  STD_LOGIC;
               D3  : in  STD_LOGIC;
               SEL : in  STD_LOGIC_VECTOR (1 downto 0);
               Y   : out STD_LOGIC);
    end component;

    signal ADD_OUT  : STD_LOGIC_VECTOR (7 downto 0);
    signal AND_OUT  : STD_LOGIC_VECTOR (7 downto 0);
    signal OR_OUT   : STD_LOGIC_VECTOR (7 downto 0);
    signal XOR_OUT  : STD_LOGIC_VECTOR (7 downto 0);
    signal ADD_COUT : STD_LOGIC;

begin

    -- arithmetic part
    U_ADD: adder_8bit port map (
        A => A, B => B, CIN => CIN,
        SUM => ADD_OUT, COUT => ADD_COUT
    );

    -- logic part: one gate for each bit
    GEN_LOGIC: for i in 0 to 7 generate
        U_AND: and_gate port map (A => A(i), B => B(i), Y => AND_OUT(i));
        U_OR:  or_gate  port map (A => A(i), B => B(i), Y => OR_OUT(i));
        U_XOR: xor_gate port map (A => A(i), B => B(i), Y => XOR_OUT(i));
    end generate GEN_LOGIC;

    -- output select: one 4-to-1 mux for each bit
    GEN_MUX: for i in 0 to 7 generate
        U_MUX: mux4 port map (
            D0 => ADD_OUT(i), D1 => AND_OUT(i),
            D2 => OR_OUT(i),  D3 => XOR_OUT(i),
            SEL => SEL, Y => RESULT(i)
        );
    end generate GEN_MUX;

    -- carry-out is meaningful only for ADD
    COUT <= ADD_COUT when SEL = "00" else '0';

end Structural;
