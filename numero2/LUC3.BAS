10 DEFINTA-X:INPUT"R";R:C=R-1:D=C
20 IFR=1THEN50
30 Q=R*R:T=D*D:N=R*.7071:FORI=2TON
40 IFT>Q-I*ITHEND=D-1:T=D*D:GOTO40:ELSEC=C+D:NEXTI
50 PRINT"Pontos:";4*(R+2*C-N*N)+1
