%% calculate the zero crossing rate of audio siganl in a frame
% - zcr = get_zero_crossing_rate(audio_signal, frame_length)
% - Variable:
% ------------------------------------------input
% audio_signal          audio signal
% -----------------------------------------output
% zcr                   zero crossing rate of audio signal in a frame

function zcr = get_zero_crossing_rate(audio_signal)

zcr = 0;
[length, ~] = size(audio_signal);

for i = 1:length-1
    zcr = zcr + 0.5 * abs((sign(audio_signal(i)) - sign(audio_signal(i+1))));
end

zcr = int32(zcr);

end