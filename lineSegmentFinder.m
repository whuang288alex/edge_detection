function cropped_line_img = lineSegmentFinder(orig_img, hough_img, hough_threshold)
    
    fig = figure();
    imshow(orig_img);

    [H, W] = size(orig_img); 
    d = floor(sqrt(H*H +W*W));
    [N_rho, N_theta] = size(hough_img); 
    [x, y] = meshgrid(1:W, 1:H);
    
    % adjust the origin of the coordinate system
    x = x - floor(W/2);
    y = y - floor(H/2);

    %get the edges
    gray_img = im2gray(orig_img);
    edge_img = edge(gray_img);

    %get edges coordinates
    x_edge = x(edge_img > 0);
    y_edge = y(edge_img > 0);

    % --------------------------------------
    % START ADDING YOUR CODE HERE
    % --------------------------------------
    
    strong_hough_img = hough_img > hough_threshold;

    for i = 1:N_rho
        for j = 1: N_theta
            if strong_hough_img(i, j) > 0 
                minX = NaN;
                maxX = NaN;
                theta = j;
                rho = i;
                for k = 1 : size(x_edge, 1)
                    temp = round(y_edge(k) * cosd(theta) - x_edge(k)*sind(theta));
                    temp = round((temp + d/2) * (N_rho/d));
                    if temp == rho
                        if isnan(minX) || x_edge(k) < minX
                            minX  = x_edge(k);
                        end
                        if isnan(maxX) || x_edge(k) > maxX
                            maxX  = x_edge(k);
                        end
                    end
                end

                x = [minX, maxX];
                y = [((rho * d/N_rho)- d/2 + x(1) * sind(theta))/cosd(theta), ((rho * d/N_rho)- d/2 + x(2) * sind(theta))/cosd(theta)];
                hold on;
                line(x + W/2 , y + H/2 ,'Color','red', 'LineWidth', 3)
            end
        end
    end

    % ---------------------------
    % END YOUR CODE HERE 
    % ---------------------------
    % provided in demoMATLABTricksFun.m
    cropped_line_img = saveAnnotatedImg(fig);
    close(fig);
end
