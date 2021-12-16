function [H] = MakeSincFilter( df, B, Fs, Type )
    %   MAKESINCFILTER builds a FIR sinc lowpass filter.
    %   [H] = MakeSincFilter( df, B, Fs, Type )
    %       H : Sinc Filter Coefficients (a.k.a Filter Kernel)
    %   Returns an array containing coefficients for rectangular windowed Sinc Filter
    %       df : Transition Bandwidth in Hz
    %       B  : Filter Bandwidth
    %       Fs : Sampling Frequency
    %       Type : Filter Type string, that is 'Low', 'High', 'Band' and 'Stop'.
    % -----------------------------------------------------------------------------------------
    %  file     : MakeSincFilter.m
    %  author   : Antonio Vitor-Grossi Basssi
    % -----------------------------------------------------------------------------------------   
	
	N = ceil(Fs/df);
    
	% Even order adjust
	if rem( N, 2 ) == 0
		N = N + 1;
	end

	W = -(N - 1)/2 : (N - 1)/2; % Filter Length
    W( W == 0 ) = 1e-9;
    Fc = B / Fs;
	% H = ( ( 1 / pi ) * sin( 2 * pi * ( B / Fs ) * W ) )./ W; % Sinc Filter coefficients
    H = sinc( 2 * Fc * W );
    H = H ./ sum( H );

    if( strcmp( Type, 'Low' ) )
        % return last result
    elseif(strcmp( Type, 'High' ))
        dd = zeros( size(W) );
        dd(W == 1e-9) = 1;
        H = dd - H;
    elseif(strcmp( Type, 'Band' ))
        % Compute Cutoff frequencies
        Fc1 = B / Fs;
        Fc2 = ( 8 * B ) / Fs;

        % Compute Dirac
        dd = zeros( size(W) );
        dd(W == 1e-9) = 1;

        % Compute Highpass Transform
        H = sinc( 2 * Fc1 * W );
        H = H ./ sum( H );
        Hhp = dd - H;

        % Compute Lowpass
        H = sinc( 2 * Fc2 * W );
        H = H ./ sum( H );
        Hlp = H;

        % Bandpass Transformation
        H = conv(Hlp, Hhp);

    elseif(strcmp( Type, 'Stop' ))
    else
    end
end
