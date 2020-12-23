LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY lab_03 IS
PORT( Clock         :IN STD_LOGIC ; 
      Load_A,Start:IN STD_LOGIC ; 
      reset_n       :IN STD_LOGIC ;
      A            :IN STD_LOGIC_VECTOR (7 DOWNTO 0) ;
      B            :OUT STD_LOGIC_VECTOR (3 DOWNTO 0) ;
      Done         :OUT STD_LOGIC) ; 
END lab_03; 

ARCHITECTURE Behavior OF lab_03 IS 
   SIGNAL STATE      :STD_LOGIC_VECTOR (1 DOWNTO 0); --STATE : 00,01,10,11
   SIGNAL A_bit      :STD_LOGIC_VECTOR (7 DOWNTO 0); 
   SIGNAL B_bit      :STD_LOGIC_VECTOR (3 DOWNTO 0); 
   
BEGIN
   PROCESS (Clock, reset_n, A, A_bit)
   BEGIN 
      IF reset_n='0' THEN
         STATE<="00"; --reset
         Done<='0';   --reset
         B_bit<=(OTHERS=>'0'); --reset
         A_bit<=(OTHERS=>'0'); --reset
      ELSIF (Clock'EVENT AND Clock='1') THEN 
         CASE STATE IS
            WHEN "00"=> 
               if Load_A= '0' then --IF LOAD is False
                  STATE<= "00"; 
               else                  --IF LOAD is True
                  A_bit<=A;         --receive 8 bit data input A
                  STATE<= "01"; 
               end if; 
            WHEN "01"=> 
               if Start= '0' then 
                  STATE<= "01"; 
               else 
                  STATE<= "10"; 
               end if; 
            WHEN "10"=>
               IF A_bit/="00000000" THEN --while A≠0
                  STATE<="10";
                  IF(A_bit(0)='1') THEN --A_bit is 1
                     B_bit<=B_bit+1;    --count+1
                  END IF;
                  A_bit<='0'&A_bit(7 DOWNTO 1);  --Change A_bit=0, Right-shift A
               ELSE
                  Done<='1';
                  STATE<="11";
               END IF; 
            WHEN "11"=> 
               STATE<="11";
         END CASE; 
      END IF; 
   END PROCESS; 
B<=B_bit;          --Output
END Behavior;      --Finish