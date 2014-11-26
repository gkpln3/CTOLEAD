function [MLplatenum,SLplatenum] = findnumbers(sumPeaks,idx2num)

Threshold = 0.58;
MLplatenum = zeros(1,7)-1;
SLplatenum = MLplatenum;
numloc = 1;
gapfactor = 1;
prevnum = -1;
ind = 1;
maxdist = 6;
lastnum = 1; %last time we saw a number
% lastpeak = 1; %last correlation peack
while(ind < size(sumPeaks,2))
    if (numloc > 7)
        break
    end
    if(~isempty(find(sumPeaks(:,ind)>Threshold, 1)))
        [numcorr,bestfit] = max(sumPeaks(:,ind));
        %         lastpeak = 1;
        if((numloc == 3))
            gapflag = 1;
        else
            gapflag = 0;
        end
        switch (prevnum)
            case -1
                MLplatenum(numloc) = idx2num(bestfit(1));
                prevnum = MLplatenum(numloc);
                lastcorr = numcorr;
                ind = ind + 1;
                lastnum = 1; %last time we saw a number
                numloc = numloc + 1;
            case {0,2,3,4,5,6,7,8,9}
                if((lastcorr < numcorr) && (lastnum == 1))
                    MLplatenum(numloc-1) = idx2num(bestfit(1));
                    prevnum = MLplatenum(numloc-1);
                    lastcorr = numcorr;
                    ind = ind + 1;
                    lastnum = 1;
                elseif(lastnum == 1)
                    SLplatenum(numloc - 1) = idx2num(bestfit(1));
                    ind = ind + 1;
                    lastnum = lastnum + 1;
                    prevpeak = numcorr;
                else
                    if((numcorr > prevpeak) && ((gapflag == 0) || (lastnum >= ngap * gapfactor)))
                        MLplatenum(numloc) = idx2num(bestfit(1));
                        if(numloc == 2)
                            ngap = lastnum;
                        end
                        prevnum = MLplatenum(numloc);
                        lastcorr = numcorr;
                        ind = ind + 1;
                        lastnum = 1;
                        numloc = numloc + 1;
                        
                    else
                        ind = ind + 1;
                        lastnum = lastnum + 1;
                    end
                end
            case 1
                if((gapflag == 0) || (lastnum >= ngap * gapfactor))
                    MLplatenum(numloc) = idx2num(bestfit(1));
                    if(numloc == 2)
                        ngap = lastnum;
                    end
                    prevnum = MLplatenum(numloc);
                    lastcorr = numcorr;
                    ind = ind + 1;
                    lastnum = 1;
                    numloc = numloc + 1;
                else
                    ind = ind +1;
                    lastnum = lastnum + 1;
                end
                
        end
    else
        if(lastnum > maxdist)
            %           lastpeak = 1;
            lastnum = 1;
            numloc = 1;
            prevnum = -1;
        end
        lastnum = lastnum + 1;
        %        lastpeak = lastpeak + 1;
        ind = ind + 1;
        prevpeak = 0;
        
    end
end

