%samples=2400000;
function QAM64_sphere_decoding_sorted(samples)
fprintf('64 QAM Sphere decoding sorted detection with '+string(samples)+' samples\n');
eb_n0 = (0:2:20)';
ber = zeros(length(eb_n0),1);

tic;
parfor eb_n0_iter = 1:length(eb_n0)
    information = randi(2,samples,1)-1;
    symbol_tx = QAM64_encoder(information);
    symbol_rx = zeros(length(symbol_tx),1);
    symbol_power = 0;
    white_noise_power = 0;
    for time_cnt = 1:length(symbol_tx)/4
        x = (1 / sqrt(28)) * symbol_tx(4*(time_cnt-1)+1:4*(time_cnt));
        H = (randn(4,4) + 1i*randn(4,4)) / sqrt(2);
        n = (randn(4,1) + 1i*randn(4,1)) / sqrt(2);
        symbol_rx_hat = H*x;
        y = symbol_rx_hat + 10^(-eb_n0(eb_n0_iter)/20)*n;
        H_sum_by_col = sum(abs(H),1);
        [HS,I] = sort(H_sum_by_col);
        O = zeros(4);
        for i = 1:4
            O(i,HS == H_sum_by_col(i)) = 1
        end
        [Q,R] = qr(H(:,I));
        z = Q'*y;
        symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = O*QAM64_sphere_decoder(z,R);
    end
    information_rx = zeros(length(information),1);
    information_rx = QAM64_decoder(symbol_rx,false);
    err = length(find(information_rx-information));
    if err < 100
       fprintf("[INFO] too less error bit!\n");
    end
    ber(eb_n0_iter) = err/samples;
end

toc;
fig = figure;
semilogy(eb_n0,ber,'-s');
grid on;
legend('Sphere decoding sorted Detection');
xlabel('Eb/N0(dB)');
ylabel('BER');
title('4x4 64 QAM Sphere decoding sorted detection with '+string(samples)+' samples');
axis([0 20 0.00001 1]);
writematrix([eb_n0,ber],'data/QAM64_sphere_decoding_sorted.txt');

end

