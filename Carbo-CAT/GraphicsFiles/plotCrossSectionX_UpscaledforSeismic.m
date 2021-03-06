function plotCrossSectionX_UpscaledforSeismic(strataUpscaled,colInd)

crossSectionPlot=figure('Visible','off');

x = 40;
% x = 78;
y = size(strataUpscaled,1);
z = size(strataUpscaled,3);
newStrata = zeros(y,z);
newStrata = strataUpscaled(:,x,:);
newStrata = squeeze(newStrata);

clear strataUpscaled
strataUpscaled = newStrata;
strataUpscaled = interp2(strataUpscaled,5);

y = size(strataUpscaled,1);
z = size(strataUpscaled,2);

it  = z;



% thicknessPerY = sum(glob.numberOfLayers(:,x,2:end),3); %SAVED
% long = find(thicknessPerY>0, 1, 'last' );
% if isempty(long)
% long = glob.ySize;
% end
long = y;

maxDepth = min(min(strataUpscaled(:,1))); % Find the lowest (ie deepest) values in strata array
maxDepth = maxDepth - 5;


% % Draw basement
% for y = 1:long 
%     xco = [y,y,y+1,y+1]; 
%     zco = [maxDepth, glob.strata(y,x,1), glob.strata(y,x,1), maxDepth];
% %     patch(xco, zco, [0.7 0.7 0.7],'EdgeColor','none');
%     patch(xco, zco, [0.7 0.7 0.7],'EdgeColor','none','FaceAlpha',.15); %% set trans
% end

    
% for y = 1:long
% 
%    for k=2:it
% 
%     cell=glob.numberOfLayers(y,x,k);
% 
%     while cell>0
%         xco = [y,y,y+1,y+1];
% 
%         allThick=sum(glob.thickness{y,x,k}(1:cell));
%         oneThick=sum(glob.thickness{y,x,k}(1:cell-1));
%         top=glob.strata(y,x,k-1)+allThick;
%         bottom=glob.strata(y,x,k-1)+oneThick;
%         fCode = glob.facies{y,x,k}(cell); % Note this is zero for no depositon, 9 for subaerial hiatus
% 
% 
%         % Draw the insitu production facies first
%         if fCode>0
%             zco = [bottom, top,top, bottom];
%             faciesCol=[glob.faciesColours(fCode,2) glob.faciesColours(fCode,3) glob.faciesColours(fCode,4)]    ;
% %             patch(xco, zco, faciesCol,'EdgeColor','none');
%             patch(xco, zco, faciesCol,'EdgeColor','none','FaceAlpha',.15); %% set trans
%         end
% 
%         cell=cell-1;
%     end
%    end
% end

% Loop through iterations and draw timelines

 
% glob.timeLineAge = [100:150:3000];
glob.timeLineAge = [1:1250:it];

glob.timeLineCount= size(glob.timeLineAge,2);  

    for i=1:glob.timeLineCount

        k = glob.timeLineAge(i);

        if k <= it
            for y = 1:long-1%glob.ySize-1
                % draw a marker line across the top and down/up the side of
                % a particular grid cell
                xco = [y,y+1,y+1];
                yco = [strataUpscaled(y,k), strataUpscaled(y,k), strataUpscaled(y+1,k)];
%                 line(xco, yco, 'LineWidth',2, 'color', 'black');  
                if colInd == 1
                line(xco, yco, 'LineWidth',3, 'color', 'black');  
                else
                line(xco, yco, 'LineWidth',3, 'color', 'red'); 
                end
            end
%             line([y+1,y+2],[glob.strata(y+1,x,k), glob.strata(y+1,x,k)],'LineWidth',2, 'color', 'black');
             if colInd == 1
            line([y+1,y+2],[strataUpscaled(y+1,k), strataUpscaled(y+1,k)],'LineWidth',3, 'color', 'black');
             else
            line([y+1,y+2],[strataUpscaled(y+1,k), strataUpscaled(y+1,k)],'LineWidth',3, 'color', 'red');
             end
 
        end
    end

% % Draw the final sea-level
% xco = [1 long+1];
% yco = [glob.SL(it) glob.SL(it)];
% line(xco,yco, 'LineWidth',2, 'color', 'blue');



ylabel('Elevation (m)','FontSize',24,'FontWeight','bold');
xlabel('y(km)','FontSize',24,'FontWeight','bold');
ax = gca;
ax.LineWidth = 0.6;
ax.FontSize = 20;
ax.FontWeight = 'bold';
%     set(crossSectionPlot,'XTickLabel',[]);

xticks([1 10 20 30 40 50 60 70 80 90 100]);
xticklabels (0:2:20);
axis tight

axis off
    
%% General
% set figure position and dimension
width = 125;     % Width in inches
height = 85;    % Height in inches
set(crossSectionPlot, 'Position', [0.5 0.5 width*20, height*10]); %<- Set size


%% Save image using save_fig

set(crossSectionPlot,'Color','none'); % set transparent background
set(gca,'Color','none');

export_fig( sprintf('xCrossSectionForSeismicUpscaled%d',colInd),... 
   '-png', '-transparent', '-m12', '-q101');
    
 
    
end