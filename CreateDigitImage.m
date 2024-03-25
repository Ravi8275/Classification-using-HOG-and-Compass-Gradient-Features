
function pixels = CreateDigitImage(num, fontname, noisefactor)
set(groot, 'defaultTextInterpreter', 'latex');
    if nargin < 1
        num = 1;
        fontname = 'times';
        noisefactor = 1;
    elseif nargin < 2
        fontname = 'times';
        noisefactor = 1;
    end

    fonts = listfonts;
    avail = any(strcmpi(fontname, fonts));

    if ~avail
        error('MachineLearning:CreateDigitImage', 'Sorry, the font ''%s'' is not available.', fontname);
    end

    f = figure('Name', 'Digit', 'Visible', 'off');
    a1 = axes('Parent', f, 'Box', 'off', 'Units', 'pixels', 'Position', [0 0 16 16]);
   text(a1, 3.5, 6, num2str(num), 'fontsize', 10, 'fontunits', 'pixels', 'unit', 'pixels', 'fontname', fontname, 'Interpreter', 'Tex');

    % Obtain image data using print and convert to grayscale
    cData = print('-RGBImage', '-r0');
    iGray = rgb2gray(cData);

    % Print image coordinate system starts from the upper left of the figure,
    % NOT the bottom, so our digit is in the LAST 16 rows and the FIRST 16 columns
    pixels = iGray(end-15:end, 1:16);

    % Apply Poisson (shot) noise; must convert the pixel values to double for
    % the operation and then convert them back to uint8 for the sum.
    % The uint8 type will automatically handle overflow above 255 so there is
    % no need to apply a limit.
    noise = uint8(sqrt(double(pixels)) .* noisefactor .* randn(16, 16));
    pixels = pixels - noise;

    close(f);

    if nargout == 0
        h = figure('Name', 'Digit Image');
        imagesc(pixels);
        colormap(h, 'gray');
        grid on;
        set(gca, 'XTick', 1:16);
        set(gca, 'YTick', 1:16);
        colorbar;
    end
end
