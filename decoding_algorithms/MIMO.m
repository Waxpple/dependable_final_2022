clear;
frames=10000;
codewordN = 63; % Codeword length
codewordK = 57; % Message length
%QAM16_sphere_decoding(1000 * k * 4);
%function QAM16_sphere_decoding(frames)
fprintf('16 QAM Sphere decoding detection with '+string(frames*4*codewordK)+' samples\n');
eb_n0 = (0:2:20)';
ber = zeros(length(eb_n0),1);
ber2 = zeros(length(eb_n0),1);
tic;


parfor eb_n0_iter = 1:length(eb_n0)
    codewordN = 63; % Codeword length (parfor needs local variable)
    codewordK = 57; % Message length
    information = randi(2,codewordK*4*frames,1)-1;
    encodedData = encode(information,codewordN,codewordK,'hamming/binary');
    %Use hamming code
    symbol_tx = QAM16_encoder(encodedData);
    symbol_rx = zeros(length(symbol_tx),1);
    %No coding
    symbol_tx_no_coding = QAM16_encoder(information);
    symbol_rx_no_coding = zeros(length(symbol_tx_no_coding),1);

    for time_cnt = 1:length(symbol_tx)/4
        x = ((sqrt(4) / sqrt(4)) / sqrt(10)) * symbol_tx(4*(time_cnt-1)+1:4*(time_cnt));
        H = (randn(4,4) + 1i*randn(4,4)) / sqrt(2);
        n = (randn(4,1) + 1i*randn(4,1)) / sqrt(2);
        symbol_rx_hat = H*x;
        y = symbol_rx_hat + 10^(-eb_n0(eb_n0_iter)/20)*n;
        [Q,R] = qr(H);
        z = Q'*y;
        symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = QAM16_sphere_decoder(z,R);
    end
    
    for time_cnt = 1:length(symbol_tx_no_coding)/4
        x = ((sqrt(4) / sqrt(4)) / sqrt(10)) * symbol_tx_no_coding(4*(time_cnt-1)+1:4*(time_cnt));
        H = (randn(4,4) + 1i*randn(4,4)) / sqrt(2);
        n = (randn(4,1) + 1i*randn(4,1)) / sqrt(2);
        symbol_rx_hat = H*x;
        y = symbol_rx_hat + 10^(-eb_n0(eb_n0_iter)/20)*n;
        [Q,R] = qr(H);
        z = Q'*y;
        symbol_rx_no_coding(4*(time_cnt-1)+1:4*(time_cnt)) = QAM16_sphere_decoder(z,R);
    end
    
    information_rx = QAM16_decoder(symbol_rx,false);
    receivedBits =  decode(information_rx,codewordN,codewordK,'hamming/binary');
    err = length(find(receivedBits-information));
    if err < 100
       fprintf("[INFO] too less error bit!\n");
    end
    ber(eb_n0_iter) = err/(frames*4*codewordK);

    information_rx_no_coding = QAM16_decoder(symbol_rx_no_coding,false);
    err = length(find(information_rx_no_coding-information));
    if err < 100
       fprintf("[INFO] too less error bit!\n");
    end
    ber2(eb_n0_iter) = err/(frames*4*codewordK);
end

toc;
fig = figure;
semilogy(eb_n0,ber+1e-12,eb_n0,ber2+1e-12,'-s');
axis([0 20.1 0.000001 1]);
grid on;
legend('Sphere decoding Detection with (63,57) hamming code', 'No channel coding');
xlabel('Eb/N0(dB)');
ylabel('BER');
title('4x4 16 QAM Sphere decoding detection with '+string(frames*4*codewordK)+' samples');
writematrix([eb_n0,ber],'data/QAM16_sphere_decoding.txt');

%end

