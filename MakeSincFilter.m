function [H] = MakeSincFilter( df, F, Fs, Type, varargin)
    %   MAKESINCFILTER builds a FIR sinc 'Type' filter.
    %
    %   [ arg ] -> Mandatory argument.
    %   < arg > -> Optional/Conditional argument.
    %   
    %   Usage
    %   [H] = MakeSincFilter( df, F, Fs, Type, ... )
    %   
    %   Takes Following Arguments :
    %       [ df ]      : Transition Bandwidth in Hz
    %       [ F  ]      : Cutoff frequency or Center frequency in case Type is Bandpass or Stopband.
    %       [ Fs ]      : Sampling Frequency
    %       [ Type ]    : Filter Type string, i.e 'Low', 'High', 'Band' or 'Stop'.
    %       < B >       : Filter Pass or Stop Bandwidth, case type is Bandpass or Stopband 
    %
    %   Returns an array of coefficients for rectangular windowed Sinc Filter
    %       H : Sinc Filter Coefficients (a.k.a Filter Kernel)
    % -----------------------------------------------------------------------------------------
    %  file     : MakeSincFilter.m
    %  author   : Antonio Vitor-Grossi Bassi
    % -----------------------------------------------------------------------------------------   
	N = ceil(Fs/df);
    
	% Even order adjust
	if rem( N, 2 ) == 0
        N = N + 1;
	end

	W = -(N - 1)/2 : (N - 1)/2; % Filter Length
    W( W == 0 ) = 1e-9;
    
	% H = ( ( 1 / pi ) * sin( 2 * pi * ( B / Fs ) * W ) )./ W; % Sinc Filter coefficients

    if( strcmp( Type, 'Low' ) )
        Fc = F / Fs;
        H = sinc( 2 * Fc * W );
        H = H ./ sum( H );
    elseif(strcmp( Type, 'High' ))
        Fc = F / Fs; 
        H = sinc( 2 * Fc * W );
        H = H ./ sum( H );
        dd = zeros( size(W) );
        dd(W == 1e-9) = 1;
        H = dd - H;
    elseif(strcmp( Type, 'Band' ))
        B = varargin{1};
        if B <= 0
            error('Error! Invalid Bandwidth, insert a bandwidth greater than 0!');
        end
        delta = (B^2) + 4*(F^2);
        Fc1 = (-B + sqrt(delta))/(2 * Fs );
        Fc2 = (-B - sqrt(delta))/(-2 * Fs );
        
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

    elseif(strcmp( Type, 'Stop'))
        B = varargin{1};
        if B <= 0
            error('Error! Invalid Bandwidth, insert a bandwidth greater than 0!');
        end
        delta = (B^2) + 4*(F^2);
        Fc1 = (-B + sqrt(delta))/(2 * Fs );
        Fc2 = (-B - sqrt(delta))/(-2 * Fs );
        % Compute Cutoff frequencies
        
        % Compute Dirac
        dd = zeros( size(W) );
        dd(W == 1e-9) = 1;
        
        % Compute Highpass Transform
        H = sinc( 2 * Fc2 * W );
        H = H ./ sum( H );
        Hhp = dd - H;
        
        % Compute Lowpass
        H = sinc( 2 * Fc1 * W );
        H = H ./ sum( H );
        Hlp = H;

        % Bandpass Transformation
        H = Hlp + Hhp;
    else
        error("Unknown Type of filter");
        return;
    end
end
