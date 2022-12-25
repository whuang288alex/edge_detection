function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
	% output array
    hough_img = zeros(rho_num_bins, theta_num_bins);
	
    [H, W] = size(img);

	% coordinate system
    [x, y] = meshgrid(1:W, 1:H);
    
    % ---------------------------
    % START ADDING YOUR CODE HERE
    % ---------------------------

    % YOU CAN MODIFY/REMOVE THE PART BELOW IF YOU WANT
    % ------------------------------------------------
    % here we assume origin = middle of image, not top-left corner
    % you can fix the top-left corner too (just remove the part below)
    centre_x = floor(W/2);
    centre_y = floor(H/2);
    x = x - centre_x;
    y = y - centre_y;
    d = floor(sqrt(H*H +W*W));
    % ------------------------------------------------
    
    % img is an edge image
    x_edge = x(img > 0);
    y_edge = y(img > 0);
    % Calculate rho and theta for the edge pixels
    for i = 1 : size(x_edge, 1)
        for theta = 1 : theta_num_bins
            rho = round(y_edge(i) * cosd(theta) - x_edge(i) * sind(theta));
            rho = round((rho + d/2) * (rho_num_bins/d ));
            hough_img(rho,theta) = hough_img(rho,theta)+ 1;
        end
    end
    % Map to an index in the hough_img array
    % and accumulate votes.
    
    % ---------------------------
    % END YOUR CODE HERE    
    % ---------------------------
end
