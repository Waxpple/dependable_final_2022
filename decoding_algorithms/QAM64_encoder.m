function out = QAM64_encoder(in)
    out = zeros(length(in)/6,1);
    for i = 1:length(in)/6
        data = in(6*(i-1)+1:6*i,:);
        if isequal(data,[0;0;0;0;0;0]) 
             out(i)= -7 + 1i* -7 ;
        elseif isequal(data,[0;0;0;0;0;1]) 
             out(i)= -7 + 1i* -5 ;
        
        elseif isequal(data,[0;0;0;0;1;0]) 
             out(i)= -7 + 1i* -1 ;
        
        elseif isequal(data,[0;0;0;0;1;1]) 
             out(i)= -7 + 1i* -3 ;
        
        elseif isequal(data,[0;0;0;1;0;0]) 
             out(i)= -7 + 1i* 7 ;
        
        elseif isequal(data,[0;0;0;1;0;1]) 
             out(i)= -7 + 1i* 5 ;
        
        elseif isequal(data,[0;0;0;1;1;0]) 
             out(i)= -7 + 1i* 1 ;
        
        elseif isequal(data,[0;0;0;1;1;1]) 
             out(i)= -7 + 1i* 3 ;
        
        elseif isequal(data,[0;0;1;0;0;0]) 
             out(i)= -5 + 1i* -7 ;
        
        elseif isequal(data,[0;0;1;0;0;1]) 
             out(i)= -5 + 1i* -5 ;
        
        elseif isequal(data,[0;0;1;0;1;0]) 
             out(i)= -5 + 1i* -1 ;
        
        elseif isequal(data,[0;0;1;0;1;1]) 
             out(i)= -5 + 1i* -3 ;
        
        elseif isequal(data,[0;0;1;1;0;0]) 
             out(i)= -5 + 1i* 7 ;
        
        elseif isequal(data,[0;0;1;1;0;1]) 
             out(i)= -5 + 1i* 5 ;
        
        elseif isequal(data,[0;0;1;1;1;0]) 
             out(i)= -5 + 1i* 1 ;
        
        elseif isequal(data,[0;0;1;1;1;1]) 
             out(i)= -5 + 1i* 3 ;
        
        elseif isequal(data,[0;1;0;0;0;0]) 
             out(i)= -1 + 1i* -7 ;
        
        elseif isequal(data,[0;1;0;0;0;1]) 
             out(i)= -1 + 1i* -5 ;
        
        elseif isequal(data,[0;1;0;0;1;0]) 
             out(i)= -1 + 1i* -1 ;
        
        elseif isequal(data,[0;1;0;0;1;1]) 
             out(i)= -1 + 1i* -3 ;
        
        elseif isequal(data,[0;1;0;1;0;0]) 
             out(i)= -1 + 1i* 7 ;
        
        elseif isequal(data,[0;1;0;1;0;1]) 
             out(i)= -1 + 1i* 5 ;
        
        elseif isequal(data,[0;1;0;1;1;0]) 
             out(i)= -1 + 1i* 1 ;
        
        elseif isequal(data,[0;1;0;1;1;1]) 
             out(i)= -1 + 1i* 3 ;
        
        elseif isequal(data,[0;1;1;0;0;0]) 
             out(i)= -3 + 1i* -7 ;
        
        elseif isequal(data,[0;1;1;0;0;1]) 
             out(i)= -3 + 1i* -5 ;
        
        elseif isequal(data,[0;1;1;0;1;0]) 
             out(i)= -3 + 1i* -1 ;
        
        elseif isequal(data,[0;1;1;0;1;1]) 
             out(i)= -3 + 1i* -3 ;
        
        elseif isequal(data,[0;1;1;1;0;0]) 
             out(i)= -3 + 1i* 7 ;
        
        elseif isequal(data,[0;1;1;1;0;1]) 
             out(i)= -3 + 1i* 5 ;
        
        elseif isequal(data,[0;1;1;1;1;0]) 
             out(i)= -3 + 1i* 1 ;
        
        elseif isequal(data,[0;1;1;1;1;1]) 
             out(i)= -3 + 1i* 3 ;
        
        elseif isequal(data,[1;0;0;0;0;0]) 
             out(i)= 7 + 1i* -7 ;
        
        elseif isequal(data,[1;0;0;0;0;1]) 
             out(i)= 7 + 1i* -5 ;
        
        elseif isequal(data,[1;0;0;0;1;0]) 
             out(i)= 7 + 1i* -1 ;
        
        elseif isequal(data,[1;0;0;0;1;1]) 
             out(i)= 7 + 1i* -3 ;
        
        elseif isequal(data,[1;0;0;1;0;0]) 
             out(i)= 7 + 1i* 7 ;
        
        elseif isequal(data,[1;0;0;1;0;1]) 
             out(i)= 7 + 1i* 5 ;
        
        elseif isequal(data,[1;0;0;1;1;0]) 
             out(i)= 7 + 1i* 1 ;
        
        elseif isequal(data,[1;0;0;1;1;1]) 
             out(i)= 7 + 1i* 3 ;
        
        elseif isequal(data,[1;0;1;0;0;0]) 
             out(i)= 5 + 1i* -7 ;
        
        elseif isequal(data,[1;0;1;0;0;1]) 
             out(i)= 5 + 1i* -5 ;
        
        elseif isequal(data,[1;0;1;0;1;0]) 
             out(i)= 5 + 1i* -1 ;
        
        elseif isequal(data,[1;0;1;0;1;1]) 
             out(i)= 5 + 1i* -3 ;
        
        elseif isequal(data,[1;0;1;1;0;0]) 
             out(i)= 5 + 1i* 7 ;
        
        elseif isequal(data,[1;0;1;1;0;1]) 
             out(i)= 5 + 1i* 5 ;
        
        elseif isequal(data,[1;0;1;1;1;0]) 
             out(i)= 5 + 1i* 1 ;
        
        elseif isequal(data,[1;0;1;1;1;1]) 
             out(i)= 5 + 1i* 3 ;
        
        elseif isequal(data,[1;1;0;0;0;0]) 
             out(i)= 1 + 1i* -7 ;
        
        elseif isequal(data,[1;1;0;0;0;1]) 
             out(i)= 1 + 1i* -5 ;
        
        elseif isequal(data,[1;1;0;0;1;0]) 
             out(i)= 1 + 1i* -1 ;
        
        elseif isequal(data,[1;1;0;0;1;1]) 
             out(i)= 1 + 1i* -3 ;
        
        elseif isequal(data,[1;1;0;1;0;0]) 
             out(i)= 1 + 1i* 7 ;
        
        elseif isequal(data,[1;1;0;1;0;1]) 
             out(i)= 1 + 1i* 5 ;
        
        elseif isequal(data,[1;1;0;1;1;0]) 
             out(i)= 1 + 1i* 1 ;
        
        elseif isequal(data,[1;1;0;1;1;1]) 
             out(i)= 1 + 1i* 3 ;
        
        elseif isequal(data,[1;1;1;0;0;0]) 
             out(i)= 3 + 1i* -7 ;
        
        elseif isequal(data,[1;1;1;0;0;1]) 
             out(i)= 3 + 1i* -5 ;
        
        elseif isequal(data,[1;1;1;0;1;0]) 
             out(i)= 3 + 1i* -1 ;
        
        elseif isequal(data,[1;1;1;0;1;1]) 
             out(i)= 3 + 1i* -3 ;
        
        elseif isequal(data,[1;1;1;1;0;0]) 
             out(i)= 3 + 1i* 7 ;
        
        elseif isequal(data,[1;1;1;1;0;1]) 
             out(i)= 3 + 1i* 5 ;
        
        elseif isequal(data,[1;1;1;1;1;0]) 
             out(i)= 3 + 1i* 1 ;
        
        elseif isequal(data,[1;1;1;1;1;1]) 
             out(i)= 3 + 1i* 3 ;
        else
                disp("ERROR! UNKNOW DATA FOUND!");
                disp(data);
        end
    end
end