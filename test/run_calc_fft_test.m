function run_calc_fft_test
%RUN_CALC_FFT_TEST Test for calc_fft

  clear;
   
  % Add package path
  addpath('../package/');

  % import functions
  import audio_analysis.* ;

  %% Parameters of generated data
  fs              = 48000       ; % Hz
  sine_freq       = 993         ; % Hz
  sine_magnitude  = 10^(-0.1/20); % -0.1dB
  fftsize         = 65536       ; 

  %% Coherent frequency
  fft_resolution  = fs/fftsize; 
  sine_freq       = floor(sine_freq/fft_resolution)*fft_resolution ;

  %% Create test data
  sim_length      = fftsize/fs            ;  % run sim for this time
  t               = 0:1/fs:sim_length-1/fs;                

  data            = ((sine_magnitude)*sin(2*pi*sine_freq*t))';

  measurement     = audio_analysis.calc_fft(data, fftsize);
  
  % Visualise data until Pass/Fail test added
  plot( 20*log10(measurement) );

  error('No Pass/Fail criteria')

end

