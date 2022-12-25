function runHw2(varargin)
% runHw2 is the "main" interface that lets you execute all the 
% walkthroughs and challenges in homework 2. It lists a set of 
% functions corresponding to the problems that need to be solved.
%
% This file also serves as specifications for the functions 
% you are asked to implement. In some cases, your submissions will be autograded. 
% Thus, it is critical that you adhere to all the specified function signatures.
%
% Before your submssion, make sure you can run runHw2('all') 
% without any error.
%
% Usage:
% runHw2                       : list all the registered functions
% runHw2('function_name')      : execute a specific test
% runHw2('all')                : execute all the registered functions

% Settings to make sure images are displayed without borders.
orig_imsetting = iptgetpref('ImshowBorder');
iptsetpref('ImshowBorder', 'tight');
temp1 = onCleanup(@()iptsetpref('ImshowBorder', orig_imsetting));

fun_handles = {@honesty, @walkthrough1, ...
    @challenge1a, @challenge1b, @challenge1c, @challenge1d};
% Call test harness
runTests(varargin, fun_handles);

%--------------------------------------------------------------------------
% Academic Honesty Policy
%--------------------------------------------------------------------------
%%
function honesty()
% Type your full name and uni (both in string) to state your agreement 
% to the Code of Academic Integrity.
signAcademicHonestyPolicy('Alex Huang', 'whuang288');

%--------------------------------------------------------------------------
% Tests for Walkthrough 1: Image processing
%--------------------------------------------------------------------------
%%
function walkthrough1()
hw2_walkthrough1;

%--------------------------------------------------------------------------
% Tests for Challenge 1: Hough transform
%--------------------------------------------------------------------------
%%
function challenge1a()
img_list = {'hough_1', 'hough_2', 'hough_3'};
for i = 1:length(img_list)
    img = imread([img_list{i} '.png']);
    edge_img = edge(img);
    imwrite(im2double(edge_img), ['edge_' img_list{i} '.png']);
end

%%
function challenge1b()
img_list = {'hough_1', 'hough_2', 'hough_3'};

rho_num_bins = 750;
theta_num_bins = 180;
for i = 1:length(img_list)
    img = imread(['edge_' img_list{i} '.png']);
    hough_accumulator = generateHoughAccumulator(img,...
        theta_num_bins, rho_num_bins);
    imwrite(uint8(hough_accumulator), ['accumulator_' img_list{i} '.png']);
end

%%
function challenge1c()

img_list = {'hough_1', 'hough_2', 'hough_3'};
hough_threshold = [120, 120, 100];

for i = 1:length(img_list)
    orig_img = imread([img_list{i} '.png']);
    hough_img = imread(['accumulator_' img_list{i} '.png']);
    line_img = lineFinder(orig_img, hough_img, hough_threshold(i));
    imwrite(uint8(line_img), ['line_' img_list{i} '.png']);
end

%%
function challenge1d()

img_list = {'hough_1', 'hough_2', 'hough_3'};
hough_threshold = [120, 120, 100];

for i = 1:length(img_list)
    orig_img = imread([img_list{i} '.png']);
    hough_img = imread(['accumulator_' img_list{i} '.png']);
    line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold(i));       
    imwrite(uint8(line_img), ['croppedline_' img_list{i} '.png'])
end
