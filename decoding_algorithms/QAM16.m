%samples=100;
function QAM16(samples)
fprintf('16 QAM detection with '+string(samples)+' samples\n');
eb_n0 = (0:2:20)';
zf_ber = zeros(length(eb_n0),1);
mmse_ber = zeros(length(eb_n0),1);
kbest_ber = zeros(length(eb_n0),1);
kbest_sorted_ber = zeros(length(eb_n0),1);
sd_ber = zeros(length(eb_n0),1);
sd_sorted_ber = zeros(length(eb_n0),1);
tic;
parfor eb_n0_iter = 1:length(eb_n0)
    information = randi(2,samples*(eb_n0(eb_n0_iter)+1),1)-1;
    symbol_tx = QAM16_encoder(information);
    rho = db2pow(eb_n0(eb_n0_iter));
    zf_symbol_rx = zeros(length(symbol_tx),1);
    mmse_symbol_rx = zeros(length(symbol_tx),1);
    kbest_symbol_rx = zeros(length(symbol_tx),1);
    kbest_sorted_symbol_rx = zeros(length(symbol_tx),1);
    sd_symbol_rx = zeros(length(symbol_tx),1);
    sd_sorted_symbol_rx = zeros(length(symbol_tx),1);
    for time_cnt = 1:length(symbol_tx)/4
        x = ((sqrt(4) / sqrt(4)) / sqrt(10)) * symbol_tx(4*(time_cnt-1)+1:4*(time_cnt));
        H = (randn(4,4) + 1i*randn(4,4)) / sqrt(2);
        n = (randn(4,1) + 1i*randn(4,1)) / sqrt(2);
        symbol_rx_hat = H*x;
        y = symbol_rx_hat + 10^(-eb_n0(eb_n0_iter)/20)*n;
        %ZF
        zf_H_psudo_inv = inv(H'*H)*H';   %pinv(H); %H'*H\H'; %inv(H'*H)*H';
        zf_symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = zf_H_psudo_inv*y;
        %MMSE
        mmse_H_psudo_inv = inv(H'*H+eye(4)/rho)*H';
        mmse_symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = mmse_H_psudo_inv*y;
        %kbest
        [kbest_Q,kbest_R] = qr(H);
        kbest_z = kbest_Q'*y;
        kbest_symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = QAM16_KBEST_decoder(kbest_z,kbest_R);
        %kbest_sorted
        kbest_sorted_H_sum_by_col = sum(abs(H),1);
        [kbest_sorted_HS,kbest_sorted_I] = sort(kbest_sorted_H_sum_by_col);
        kbest_sorted_O = zeros(4);
        for i = 1:4
            kbest_sorted_O(i,kbest_sorted_HS == kbest_sorted_H_sum_by_col(i)) = 1
        end
        [kbest_sorted_Q,kbest_sorted_R] = qr(H(:,kbest_sorted_I));
        kbest_sorted_z = kbest_sorted_Q'*y;
        kbest_sorted_symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = kbest_sorted_O*QAM16_KBEST_decoder(kbest_sorted_z,kbest_sorted_R);
        %sd
        sd_symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = QAM16_sphere_decoder(kbest_z,kbest_R);
        %sd_sorted
        sd_sorted_symbol_rx(4*(time_cnt-1)+1:4*(time_cnt)) = kbest_sorted_O*QAM16_sphere_decoder(kbest_sorted_z,kbest_sorted_R);

    end
    %zf
    zf_information_rx = QAM16_decoder(zf_symbol_rx,true);
    zf_err = length(find(zf_information_rx-information));
    zf_ber(eb_n0_iter) = zf_err/(samples*(eb_n0(eb_n0_iter)+1));
    %mmse
    mmse_information_rx = QAM16_decoder(mmse_symbol_rx,true);
    mmse_err = length(find(mmse_information_rx-information));
    mmse_ber(eb_n0_iter) = mmse_err/(samples*(eb_n0(eb_n0_iter)+1));
    %kbest
    kbest_information_rx = QAM16_decoder(kbest_symbol_rx,false);
    kbest_err = length(find(kbest_information_rx-information));
    kbest_ber(eb_n0_iter) = kbest_err/(samples*(eb_n0(eb_n0_iter)+1));
    %kbest
    kbest_sorted_information_rx = QAM16_decoder(kbest_sorted_symbol_rx,false);
    kbest_sorted_err = length(find(kbest_sorted_information_rx-information));
    kbest_sorted_ber(eb_n0_iter) = kbest_sorted_err/(samples*(eb_n0(eb_n0_iter)+1));
    %sd
    sd_information_rx = QAM16_decoder(sd_symbol_rx,false);
    sd_err = length(find(sd_information_rx-information));
    sd_ber(eb_n0_iter) = sd_err/(samples*(eb_n0(eb_n0_iter)+1));
    %sd_sorted
    sd_sorted_information_rx = QAM16_decoder(sd_sorted_symbol_rx,false);
    sd_sorted_err = length(find(sd_sorted_information_rx-information));
    sd_sorted_ber(eb_n0_iter) = sd_sorted_err/(samples*(eb_n0(eb_n0_iter)+1));
    

end


writematrix([eb_n0,zf_ber],'data/QAM16_zero_forcing.txt');
writematrix([eb_n0,mmse_ber],'data/QAM16_MMSE.txt');
writematrix([eb_n0,kbest_ber],'data/QAM16_KBEST.txt');
writematrix([eb_n0,kbest_sorted_ber],'data/QAM16_KBEST_sorted.txt');
writematrix([eb_n0,sd_ber],'data/QAM16_sphere_decoding.txt');
writematrix([eb_n0,sd_sorted_ber],'data/QAM16_sphere_decoding_sorted.txt');
end

