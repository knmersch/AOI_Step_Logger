% load your aoifits data file.  Since this is a binary file, you need the
% -mat suffix.  Make sure you have the proper path since Windows/Mac use
% different slashes.  In this case, I renamed that data file to data.dat
% becasue Matlab does not do well with spaces in the path


clear all
close all

prompt = 'Enter the filename of the .dat file you would like to load do not include the file extension ' ;
filename = input(prompt, 's');
s1 = '/Users/mersch/Documents/MATLAB/data/'; %change this path to where your files are
s2 = filename;
s3 = '.dat';
s4 = '.txt';
s5 = '_counts';
s1andtwo = strcat(s1,s2,s3);
load(s1andtwo, '-mat');


% Now you will see a structure called "aoifits" in the Workspace.  If you
% type aoifits, you will see all of the information associated with this
% structure.  These substructures can have strings, or other matrices
% associated.  The aoifits.data is an array that contains all of the
% timeseries data from your entire analysis.

% The number of aois in the file
naois = aoifits.aoiinfo2(end,6);

% The number of frames in the timeseries
framefirst=aoifits.data(1,2);
framelast=aoifits.data(end,2);
nframes=framelast-framefirst+1;

% Note that naois * nframes is equal to the number of rows in aoifits.data.
% That is because it is a bunch of matrices concatenated together.  The
% first naois number of rows represent the first frame in the entire time
% series.

fileID = fopen(strcat(s2,s5,s4), 'w');
%fprintf(fileID, 'AOI# Step# OneStep TwoStep Three+ Ambiguous\n');

for i=1:naois

    % The time series for a particular aoi    
    ts = aoifits.data(i:naois:end,:);
    

    % Plot intensity vs time
    figure(1)
    plot(ts(:,2),ts(:,8),'r');
    title(['AOI# ' num2str(i)]) 
    

    %k=1; % do not comment this line out
    %k = waitforbuttonpress;
    %value = double(get(gcf,'CurrentCharacter'))
    
    prompt = 'Enter the Numer of Photobleaching Steps (i.e, 1,2, or 3+ no = 0) ' ;
    keyboardpress = input(prompt, 's');
       if keyboardpress == 48;
       keyboardpress = 0;
       elseif keyboardpress == 49;
       keyboardpress = 1;
       elseif keyboardpress == 50;
       keyboardpress = 2;
       elseif keyboardpress == 51;
       keyboardpress = 3;
       else
          disp 'NOT REAL INPUT!!TRY AGAIN!!';
          keyboardpress = input(prompt, 's');
            if keyboardpress == 48;
            keyboardpress = 0;
            elseif keyboardpress == 49;
            keyboardpress = 1;
            elseif keyboardpress == 50;
            keyboardpress = 2;
            elseif keyboardpress == 51;
            keyboardpress = 3;
            else
                disp 'THIS IS YOUR LAST CHANCE';
                keyboardpress = input(prompt, 's');
                if keyboardpress == 48;
                keyboardpress = 0;
                elseif keyboardpress == 49;
                keyboardpress = 1;
                elseif keyboardpress == 50;
                keyboardpress = 2;
                elseif keyboardpress == 51;
                keyboardpress = 3;
                else
                    disp 'Maybe You Should Walk Around A While';
                    return
                end
            end
       end
                   
    x = keyboardpress;
    y = num2str(i);
    %z = sum(x(:) == 1);
    
    fprintf(fileID,'%s,%d\n',y,x);
       
    
end
fclose(fileID);

fileID = fopen(strcat(s2,s5,s4), 'a+');
A = load(strcat(s2,s5,s4));

z = nnz(A(:,2)==1);
a = nnz(A(:,2)==2);
b = nnz(A(:,2)==3); 
c = nnz(A(:,2)==0);
x = 'space';
y = 'space';

fprintf(fileID,'%s,%s,%d,%d,%d,%d\n',x,y,z,a,b,c);
fprintf(fileID, 'AOI#,Step#,OneStep,TwoStep,Three+,Ambiguous');

fclose(fileID);

Laozi = 'The Journey of a Thousand Miles Begins with One Step'

