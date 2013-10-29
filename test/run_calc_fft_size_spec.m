function run_calc_fft_spec;
  clear;
   
  % Add package path
  addpath('../package/');

  % import functions
  import audio_analysis.* ;
 
% Command we are testing  
% function [datasize, fftsize] = audio_analysis.calc_fft_size(datasize_in, fftsize_in, data_offset)
 
%% Basic power of 2 tests
%%test_data_only(d_size, want_d_size, want_fft_size)
test_data_only(  64,   64,   64)
test_data_only( 128,  128,  128)
test_data_only( 256,  256,  256)
test_data_only( 512,  512,  512)
test_data_only( 513,  512,  512)
test_data_only(1023,  512,  512)
test_data_only(1024, 1024, 1024)
test_data_only(1025, 1024, 1024)

test_data_and_offset(  64, 0,   64,   64)
test_data_and_offset( 128, 0,  128,  128)
test_data_and_offset( 256, 0,  256,  256)
test_data_and_offset( 512, 0,  512,  512)
test_data_and_offset( 513, 0,  512,  512)
test_data_and_offset(1023, 0,  512,  512)
test_data_and_offset(1024, 0, 1024, 1024)
test_data_and_offset(1025, 0, 1024, 1024)

test_data_and_offset(  65, 1,   65,   64)
test_data_and_offset( 129, 1,  129,  128)
test_data_and_offset( 257, 1,  257,  256)
test_data_and_offset( 512, 1,  257,  256)
test_data_and_offset( 513, 1,  513,  512)
test_data_and_offset(1023, 1,  513,  512)
test_data_and_offset(1024, 1,  513,  512)
test_data_and_offset(1025, 1, 1025, 1024)

  function test_data_only(d_size, want_d_size, want_fft_size)
    [datasize_result, fftsize_result] = audio_analysis.calc_fft_size( d_size );

    if (datasize_result ~= want_d_size)
      disp(' ');
      error(['calc_fft_size: data_size incorrect should be', ...
        num2str(want_d_size), ...
        ' was ', num2str(datasize_result),'.']); 
    end 
    

    if (fftsize_result ~= want_fft_size)  
      disp(' ');
      error(['calc_fft_size: fft_size  incorrect should be ', ...
      num2str(want_fft_size), ...
      'was ', num2str(fftsize_result),'.']); 
    end 

  end %% endfunction


  function test_data_and_offset(d_size, offset, want_d_size, want_fft_size)
    [fftsize_result, datasize_result] = audio_analysis.calc_fft_size( d_size, struct('offset',offset));

    if (datasize_result ~= want_d_size)
      disp(' ');
      error(['calc_fft_size: data_size incorrect should be ', ...
        num2str(want_d_size), ...
        ' was ', num2str(datasize_result),'.']); 
    end 
    

    if (fftsize_result ~= want_fft_size)  
      disp(' ');
      error(['calc_fft_size: fft_size  incorrect should be ', ...
        num2str(want_fft_size), ...
        'was ', num2str(fftsize_result),'.']); 
    end 
  end %% endfunction


  function test_data_and_fftsize(d_size, fftsize, want_d_size, want_fft_size)
    [fftsize_result, datasize_result] = audio_analysis.calc_fft_size( d_size, struct('fft_size',fftsize));

    if (datasize_result ~= want_d_size)
      disp(' ');
      error(['calc_fft_size: data_size incorrect should be ', ...
        num2str(want_d_size), ...
        ' was ', num2str(datasize_result),'.']); 
    end 
    

    if (fftsize_result ~= want_fft_size)  
      error(['calc_fft_size: fft_size  incorrect should be ', ...
      num2str(want_fft_size), ...
      'was ', num2str(fftsize_result),'.']); 
    end 
  end %% endfunction

end %% endfunction
