%% Generate the training data
clear
clc

digits = '0123456789';
noisefactors = 1:0.5:3;
nImages = 10; %samples per digit, fonts, noise factor

font.name{1} = 'times';
font.name{2} = 'charm';
font.name{3} = 'canela';
font.name{4} = 'optima';
font.name{5} = 'arial';
font.name{6} = 'georgia';
font.name{7} = 'impact';
font.name{8} = 'sathu';
font.name{9} = 'courier';
font.name{10}= 'serif';

nDigits = numel(digits);
nFont = size(font.name,2);
nNoise = numel(noisefactors);
nSamples = nFont*nNoise*nImages;

for j = 1:nDigits
    fprintf('Digit %s\n', digits(j));
    for jj = 1:nFont
        for k = 1:nNoise
            for kk = 1:nImages
                pixels = CreateDigitImage(digits(j) , font.name{jj}, noisefactors(k)); 
                % scale the pixels to a range 0 to 1
                pixels = double(pixels);
                pixels = pixels/255;
                if exist(['synthetic',filesep, digits(j)])==0
                    mkdir(['synthetic',filesep, digits(j)])
                end
                imwrite(pixels,['synthetic',filesep, digits(j), filesep, 'digit_',digits(j),'_',num2str(jj),'_',num2str(k),'_',num2str(kk),'.jpg']);
                imagesc(pixels); axis image; title(num2str(kk))
            end
        end
    end
end