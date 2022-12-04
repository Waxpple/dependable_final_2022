function out = QPSK_decoder(in)
    out = zeros(2*length(in),1);
    data = in*sqrt(4) * sqrt(2) / sqrt(2);
    %first quantized the input
    lut = [1 + 1i, -1+1i, -1-1i, 1-1i];
    bin_lut = [[1 1];[0 1];[0 0];[1 0];];
    for i = 1:length(data)
        distance = lut - data(i);
        out(2*i-1:2*i) = [bin_lut(distance == min(distance),:)]';
    end
end