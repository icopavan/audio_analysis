function y = calc_fft(data, fftsize)
  if (nargin < 2)
    error('calc_fft:args Usage is calc_fft(data, fftsize)');
  end
  [fftsize, datasize] = audio_analysis.calc_fft_size(size(data,1), struct('fft_size', fftsize));
  
%  Create separate windowing utility which can added as requirement.
%  http://www.mathworks.co.uk/help/dsp/ref/windowfunction.html
  window        = ones(fftsize, 1);
  windowed_data = window.*data(1:fftsize); 

  %% Perform FFT, Normalise then take magnitude of complex result
  %    Multiply by 2, because of the DFT-symmetry
  y             = 2 * abs( fft(windowed_data, fftsize)/fftsize );
end 
