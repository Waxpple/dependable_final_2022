function out = QAM16_encoder(in)
    out = zeros(length(in)/4,1);
    for i = 1:length(in)/4
        data = in(4*(i-1)+1:4*i,:);
        if isequal(data,[0;0;0;0])
                out(i) = -3 + 1i*-3;
        elseif isequal(data,[0;0;0;1]) 
                out(i)= -3 + 1i* -1 ;
        elseif isequal(data,[0;0;1;0]) 
                out(i)= -3 + 1i* 3 ;
        
        elseif isequal(data,[0;0;1;1]) 
                out(i)= -3 + 1i* 1 ;
        
        elseif isequal(data,[0;1;0;0]) 
                out(i)= -1 + 1i* -3 ;
        
        elseif isequal(data,[0;1;0;1]) 
                out(i)= -1 + 1i* -1 ;
        
        elseif isequal(data,[0;1;1;0]) 
                out(i)= -1 + 1i* 3 ;
        
        elseif isequal(data,[0;1;1;1]) 
                out(i)= -1 + 1i* 1 ;
        
        elseif isequal(data,[1;0;0;0]) 
                out(i)= 3 + 1i* -3 ;
        
        elseif isequal(data,[1;0;0;1]) 
                out(i)= 3 + 1i* -1 ;
        
        elseif isequal(data,[1;0;1;0]) 
                out(i)= 3 + 1i* 3 ;
        
        elseif isequal(data,[1;0;1;1]) 
                out(i)= 3 + 1i* 1 ;
        
        elseif isequal(data,[1;1;0;0]) 
                out(i)= 1 + 1i* -3 ;
        
        elseif isequal(data,[1;1;0;1]) 
                out(i)= 1 + 1i* -1 ;
        
        elseif isequal(data,[1;1;1;0]) 
                out(i)= 1 + 1i* 3 ;
        
        elseif isequal(data,[1;1;1;1]) 
                out(i)= 1 + 1i* 1 ;
        else
                disp("ERROR! UNKNOW DATA FOUND!");
                disp(data);
        end
    end
end