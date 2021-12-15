function [Wg] = blackmanWin( g, alpha )
    % BLACKMANWIN Performs windowing of impulse response using blackman's window
    %   [Wg] = blackmanWin( g )
    %   Wg   :   Windowed signal
    %   Returns an array Wg containing windowed signal.
    %   g   : signal or impulse response to be windowed.
    % ---------------------------------------------------------------------------------------------
    %  file     : blackmanWin.m
    %  author   : Antonio Vitor-Grossi Basssi
    % ---------------------------------------------------------------------------------------------
    % By common convention, the unqualified term Blackman window refers to Blackman's "not very 
    % serious proposal" of alpha = 0.16 (a0 = 0.42, a1 = 0.5, a2 = 0.08), which closely approximates 
    % the exact Blackman,[41] with a0 = 7938/18608 ~= 0.42659, a1 ~= 9240/18608 ~= 0.49656, and 
    % a2 ~= 1430/18608 ~= 0.076849.[42] These exact values place zeros at the third and fourth 
    % sidelobes,[9] but result in a discontinuity at the edges and a 6 dB/oct fall-off. The 
    % truncated coefficients do not null the sidelobes as well, but have an improved 18 dB/oct 
    % fall-off.[9][43]
    %
    % [41]  Weisstein, Eric W. "Blackman Function". mathworld.wolfram.com. Retrieved 2016-04-13.
    %
    % [42]  "Characteristics of Different Smoothing Windows - NI LabVIEW 8.6 Help". zone.ni.com. 
    %       Retrieved 2020-02-13.
    %
    % [43]  Blackman, R.B.; Tukey, J.W. (1959-01-01). The Measurement of Power Spectra from the 
    %       Point of View of Communications Engineering. Dover Publications. p. 99. 
    %       ISBN 9780486605074.
    %
    % [9]   Harris, Fredric J. (Jan 1978). "On the use of Windows for Harmonic Analysis with the 
    %       Discrete Fourier Transform" (PDF). Proceedings of the IEEE. 66 (1): 51–83. Bibcode:
    %       1978IEEEP..66...51H. CiteSeerX 10.1.1.649.9880. doi:10.1109/PROC.1978.10837. S2CID 
    %       426548. The fundamental 1978 paper on FFT windows by Harris, which specified many 
    %       windows and introduced key metrics used to compare them.
    % 
    % [!] Text above was taken from wikipedia article about spectrum windows and window functions.
    % ---------------------------------------------------------------------------------------------
    L = length( g ); % window length
    
    a = ( 1 - alpha ) / 2;
    b = 0.5;
    c = alpha / 2;
    W = a - b * cos( 2 * pi * ( 0 : L - 1 )/( L - 1 ) ) + c * cos( 4 * pi * ( 0 : L - 1 )/( L - 1 ) );
    Wg = g.*W;
end