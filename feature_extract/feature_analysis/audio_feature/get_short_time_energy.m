%% calculate the short time energy of audio siganl in a frame
% - ste = get_short_time_energy(audio_signal)
% - Variable:
% ------------------------------------------input
% audio_signal          audio signal
% -----------------------------------------output
% zcr                   zero crossing rate of audio signal in a frame

function ste = get_short_time_energy(audio_signal)

ste = 0;
[length, ~] = size(audio_signal);

for i = 1:length
    ste = ste + audio_signal(i) * audio_signal(i);
end

end