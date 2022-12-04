function QPSK_zero_forcing(samples)
fprintf('QPSK Zero-forcing detection with '+string(samples)+' samples\n');
eb_n0 = (0:2:30)';
ber = zeros(length(eb_n0),1);

tic;
parfor eb_n0_iter = 1:length(eb_n0)
    information = randi(2,samples,1)-1;
    symbol_tx = QPSK_encoder(information);
    symbol_rx = zeros(length(symbol_tx),1);
    symbol_power = 0;
    white_noise_power = 0;
    for time_cnt = 1:length(symbol_tx)/4
        x = ((sqrt(2) / sqrt(2)) / sqrt(4)) * symbol_tx(4*(time_cnt-1)+1:4*(time_cnt));
        H = (randn(4,4) + 1i*randn(4,4)) / sqrt(2);
        n = (randn(4,1) + 1i*randn(4,1)) / sqrt(2);
        H_psudo_inv = inv(H'*H)*H';   %pinv(H); %H'*H\H'; %inv(H'*H)*H';
        symbol_rx_hat = H*x;
        y = symbol_rx_hat + 10^(-eb_n0(eb_n0_iter)/20)*n;
        white_noise_power = white_noise_power + sum(abs(n).^2);
        symbol_power = symbol_power + sum(abs(symbol_rx_hat).^2);
        symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = H_psudo_inv*y;
    end
    information_rx = zeros(length(information),1);
    information_rx = QPSK_decoder(symbol_rx);
    err = length(find(information_rx-information));
    if err < 30
        fprintf("[INFO] too less error bit!");
    end
    ber(eb_n0_iter) = err/samples;
end

toc;
fig = figure;
semilogy(eb_n0,ber,'-s');
hold on;
axis([0 30 0.00001 1]);
grid on;
legend('Zero-forcing Detection');
xlabel('Eb/N0(dB)');
ylabel('BER');
title('4x4 QPSK Zero-forcing detection with '+string(samples)+' samples');
writematrix([eb_n0,ber],'data/QPSK_zero_forcing.txt');

end
