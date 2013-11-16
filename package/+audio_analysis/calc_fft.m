function [norm_fft_result, norm_power_spec] = calc_fft(data, fftsize)
  if (nargin < 2)
    error('calc_fft:args Usage is calc_fft(data, fftsize)');
  end
  [fftsize, datasize] = audio_analysis.calc_fft_size(size(data,1), struct('fft_size', fftsize));
  
  %% If data oversized remove offset
  if length(data) > fftsize
    data          = data(end-fft_size+1:end);
  end

  if length(data) < fft_size
    error('audio.analysis.perform_norm_fft data length less than requested fft_length.')
  end
   w.window              = ones(fftsize, 1);
   w.incoherent_power_gain = fftsize;

   try
     windowed_data         = (data).*(w.window);  
   catch ME
     if (strcmp(ME.identifier,'MATLAB:dimagree'))
        msg = ['Dimension mismatch occurred: \n', ...
               '  Data is   : ', num2str(size(data)), '.\n', ...
               '  Window is : ', num2str(size(w.window)),'.'];
        causeException = MException('MATLAB:myCode:dimensions',msg);
        ME = addCause(ME,causeException);
     end
     rethrow(ME)
   end  
   
   %% Perform FFT, Normalise then take magnitude of complex result
   fft_result            = abs( fft(windowed_data) );
   power_spectrum        = fft_result.^2  ;  
  
   norm_power_spec       = (4 * power_spectrum ) / (w.incoherent_power_gain*fftsize);
   norm_fft_result       = sqrt(norm_power_spec);
end 
