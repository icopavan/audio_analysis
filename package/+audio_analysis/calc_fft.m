function y = calc_fft(data, fftsize)
  if (nargin < 2)
    error('calc_fft:args Usage is calc_fft(data, fftsize)');
  end
  [fftsize, datasize] = calc_fft_size(size(data,1), struct('fft_size', fftsize));
  
%  Create separate windowing utility which can added as requirement.
%  http://www.mathworks.co.uk/help/dsp/ref/windowfunction.html
  window        = blackman(fftsize);
  windowed_data = window.*data(1:datasize);

  %% Perform FFT, Normalise then take magnitude of complex result
  y             = abs( fft(windowed_data, fftsize)/fftsize );
end %calc_fft
