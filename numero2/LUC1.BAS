1 ' By Luciano M. C. 2018-10-26
10 CLS:DEFINT I,R,C
20 INPUT"Raio do ponto";R:C=0
30 IF R=1 THEN 50 ELSE IF R < 1 THEN 20
40 R2=R*R:FOR I=1 TO R-1:C=C+SQR(R2-I*I):NEXT I
50 PRINT"Quantidade de pixels acesos:";4*(R+C)+1
