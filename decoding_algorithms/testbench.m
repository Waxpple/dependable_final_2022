% TESTBENCH
% QAM16_zero_forcing(600000);
% QAM16_MMSE(600000);
% QAM16_KBEST(600000);
% QAM16_KBEST_sorted(600000);
% QAM16_sphere_decoding(600000);
% QAM16_sphere_decoding_sorted(600000);
QAM16(100000);
ber_0 = readmatrix('data/QAM16_zero_forcing.txt');
ber_1 = readmatrix('data/QAM16_MMSE.txt');
ber_2 = readmatrix('data/QAM16_KBEST.txt');
ber_3 = readmatrix('data/QAM16_KBEST_sorted.txt');
ber_4 = readmatrix('data/QAM16_sphere_decoding.txt');
ber_5 = readmatrix('data/QAM16_sphere_decoding_sorted.txt');

fig = figure('Renderer', 'painters', 'Position', [10 10 1440 720]);

semilogy(ber_0(:,1),ber_0(:,2),'-s',ber_1(:,1),ber_1(:,2),'-o',ber_2(:,1),ber_2(:,2),'-x',ber_3(:,1),ber_3(:,2),'-+',ber_4(:,1),ber_4(:,2),'-d',ber_5(:,1),ber_5(:,2),'-v');
legend('Zero-forcing Detection','MMSE Detection','KBEST Detection','KBEST sorted Detection','Sphere decoding Detection','Sphere decoding sorted Detection','Location','bestoutside'	);
xlabel('Eb/N0(dB)');
ylabel('BER');
title('4x4 16 QAM detection comparison');
axis([0 20 0.00001 1]);
grid on;
saveas(fig,'16QAM.png')
% TESTBENCH
% QAM64_zero_forcing(600000);
% QAM64_MMSE(600000);
% QAM64_KBEST(600000);
% QAM64_KBEST_sorted(600000);
% QAM64_sphere_decoding(600000);
% QAM64_sphere_decoding_sorted(600000);
QAM64(60000);
ber_6 = readmatrix('data/QAM64_zero_forcing.txt');
ber_7 = readmatrix('data/QAM64_MMSE.txt');
ber_8 = readmatrix('data/QAM64_KBEST.txt');
ber_9 = readmatrix('data/QAM64_KBEST_sorted.txt');
ber_10 = readmatrix('data/QAM64_sphere_decoding.txt');
ber_11 = readmatrix('data/QAM64_sphere_decoding_sorted.txt');


fig = figure('Renderer', 'painters', 'Position', [10 10 1440 720]);
semilogy(ber_6(:,1),ber_6(:,2),'-s',ber_7(:,1),ber_7(:,2),'-o',ber_8(:,1),ber_8(:,2),'-x',ber_9(:,1),ber_9(:,2),'-+',ber_10(:,1),ber_10(:,2),'-d',ber_11(:,1),ber_11(:,2),'-v');
legend('Zero-forcing Detection','MMSE Detection','KBEST Detection','KBEST sorted Detection','Sphere decoding Detection','Sphere decoding sorted Detection','Location','bestoutside'	);
xlabel('Eb/N0(dB)');
ylabel('BER');
title('4x4 64 QAM detection comparison');
axis([0 20 0.00001 1]);
grid on;
saveas(fig,'64QAM.png')