function [fft_size, data_size] = calc_fft_size(data_size_in, attrib)
% CALC_FFT_SIZE calculates the maximum size off fft possible from the data supplied.
% size of required fft can abe specified and will warn if too much or too little data has been supplied
%
%   [fft_size, data_size] = CALC_FFT_SIZE(data_size_in) 
%     Calculates best fft_size from data.
%
%   [fft_size, data_size] = CALC_FFT_SIZE(data_size_in, struct('fft_size',x))
%     Check fft of size x can be performed on data.
%
%   [fft_size, data_size] = CALC_FFT_SIZE(data_size_in, struct('offset',y))
%     Calculates best fft_size from data will ignoring the first y samples.
%
%   [fft_size, data_size] = CALC_FFT_SIZE(data_size_in, struct('fft_size',x,'offset',y))
%     Check fft of size x can be performed on data, ignoring the first y samples.
%
%   Example:
%     fft_size = CALC_FFT_SIZE(258);
%     => fft_size = 256
  if (nargin < 1)
    error(['calc_fft_size:args, Usage is calc_fft_size(data_size, [struct(''','offset''',', y, ''','fft_size''',',y)] )']);
  end
  
  if exist('attrib', 'var')
    if ~isfield(attrib, 'silent'   ) attrib.silent   = false;             end
    if ~isfield(attrib, 'offset'   ) attrib.offset   = 0;                 end
    if ~isfield(attrib, 'fft_size' ) attrib.fft_size = default_fft_size;  end
  else
    attrib.silent   = false;
    attrib.offset   = 0;
    attrib.fft_size = default_fft_size;
  end
  

  % Floor to an integer value
  fft_size  = floor(attrib.fft_size);
  data_size = data_size_in; 

  %% Too much data was supplied for FFT
  if (fft_size < (data_size_in - attrib.offset))
    data_size = fft_size + attrib.offset;
    if (~attrib.silent)
      disp([ ... 
        'FFT size (', num2str(fft_size), ')', ...
        ' < input data size (', num2str(data_size_in), ')', ... 
        ' - offset (', num2str(attrib.offset),')'] ...
      );
      warning('CalcFftSize:dataTruncation', 'calc_plot_fft: Input data is being truncated to match fft_size');

    end
  end

  %% Not enough data supplied for FFT
  if (fft_size > (data_size_in - attrib.offset))
    disp(['FFT size: ', num2str(fft_size), ', data size: ', num2str(data_size)]);
    error('calc_plot_fft:data_size Insufficient data for fft');
  end


  %% Embedded functions have access to all variables in parent
  function answer = default_fft_size
    answer = power(2, floor( log2(data_size_in - attrib.offset ) )) ;
  end

end %calc_fft_size

