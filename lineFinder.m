function line_detected_img = lineFinder(orig_img, hough_img, hough_threshold)
    fig = figure();
    imshow(orig_img);

    [H, W] = size(orig_img);    
    [N_rho, N_theta] = size(hough_img);

	% --------------------------------------
	% START ADDING YOUR CODE HERE
	% --------------------------------------
	
	strong_hough_img = hough_img > hough_threshold;
	d = floor(sqrt(H*H +W*W));
    for i = 1:N_rho
        for j = 1: N_theta
            if strong_hough_img(i, j) > 0
            	
            	x = [-W/2, W/2];
                y = [0, 0];
                
            	% generate some points for the line
                y(1) = ((i * d/N_rho)- d/2  + x(1) * sind(j))/cosd(j);
                y(2) = ((i * d/N_rho)- d/2  + x(2) * sind(j))/cosd(j);
           
            	% and draw on the figure
                hold on;
                line(x + W/2 , y + H/2,'Color','red', 'LineWidth', 3)
            	
            end
        end
    end
    
    % ---------------------------
    % END YOUR CODE HERE    
    % ---------------------------

    % provided in demoMATLABTricksFun.m
    line_detected_img = saveAnnotatedImg(fig);
    close(fig);
end
