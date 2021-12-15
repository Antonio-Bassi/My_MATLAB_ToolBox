function [f,P] = PSDx( h, Fs )
    %   PSDx computes the Power Spectral Density of given signal.
    %   [f,P] = PSDx( h, Fs )
    %       P : Power Spectral Density of given signal
    %       f : Frequency spectrum array.
    %   Returns two arrays containing the resulting PSD and frequency Spectrum
    %       h : Signal to have it's PSD computed
    %       Fs : Sampling Rate
    % -----------------------------------------------------------------------------------------
    %  file     : PSDx.m
    %  author   : Antonio Vitor-Grossi Basssi
    % ----------------------------------------------------------------------------------------- 
    
    N = length( h );
    L = pow2( nextpow2( N ) );
    P = fft(h,L);
    P = P( 1 : L/2 + 1 );
    P(2:end-1) = 2 * P(2:end-1);
    P = 10 * log10( P );
    f = 0 : Fs / L : Fs / 2;
end