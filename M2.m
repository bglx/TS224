clear; clc; close all;

% hankel
% svd

%% Préliminaire 2

load("fcno03fz.mat");

fe = 8e3; % Fréquence échantillonnage
T = 0:1/fe:length(fcno03fz)/fe-1/fe; % Echelle de temps

% Bruit blanc

N = length(fcno03fz); % Nombre de points
mu = 0; % Moyenne
db = 5;

% Génération du bruit
Pbr  = (10^(db/10));
Psig = sum(fcno03fz.^2)/N;
sigm = Psig/Pbr;

s = fcno03fz' + randn(1,N).*sqrt(sigm);

figure;
subplot_axis(T, fcno03fz, 211, "Signal original", "Temps (s)", "Amplitude");
subplot_axis(T, s, 212, "Signal bruité", "Temps (s)", "Amplitude");

% Spectrogramme

Nfft = 2^8;

figure;
subplot 121, spectrogram(s, ones(1,Nfft), 128, Nfft, fe);
title("Signal bruité");
subplot 122, spectrogram(fcno03fz, ones(1,Nfft), 128, Nfft, fe);
title("Signal original");