function patchData = patchBetweenCurves(xData, curveOne, curveTwo, patchColor, faceAlpha)
%     if nargin > 2
%         xData = varargin{1};
%         curveOne = varargin{2};
%         curveTwo = varargin{3};
%         
%     end

    % make patch
    yP=[curveOne, fliplr(curveTwo)];
    xP=[xData, fliplr(xData)];

    %remove nans otherwise patch won't work
    xP(isnan(yP))=[];
    yP(isnan(yP))=[];

    patchData = patch(xP, yP, 1, 'facecolor', patchColor, ...
                  'edgecolor', 'none', ...
                  'facealpha', faceAlpha) ...
                  ;




end