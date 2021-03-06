clear ; clc ; close all;

%% PRÉLIMINAIRE 1

% Bruit blanc

N = 2^20; % Nombre de points
sigma = 2; % Ecart type
mu = 0; % Moyenne

% Génération du bruit
b = mu + randn(1,N)*sigma;

% Théorie : Rbb(tau) = sigma^2*delta(tau)

% Estimateur biaisé
Rbb_b = xcorr(b, 'biased');
figure, plot(-N+1:N-1, Rbb_b), title('Estimateur biaisé'), xlabel('tau'), ylabel('Rbb');
% Estimateur non biaisé
Rbb_nb = xcorr(b, 'unbiased');
figure, plot(-N+1:N-1, Rbb_nb), title('Estimateur non biaisé'), xlabel('tau'), ylabel('Rbb');

% Spectre de puissance
SP = abs(fftshift(fft(b))).^2/(2*N);
% figure, stem(-N/2:N/2-1, SP), title('SP');

% Densité spectrale de puissance
% figure, plot(-N+1:N-1, sigma^2*ones(1,2*N-1)), title('DSP');

%% 

Nfft = 2^10; % Nombre de points pour la fft
window = hamming(Nfft); % Fenêtre
rec = 2^6; % Recouvrement de rec points
k = floor(N/Nfft); % Nombre de découpage
pw = zeros(Nfft, 1); % Matrice du periodogramme
index = 1;
i = 0;

% Periodogramme de Welch
while index+Nfft-1 < length(b)
    xwindow = window.*b(index:index+Nfft-1)'; % Fenêtrage
	index = index + Nfft - rec; % Décalage de l'indice
    i = i+1;
    pw = pw + abs(fftshift(fft(xwindow, Nfft).^2)); % Ajout à la matrice
end

pw = pw./(i*norm(window)^2); % Normalisation
figure, plot(-Nfft/2:Nfft/2-1,pw);

% Periodogramme de Daniell

% Corrélogramme
Rbb = xcorr(b);
C = abs(fftshift(fft(Rbb)))/(2*N);
% figure, stem(-N+1:N-1,C); % Equivalent SP



