
% EEG ANALYSIS
ERP= mean(ALLEEG(2).data, 3);
figure
for i=1:32
 subplot(6,6,i)
 plot(EEG.times,ERP(i,:))
 ylim([-100 100])
 xlim([-200 2800])
 hold on
 title(EEG.chanlocs(i).labels);
 ylabel("Amplitud [μV]")
 xlabel("Tiempo [ms]")
 hold off

end

amplitudesprom = zeros(1, 32);
for i = 1:32
 amplitudesprom(i) = mean(abs(ERP(i,:)));
end

%Subtract the previous maps (greater amplitude minus lower amplitude) and graph in a 1x1 figure the 
% Resulting difference


[max_amplitud, max_canal] = max(amplitudesprom);
[min_amplitud, min_canal] = min(amplitudesprom);
figure
plot(EEG.times, ERP(max_canal,:))
hold on
title("Channel with the higher amplitude", EEG.chanlocs(max_canal).labels)
ylabel("Amplitude [μV]")
xlabel("Time [ms]")
hold off

% Estima la cantidad de ruido en cada uno de los ERPs e imprime en cada subplot de la figura 1, el ruido 
% para cada cana

plots = size(ERP, 1);
ref = (ERP(:, 1:(256*0.5))');
dev = std(ref);
SNR = amplitudesprom./dev;
figure
bar(SNR)

figure
for i = 1:plots 
 subplot(8, 4, i)
 plot(ALLEEG(3).times, SNR(i))
 tx = strcat(string(EEG.chanlocs(i).labels)," || SNR = ",string(SNR(i)));
 title(tx);
 xlabel('Tiempo [ms]');
 ylabel('Amplitud [μV]');
end

%INDUCED ACTIVITY 

FzL = ALLEEG(3).data(24,:,:); % 1ch x (256x3) samples x 50 epochs
%cwt
WT_epochsL =zeros(67,ALLEEG(3).pnts,size(ALLEEG(3).data,3));
for eL = 1:size(FzL,3)
 [wtL, fL] = cwt(FzL(1,:,eL),'morse',ALLEEG(3).srate); 
 WT_epochsL(:,:,eL) = abs(wtL);
end
erders_mapL = mean(WT_epochsL,3); %P(t,f)
RL= mean(erders_mapL(:,1:67),2);
FinalL = log10(erders_mapL./RL);
figure
imagesc(EEG.times, fL, FinalL)
title("ERD/ERS_ mayor amplitud maxima (P3)")
xlabel("Time [s]")
ylabel("Frecuencia [Hz]")
cbar=colorbar;
cbar.Label.String = "Ratio [dB]"

% identifies the channel with the lowest average amplitude and estimates its ERD/ERS map in 
% Decibels.
p_min = zeros(1, 32);
for e = 1:32
 p_min(e) = min(RP_i(e, :));
end
amp_promin = zeros(1, 32);
for e = 1:32
 amp_promin(e) = abs(mean(RP_i(e, :)));
end
p_prommin = mean(p_min);
amp_min = min(p_min);
c_pmin = find(p_min == amp_min);
canalmin = "P3";
amp_minprom = min(amp_promin);
c_prommin = find(amp_promin == amp_minprom);
canalprommin = "Fz";

%MIN PROM
FzLmin = ALLEEG(3).data(7,:,:); % 1ch x (256x3) samples x 50 epochs
%cwt
WT_epochsLmin =zeros(67,ALLEEG(3).pnts,size(ALLEEG(3).data,3));
for eLmin = 1:size(FzLmin,3)
 [wtLmin, fLmin] = cwt(FzLmin(1,:,eLmin),'morse',ALLEEG(1).srate); 
 WT_epochsLmin(:,:,eLmin) = abs(wtLmin);
end
erders_mapLmin = mean(WT_epochsLmin,3); %P(t,f)
RLmin= mean(erders_mapLmin(:,1:67),2);
FinalLmin = log10(erders_mapLmin./RLmin);
figure
imagesc(EEG.times, fLmin, FinalLmin)
title("ERD/ERS_ Minimum mean amplitude(Fz)")
xlabel("Time [ms]")
ylabel("Frequency [Hz]")
cbar=colorbar;
cbar.Label.String = "Ratio [dB]";

%Subtract the previous maps (greater amplitude minus lower amplitude) and graph in a 1x1 figure the 
% Resulting difference
R_amplitudes = FinalLmaxprom - FinalLmin;
figure
imagesc(EEG.times, fLmin, R_amplitudes)
title("Difference between higher average amp and lower average amplitude")
xlabel('Time [ms]')
ylabel('Frequency [Hz]')
color = colorbar;
color.Label.String = 'Ratio [dB]';





