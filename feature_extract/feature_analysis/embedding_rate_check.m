% - modification_percentage = embedding_rate_check(cover_audio_path, stego_audio_path)
% get the relative embedding rate via the number of modication dots in time domain
% - Variable:
% ------------------------------------------input
% cover_audio_path                path of cover audio
% stego_audio_path                path of stego audio
% -----------------------------------------output
% modification_percentage         relative embedding rate

function modification_percentage = embedding_rate_check(cover_audio_path, stego_audio_path)

try
    [cover, fs] = audioread(cover_audio_path);
    stego = audioread(stego_audio_path);
    diff = cover(:,1) - stego(:,1);
    
    modification = diff(diff~=0);
    diff_length = length(modification);
    time = 50 * (10 / 384);                                                 % frame * second / frame
    modification_percentage = diff_length / (fs * time);

    fprintf('relative embedding rate: %.2f%%\n', 100*modification_percentage);
%     plot(diff(:,1));
catch
    fprintf('Error: format is not correct or file dose not exist, please try again.\n');
end

end