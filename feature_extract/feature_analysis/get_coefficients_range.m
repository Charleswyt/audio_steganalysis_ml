% - [min_cover_coeff, max_cover_coeff, min_stego_coeff, max_stego_coeff] = ...
%       get_coefficients_range(cover_qmdct_file_path, stego_qmdct_file_path)
% get the range of  embedding rate via the number of modication dots in time domain
% - Variable:
% ------------------------------------------input
% cover_qmdct_file_path           path of cover qmdct file
% stego_qmdct_file_path           path of stego qmdct file
% -----------------------------------------output
% [min_coeff, max_coeff]          the minimum and maximum of coefficients

function [min_cover_coeff, max_cover_coeff, min_stego_coeff, max_stego_coeff] = ...
    get_coefficients_range(cover_qmdct_file_path, stego_qmdct_file_path)

try
    cover = load(cover_qmdct_file_path);
    stego = load(stego_qmdct_file_path);
    diff = cover - stego;
    position = (diff ~= 0);
    
    cover_modified = cover(position);
    stego_modified = stego(position);
    
    min_cover_coeff = min(cover_modified);
    max_cover_coeff = max(cover_modified);
    min_stego_coeff = min(stego_modified);
    max_stego_coeff = max(stego_modified);
    
    tab_cover = tabulate(cover_modified(:));
    tab_stego = tabulate(stego_modified(:));
    
    figure(1);plot(tab_cover(:,1), tab_cover(:,3));
    xlabel('coefficients value');ylabel('Percentage(%)');
    title('Modified coefficients in cover');
    
    figure(2);plot(tab_stego(:,1), tab_stego(:,3));
    xlabel('coefficients value');ylabel('Percentage(%)');
    title('Modified coefficients in stego');
    
    fprintf('minimum of coefficients in cover QMDCT file is %d.\n', min_cover_coeff);
    fprintf('maximum of coefficients in cover QMDCT file is %d.\n', max_cover_coeff);
    fprintf('minimum of coefficients in stego QMDCT file is %d.\n', min_stego_coeff);
    fprintf('maximum of coefficients in stego QMDCT file is %d.\n', max_stego_coeff);
catch
    fprintf('Error: format is not correct or file dose not exist, please try again.\n');
end

end