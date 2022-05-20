function [H] = MakeSincFilter( df, F, Fs, Type)
    %   MAKESINCFILTER builds a FIR sinc 'Type' filter.
    %   [H] = MakeSincFilter( df, B, Fs, Type )
    %       H : Sinc Filter Coefficients (a.k.a Filter Kernel)
    %   Returns an array containing coefficients for rectangular windowed Sinc Filter
    %       df : Transition Bandwidth in Hz
    %       F  : Cutoff or array of 2 frequencies in case Type is Bandpass or Stopband.
    %       Fs : Sampling Frequency
    %       Type : Filter Type string, i.e 'Low', 'High', 'Band' or 'Stop'.
    %
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
        % Compute Cutoff frequencies
        [r,c] = size( F );
        if( ( r == 1 && c == 1) || ( r > 2 || c > 2 ) )
            err = "Error! Input argument *F* is not a valid array of frequencies!";
            err = err + newline + "Either provide a 1 x 2 array or a 2 x 1 array.";
            error(err);
            return;
        end
        
        if( r > c )
            if( F(1,1) < F(2,1) )
                Fc1 = F(1,1) / Fs;
                Fc2 = F(2,1) / Fs;
            else
                Fc1 = F(2,1) / Fs;
                Fc2 = F(1,1) / Fs;
            end
        else
            if( F(1,1) < F(1,2) )
                Fc1 = F(1,1) / Fs;
                Fc2 = F(1,2) / Fs;
            else
                Fc1 = F(1,2) / Fs;
                Fc2 = F(1,1) / Fs;
            end
        end
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
        % Compute Cutoff frequencies
        [r,c] = size( F );
        if( ( r == 1 && c == 1) || ( r > 2 || c > 2 ) )
            err = "Error! Input argument *F* is not a valid array of frequencies!";
            err = err + newline + "Either provide a 1 x 2 array or a 2 x 1 array.";
            error(err);
            return;
        end
 
        if( r > c )
            if( F(1,1) < F(2,1) )
                Fc1 = F(2,1) / Fs;
                Fc2 = F(1,1) / Fs;
            else
                Fc1 = F(1,1) / Fs;
                Fc2 = F(2,1) / Fs;
            end
        else
            if( F(1,1) < F(1,2) )
                Fc1 = F(1,2) / Fs;
                Fc2 = F(1,1) / Fs;
            else
                Fc1 = F(1,1) / Fs;
                Fc2 = F(1,2) / Fs;
            end
        end

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
        H = Hlp + Hhp;
    else
        error("Unknown Type of filter");
        return;
    end
end
