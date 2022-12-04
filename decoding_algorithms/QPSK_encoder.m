function out = QPSK_encoder(in)
    out = zeros(length(in)/2,1);
    for i = 1:length(in)/2
        data = in(2*i-1:2*i,:);
        if isequal(data,[0;0])
                out(i) = -1 - 1i;
        elseif isequal(data,[0;1])
                out(i) = -1 + 1i;
        elseif isequal(data,[1;0])
                out(i) =  1 - 1i;
        elseif isequal(data,[1;1])
                out(i) = 1 + 1i;
        else
                disp("ERROR! UNKNOW DATA FOUND!");
                disp(data);
        end
    end
end