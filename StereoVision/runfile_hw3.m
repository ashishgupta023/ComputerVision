win = [1;2;4]; %3X3 ; 5X5 ; 9X9

I1 = imread('Data/view1' , 'png');
I5 = imread('Data/view5' , 'png');
G1 = imread('Data/disp1' , 'png');
G5 = imread('Data/disp5' , 'png');

for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/headDispMap1_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I1 , I5 , win(i) , G1  ) ;
    imwrite( uint8(disparityMap) , filename);
end


for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/headDispMap5_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I5 , I1 , win(i) , G5 ) ;
    imwrite( uint8(disparityMap) , filename);
end


I1 = imread('Evaluation/Dolls/view1' , 'png');
I5 = imread('Evaluation/Dolls/view5' , 'png');
G1 = imread('Evaluation/Dolls/disp1' , 'png');
G5 = imread('Evaluation/Dolls/disp5' , 'png');

for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/dollsDispMap1_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I1 , I5 , win(i) , G1  ) ;
    imwrite( uint8(disparityMap) , filename);
end


for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/dollsDispMap5_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I5 , I1 , win(i) , G5 ) ;
    imwrite( uint8(disparityMap) , filename);
end

I1 = imread('Evaluation/Books/view1' , 'png');
I5 = imread('Evaluation/Books/view5' , 'png');
G1 = imread('Evaluation/Books/disp1' , 'png');
G5 = imread('Evaluation/Books/disp5' , 'png');

for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/booksDispMap1_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I1 , I5 , win(i) , G1  ) ;
    imwrite( uint8(disparityMap) , filename);
end


for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/booksDispMap5_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I5 , I1 , win(i) , G5 ) ;
    imwrite( uint8(disparityMap) , filename);
end

I1 = imread('Evaluation/Reindeer/view1' , 'png');
I5 = imread('Evaluation/Reindeer/view5' , 'png');
G1 = imread('Evaluation/Reindeer/disp1' , 'png');
G5 = imread('Evaluation/Reindeer/disp5' , 'png');

for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/reindeerDispMap1_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I1 , I5 , win(i) , G1  ) ;
    imwrite( uint8(disparityMap) , filename);
end


for i = 1:size(win,1)
    display(win(i));
    filename = strcat('Results/reindeerDispMap5_win',num2str(win(i)));
    filename = strcat(filename , '.png');
    display(filename);
    disparityMap =  BlockMatch( I5 , I1 , win(i) , G5 ) ;
    imwrite( uint8(disparityMap) , filename);
end




